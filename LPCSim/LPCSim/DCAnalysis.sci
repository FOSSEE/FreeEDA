// DCAnalysis.sci is a scilab file to perform DC Analysis. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

function [A,B,x]=DCAnalysis(A,B,_X,s)
// Modify Sweep Source Value and update matrices
  [A,B]=modifySourceValue(A,B,s);  
// Perform Operating Point Analysis on static circuit
  [A,B,x]=OPAnalysis(A,B);
endfunction

function [A,B]=modifySourceValue(A,B,s); 
  global g;
  global wave;
  waveIndex=1;  
  _T=1;
  Edges=edge_number(g);
  Nodes=node_number(g);
  for edge_cnt = 1:Edges,
    if(g.edges.data.type(edge_cnt)=='V')
      tempWave=wave(waveIndex);
      if(tempWave(1)=='dc')
        waveIndex=waveIndex+1;   
      elseif(tempWave(1)=='sweep')
        waveIndex=waveIndex+1;  
        g.edges.data.value(edge_cnt)=s;
        B(Nodes-1+_T) = g.edges.data.value(edge_cnt);
      elseif(tempWave(1)=='sine')
        waveIndex=waveIndex+1;
      end  
      _T=_T+1; 	  
      clear tempWave;
      elseif(g.edges.data.type(edge_cnt)=='I')
      tempWave=wave(waveIndex);
      if(tempWave(1)=='dc')
        waveIndex=waveIndex+1;   
      elseif(tempWave(1)=='sine')
        waveIndex=waveIndex+1;  
      elseif(tempWave(1)=='sweep')
        waveIndex=waveIndex+1;
        oldCurrent=g.edges.data.value(edge_cnt);
        g.edges.data.value(edge_cnt)=s;
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
    end
  end
endfunction

