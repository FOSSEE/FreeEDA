// ACAnalysis.sci is a scilab file to perform AC Analysis. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

function [A,B,x]=ACAnalysis(A,B,f)
// Modify Sweep Source Value and update matrices
  [C,d]=buildMatricesAC(A,B,f);

// Find node potetial and current through devices whose device characteristic can not be expressed in terms of voltage
  x=findNodePotential(C,d); 

// Find branch voltage from node potential
  voltage=findBranchVoltage(x);

// Find branch current from branch voltage using device characteristic
  current=findBranchCurrent(x,voltage);
endfunction

function [C,d]=buildMatricesAC(A,B,f); 
  global g;
  pi=3.14;
  _C=1;
  Edges=edge_number(g);
  Nodes=node_number(g);
  [rows cols]=size(A);
  A2 = zeros(rows,cols);
  b2 = zeros(cols,1);
  for edge_cnt = 1:Edges,
    if(g.edges.data.type(edge_cnt)=='C')
      source=g.edges.tail(edge_cnt)-1;
      sink=g.edges.head(edge_cnt)-1;
      if(~(source==0)) 
        A2(source,source) = A2(source,source)+2*pi*f*cValue(_C);
      end
      if(~(sink==0)) 
        A2(sink,sink) = A2(sink,sink)+2*pi*f*cValue(_C);
      end
      if(~(sink==0) & ~(source==0))
        A2(source,sink) = A2(source,sink)-2*pi*f*cValue(_C);
        A2(sink,source) = A2(sink,source)-2*pi*f*cValue(_C);
      end
      _C=_C+1;  
    end
  end
  C=[A -A2;A2 A];
  d=[B;b2];
endfunction

function buildDCOutput(x,s,itr)
  global vPrintList; 
  global iPrintList; 
  global sweepArray;
  global vPrintArray; 
  global iPrintArray;
  sweepArray(itr)=s;
// Store voltage output for printing  
  if(~(vPrintList(1)==0))
    fill_vPrintArray(x,itr);
    vPrintArray(itr,1)=s;
  end

// Store voltage output for plotting  
  if(~(vPlotList(1)==0))
    fill_vPlotArray(x,itr);
  end

// Store current output for printing  
  if(~(iPrintList(1)==0))
    fill_iPrintArray(x,itr);
    iPrintArray(itr,1)=s;
  end

// Store current output for plotting  
  if(~(iPlotList(1)==0))
    fill_iPlotArray(x,itr);
  end
endfunction
