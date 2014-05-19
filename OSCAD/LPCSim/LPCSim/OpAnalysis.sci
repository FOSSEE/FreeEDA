// OpAnalysis.sci is a scilab file to perform Operating point Analysis. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
// It is modified by Yogesh Dilip Save for OSCAD Software on October 2012

function [A,B,x]=OPAnalysis(A,B)
  global displayNLFlag;
  global g;
  global model;
  global LPCSim_HOME;
// Find node potetial and current through devices whose device characteristic can not be expressed in terms of voltage
  x=findNodePotential(A,B);

// Find branch voltage from node potential
  voltage=findBranchVoltage(x);

// Find branch current from branch voltage using device characteristic
  current=findBranchCurrent(x,voltage);

  if(NLFlag) then
    if symbolic then
      if displayNLFlag then
        mprintf("-----------------------------------------------------------\n");
        mprintf("Application of Newton-Raphson method: \n");
        disp('Nonliner models:');
        Edges=edge_number(g);
        X=1;
        for edge_cnt = 1:Edges,
          if(g.edges.data.type(edge_cnt)=='D')
            tempModel=model(X);
            Is=tempModel(2); Vt=tempModel(3);
            X=X+1;
            devName=strsplit(g.edges.data.devName(edge_cnt),1);
            devSubscript=devName(2);
            mprintf("See linearized model for diode D%s in diode_D%s.eps\n",devSubscript,devSubscript); 
            unix_g('cp '+LPCSim_HOME+'/diode_Dref.pstex .');
            unix_g('cp '+LPCSim_HOME+'/diode_Dref.pstex_t .');
            unix_g('cp '+LPCSim_HOME+'/latfont* .');
            unix_g(LPCSim_HOME+'/nonlinearDevice.sh ' + devSubscript);
            displayNLFlag=%F;
          end
        end
        [Asymb,Bsymb,Csymb,xsymb]=buildMatricesSymbLin(_T);
        if displayMatrix then
          mprintf("The system of equations Ax=b (Symbolically):\n");
          mprintf("Where Ax=b represents equations after linearization of nonlinear elements.\n");
          mprintf("-----------------------------------------------------------\n");
          disp(xsymb,"x=",Bsymb,"B=",Asymb,"A=");
          pause;
        end
      end
    end
      
    for i=1:MaxNRitr
// Check device characteristic of non-linear devices
      flag=checkForDeviceChar(voltage,current);
      if(flag) break; end
// Call Newton Raphson method to update the value of linearized model of nonlinear devices
      [A,B]=NR(A,B,voltage,current,i-1);
      if displayMatrix then
        mprintf("-----------------------------------------------------------\n");
        mprintf("Operating Point (DC) Analysis: \n");
        mprintf("NR Iteration: %d \n",i);
        mprintf("The system of equations Ax=b (Numerically):\n");
        mprintf("-----------------------------------------------------------\n");
        format('e',10);
        disp(B,"B=",A,"A=");
      end

      x=findNodePotential(A,B);
      if displayMatrix then
        mprintf("-----------------------------------------------------\n");
        mprintf("The solution of the circuit x:\n");
        mprintf("-----------------------------------------------------\n");
        format('e',10);
        disp(x,"x=");
        pause;
      end
      voltage=findBranchVoltage(x);
      current=findBranchCurrent(x,voltage);
    end
  end
endfunction

function x=findNodePotential(A,B)
// START: Solving Ax=B for Node potential x
  A_sparse=sparse(A);   
  x=lusolve(A_sparse,B);
  clear A_sparse;
// END: Solving Ax=B for x
endfunction

function voltage=findBranchVoltage(x)
// Find voltages of complete network 
  global g;
  Edges=edge_number(g);
  voltage=zeros(Edges,1)
  for edge_cnt = 1:Edges,
     if(g.edges.head(edge_cnt)==1)
  	voltage(edge_cnt)=x(g.edges.tail(edge_cnt)-1);
     elseif(g.edges.tail(edge_cnt)==1)
  	voltage(edge_cnt)=-x(g.edges.head(edge_cnt)-1);
     else 
  	voltage(edge_cnt)=x(g.edges.tail(edge_cnt)-1)-x(g.edges.head(edge_cnt)-1);
     end     
  end
endfunction

function current=findBranchCurrent(x,voltage)
  global g;
  T=1;
  Nodes=node_number(g);
  Edges=edge_number(g);
  current=zeros(Edges,1)
  for edge_cnt = 1:Edges,
     if(g.edges.data.type(edge_cnt)=='R'|g.edges.data.type(edge_cnt)=='D'|g.edges.data.type(edge_cnt)=='X'|g.edges.data.type(edge_cnt)=='M')
  	current(edge_cnt)=g.edges.data.value(edge_cnt)*voltage(edge_cnt);
     elseif(g.edges.data.type(edge_cnt)=='V')
  	current(edge_cnt)=x(Nodes-1+T);
  	T=T+1;
     elseif(g.edges.data.type(edge_cnt)=='E')
  	current(edge_cnt)=x(Nodes-1+T);
  	T=T+1;
     elseif(g.edges.data.type(edge_cnt)=='F')
  	current(edge_cnt)=x(Nodes-1+T);
  	T=T+1;
     elseif(g.edges.data.type(edge_cnt)=='H')
  	current(edge_cnt)=x(Nodes-1+T);
  	T=T+1;
     elseif(g.edges.data.type(edge_cnt)=='G')
  	current(edge_cnt)=voltage(edge_cnt+1)*g.edges.data.value(edge_cnt);
     else      
  	current(edge_cnt)=g.edges.data.value(edge_cnt);
     end
  end
endfunction
