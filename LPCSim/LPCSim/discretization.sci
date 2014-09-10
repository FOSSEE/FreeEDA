// discretization.sci is a scilab file to discretize time dependent components. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.


function [A,B]=discretization(A,B,x,t,i)
  global LPCSim_HOME;
  exec(LPCSim_HOME+'lib/waveform.sci',-1);
  global g;
  global wave;
  global timeArray;
  global cValue;
  waveIndex=1;  
  _T=1;
  _C=1;
  Edges=edge_number(g);
  Nodes=node_number(g);
  if(i>1) h=t-sweepArray(i-1); end

  for edge_cnt = 1:Edges,
// Compute time dependent voltage source value at time t 
    if(g.edges.data.type(edge_cnt)=='V')
      tempWave=wave(waveIndex);
      if(tempWave(1)=='DC')
        waveIndex=waveIndex+1;   
      elseif(tempWave(1)=='SWEEP')
        waveIndex=waveIndex+1;  
      elseif(tempWave(1)=='SINE'|tempWave(1)=='PULSE')
        waveIndex=waveIndex+1;
        if(tempWave(1)=='SINE')
          g.edges.data.value(edge_cnt)=sine(tempWave,t);
        else
          g.edges.data.value(edge_cnt)=pulse(tempWave,t);
        end
// Update rhs vector
        B(Nodes-1+_T) = g.edges.data.value(edge_cnt);
      end  
      _T=_T+1; 	  
      clear tempWave;
// Compute time dependent current source value at time t 
    elseif(g.edges.data.type(edge_cnt)=='I'&~(g.edges.data.type(edge_cnt-1)=='X')&~(g.edges.data.type(edge_cnt-1)=='D')&~(g.edges.data.type(edge_cnt-1)=='C'))
      tempWave=wave(waveIndex);
      if(tempWave(1)=='DC')
        waveIndex=waveIndex+1;   
      elseif(tempWave(1)=='SWEEP')
        waveIndex=waveIndex+1;  
      elseif(tempWave(1)=='SINE'|tempWave(1)=='PULSE')
        waveIndex=waveIndex+1;
        oldCurrent=g.edges.data.value(edge_cnt);
        if(tempWave(1)=='SINE')
          g.edges.data.value(edge_cnt)=sine(tempWave,t);
        else
          g.edges.data.value(edge_cnt)=pulse(tempWave,t);
        end
// Update rhs vector
        B(Nodes-1+_T) = g.edges.data.value(edge_cnt);
        source=g.edges.tail(edge_cnt)-1;
        sink=g.edges.head(edge_cnt)-1;
        if(~(source==0)) 
   	  B(source) = B(source)-(g.edges.data.value(edge_cnt)-oldCurrent);
        end
        if(~(sink==0)) 
   	  B(sink) =B(sink) + (g.edges.data.value(edge_cnt)-oldCurrent);
        end
      end   	  
      clear tempWave;
// Update conductance and current source of dynamic device
    elseif(g.edges.data.type(edge_cnt)=='C')
      if(i>1)
        if(g.edges.head(edge_cnt)==1)
           tempVoltage=x(g.edges.tail(edge_cnt)-1);
        elseif(g.edges.tail(edge_cnt)==1)
           tempVoltage=-x(g.edges.head(edge_cnt)-1);
        else 
           tempVoltage=x(g.edges.tail(edge_cnt)-1)-x(g.edges.head(edge_cnt)-1);
        end     
        Gnew=cValue(_C)/h;
        Gupdate=Gnew-g.edges.data.value(edge_cnt)
        g.edges.data.value(edge_cnt)=Gnew;
        Inew=cValue(_C)/h*tempVoltage;
        Iupdate=Inew-g.edges.data.value(edge_cnt+1); 
        g.edges.data.value(edge_cnt+1)=Inew;
// Update matrix A and rhs vector
        source=g.edges.tail(edge_cnt)-1;
        sink=g.edges.head(edge_cnt)-1;
        if(~(source==0)) 
          A(source,source) = A(source,source) + Gupdate;
            B(source) = B(source)+Iupdate;
        end
        if(~(sink==0)) 
          A(sink,sink) = A(sink,sink) + Gupdate;
            B(sink) =B(sink) - Iupdate;
        end
        if(~(sink==0) & ~(source==0))
          A(source,sink) = A(source,sink) - Gupdate;
          A(sink,source) = A(sink,source) - Gupdate;
        end
        _C=_C+1;  
      end
    end
  end
endfunction
