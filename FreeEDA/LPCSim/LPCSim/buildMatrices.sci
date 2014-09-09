// buildMatrices.sci is a scilab file to construct a system matrix representing the circuit equations. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

function [A,B]=buildMatrices(_T)
   ///////////////////////////////////////////////////////////////////////////////
   // Create Matrice A and  vector B corresponding to circuit equation
   global g;
   Nodes=node_number(g);
   A = zeros(Nodes-1+_T,Nodes-1+_T);
   B = zeros(Nodes-1+_T,1);
   
   _T=1;
   for edge_cnt = 1:edge_number(g),
      source=g.edges.tail(edge_cnt)-1;
      sink=g.edges.head(edge_cnt)-1;
      value=g.edges.data.value(edge_cnt);
      select (g.edges.data.type(edge_cnt))
      case 'R' then   // Resistor
       if(~(source==0)) 
         A(source,source) = A(source,source) + value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) + value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) - value;
         A(sink,source) = A(sink,source) - value;
       end

      case 'I' then  // Current source
       if(~(source==0)) 
         B(source) = B(source)-value;
       end
       if(~(sink==0)) 
         B(sink) =B(sink) + value;
       end
       
      case 'V' then // Voltage source
       if(~(source==0))
         A(Nodes-1+_T,source) = 1;
         A(source,Nodes-1+_T) = 1;
       end
       if(~(sink==0))
         A(Nodes-1+_T,sink) = -1;
         A(sink,Nodes-1+_T) = -1;
       end  
       B(Nodes-1+_T) = value;
       _T=_T+1; 
       
      case 'C' then // Capacitor
       if(~(source==0)) 
         A(source,source) = A(source,source) + value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) + value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) - value;
         A(sink,source) = A(sink,source) - value;
       end
       
      case 'D' then // Diode
       if(~(source==0)) 
         A(source,source) = A(source,source) + value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) + value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) - value;
         A(sink,source) = A(sink,source) - value;
       end
       
      case 'G' then // Voltage controlled current source
       if(~(source==0)) 
         if(~(g.edges.tail(edge_cnt+1)-1==0))
           A(source,g.edges.tail(edge_cnt+1)-1) = A(source,g.edges.tail(edge_cnt+1)-1) + value;
         end
         if(~(g.edges.head(edge_cnt+1)-1==0))
            A(source,g.edges.head(edge_cnt+1)-1) = A(source,g.edges.head(edge_cnt+1)-1) - value;
         end
       end
       if(~(sink==0)) 
         if(~(g.edges.tail(edge_cnt+1)==1))
            A(sink,g.edges.tail(edge_cnt+1)-1) = A(sink,g.edges.tail(edge_cnt+1)-1) - value;
         end
         if(~(g.edges.head(edge_cnt+1)-1==0))
            A(sink,g.edges.head(edge_cnt+1)-1) = A(sink,g.edges.head(edge_cnt+1)-1) + value;
         end
       end
       
      case 'E' then  // Voltage controlled voltage source
       if(~(source==0))
         A(source,Nodes-1+_T) = 1;
         A(Nodes-1+_T,source) = 1;
        if(~(g.edges.tail(edge_cnt+1)-1==0))
          A(Nodes-1+_T,g.edges.tail(edge_cnt+1)-1) = value;
        end
        if(~(g.edges.head(edge_cnt+1)==1))
          A(Nodes-1+_T,g.edges.head(edge_cnt+1)-1) = - value;
        end
       end
       if(~(sink==0))
          A(sink,Nodes-1+_T) = -1;
          A(Nodes-1+_T,sink) = -1;
          if(~(g.edges.tail(edge_cnt+1)-1==0))
            A(Nodes-1+_T,g.edges.tail(edge_cnt+1)-1) = -value;
          end
          if(~(g.edges.head(edge_cnt+1)-1==0))
            A(Nodes-1+_T,g.edges.head(edge_cnt+1)-1) = value;
          end
       end  
       _T=_T+1;
        
      case 'F' then  // Current controlled current source
        A(Nodes-1+_T,Nodes-1+_T) = 1;
        A(Nodes-1+_T,Nodes-1+_T-1) = -value;
        if(~(source==0))
          A(source,Nodes-1+_T) = 1;
        end
        if(~(sink==0))
          A(sink,Nodes-1+_T) = -1;
        end  
        _T=_T+1;
         
      case 'H' then // Current controlled voltage source
        A(Nodes-1+_T,Nodes-1+_T-1) = -value;
        if(~(source==0))
          A(source,Nodes-1+_T) = 1;
          A(Nodes-1+_T,source) = 1;
        end
        if(~(sink==0))
          A(sink,Nodes-1+_T) = -1;
          A(Nodes-1+_T,sink) = -1;
        end  
        _T=_T+1;
        
      case 'M' then  // MOSFET
       if(~(source==0)) 
         A(source,source) = A(source,source) + value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) + value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) - value;
         A(sink,source) = A(sink,source) - value;
       end
       
      case 'X' then   // User defined component
       if(~(source==0)) 
         A(source,source) = A(source,source) + value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) + value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) - value;
         A(sink,source) = A(sink,source) - value;
       end
  
     else
        exit(0);
      end
   end
endfunction

function [A,B]=buildMatrices2(g,x)
   ///////////////////////////////////////////////////////////////////////////////
   // Create Matrices A and B 
   Nodes=node_number(g);
   _T=0;
   for edge_cnt = 1:edge_number(g),
     if(g.edges.data.type(edge_cnt)=='V'|g.edges.data.type(edge_cnt)=='E'|g.edges.data.type(edge_cnt)=='H'|g.edges.data.type(edge_cnt)=='C')
       _T=_T+1;
     end
   end
   A = zeros(Nodes+_T-1,Nodes+_T-1);
   B = zeros(Nodes+_T-1,1);
   
   _T=1;
   for edge_cnt = 1:edge_number(g),
      source=g.edges.tail(edge_cnt)-1;
      sink=g.edges.head(edge_cnt)-1;
      value=g.edges.data.value(edge_cnt);
      select (g.edges.data.type(edge_cnt))
      case 'R' then // Resistor
       if(~(source==0)) 
         A(source,source) = A(source,source) + value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) + value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) - value;
         A(sink,source) = A(sink,source) - value;
       end
       
      case 'M' then // MOSFET
       if(~(source==0)) 
         A(source,source) = A(source,source) + value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) + value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) - value;
         A(sink,source) = A(sink,source) - value;
       end
       
      case 'C' then  // Capacitor
       if(~(source==0))
         A(Nodes-1+_T,source) = 1;
         A(source,Nodes-1+_T) = 1;
       end
       if(~(sink==0))
         A(Nodes-1+_T,sink) = -1;
         A(sink,Nodes-1+_T) = -1;
       end  
       if(~(source==0))
         B(Nodes-1+_T) = B(Nodes-1+_T)+x(source);
       end
       if(~(sink==0))
         B(Nodes-1+_T) = B(Nodes-1+_T)-x(sink);
       end
       _T=_T+1;
        
      case 'D' then // Diode
       if(~(source==0)) 
         A(source,source) = A(source,source) + value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) + value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) - value;
         A(sink,source) = A(sink,source) - value;
       end
       
      case 'G' then // Voltage controlled current source
       if(~(source==0)) 
         if(~(g.edges.tail(edge_cnt+1)-1==0))
           A(source,g.edges.tail(edge_cnt+1)-1) = A(source,g.edges.tail(edge_cnt+1)-1) + value;
         end
         if(~(g.edges.head(edge_cnt+1)-1==0))
           A(source,g.edges.head(edge_cnt+1)-1) = A(source,g.edges.head(edge_cnt+1)-1) - value;
         end
       end
       if(~(sink==0)) 
         if(~(g.edges.tail(edge_cnt+1)==1))
           A(sink,g.edges.tail(edge_cnt+1)-1) = A(sink,g.edges.tail(edge_cnt+1)-1) - value;
         end
         if(~(g.edges.head(edge_cnt+1)-1==0))
           A(sink,g.edges.head(edge_cnt+1)-1) = A(sink,g.edges.head(edge_cnt+1)-1) + value;
         end
       end
       
      case 'I' then // Current source
       if(~(source==0)) 
         B(source) = B(source)-value;
       end
       if(~(sink==0)) 
         B(sink) =B(sink) + value;
       end
       
      case 'V' then // Voltage Source
       if(~(source==0))
         A(Nodes-1+_T,source) = 1;
         A(source,Nodes-1+_T) = 1;
       end
       if(~(sink==0))
         A(Nodes-1+_T,sink) = -1;
         A(sink,Nodes-1+_T) = -1;
       end  
         B(Nodes-1+_T) = value;
         _T=_T+1; 
     
      case 'E' then
       if(~(source==0))
   	 A(source,Nodes-1+_T) = 1;
   	 A(Nodes-1+_T,source) = -1;
   	 if(~(g.edges.tail(edge_cnt+1)-1==0))
   	   A(Nodes-1+_T,g.edges.tail(edge_cnt+1)-1) = value;
   	 end
   	 if(~(g.edges.head(edge_cnt+1)==1))
   	   A(Nodes-1+_T,g.edges.head(edge_cnt+1)-1) = - value;
   	 end
       end
       if(~(sink==0))
   	 A(sink,Nodes-1+_T) = -1;
   	 A(Nodes-1+_T,sink) = 1;
   	 if(~(g.edges.tail(edge_cnt+1)-1==0))
   	   A(Nodes-1+_T,g.edges.tail(edge_cnt+1)-1) = -value;
   	 end
   	 if(~(g.edges.head(edge_cnt+1)-1==0))
   	   A(Nodes-1+_T,g.edges.head(edge_cnt+1)-1) = value;
   	 end
       end  
       _T=_T+1; 
      case 'F' then
       A(Nodes-1+_T,Nodes-1+_T) = 1;
       A(Nodes-1+_T,Nodes-1+_T-1) = -value;
       if(~(source==0))
   	 A(source,Nodes-1+_T) = 1;
       end
       if(~(sink==0))
   	 A(sink,Nodes-1+_T) = -1;
       end  
       _T=_T+1; 
      case 'H' then
       A(Nodes-1+_T,Nodes-1+_T-1) = -value;
       if(~(source==0))
   	 A(source,Nodes-1+_T) = 1;
   	 A(Nodes-1+_T,source) = 1;
       end
       if(~(sink==0))
   	 A(sink,Nodes-1+_T) = -1;
   	 A(Nodes-1+_T,sink) = -1;
       end  
       _T=_T+1; 
      else
       exit(0);
      end
   end
endfunction

function [A,B]=buildMatrices3(g)
   ///////////////////////////////////////////////////////////////////////////////
   // Create Matrices A and B 
   Nodes=node_number(g);
   _T=0;
   for edge_cnt = 1:edge_number(g),
     if(g.edges.data.type(edge_cnt)=='V'|g.edges.data.type(edge_cnt)=='E'|g.edges.data.type(edge_cnt)=='H')
       _T=_T+1;
     end
   end
   A = zeros(Nodes+_T-1,Nodes+_T-1);
   B = zeros(Nodes+_T-1,1);
   
   _T=1;
   for edge_cnt = 1:edge_number(g),
      source=g.edges.tail(edge_cnt)-1;
      sink=g.edges.head(edge_cnt)-1;
      value=g.edges.data.value(edge_cnt);
      select (g.edges.data.type(edge_cnt))
      case 'R' then
       if(~(source==0)) 
         A(source,source) = A(source,source) + value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) + value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) - value;
         A(sink,source) = A(sink,source) - value;
       end
      case 'I' then
       if(~(source==0)) 
   	 B(source) = B(source)-value;
       end
       if(~(sink==0)) 
   	 B(sink) =B(sink) + value;
       end
      case 'V' then
       if(~(source==0))
   	 A(Nodes-1+_T,source) = 1;
   	 A(source,Nodes-1+_T) = 1;
       end
       if(~(sink==0))
   	 A(Nodes-1+_T,sink) = -1;
   	 A(sink,Nodes-1+_T) = -1;
       end  
       B(Nodes-1+_T) = value;
       _T=_T+1; 
      case 'E' then
       if(~(source==0))
   	 A(source,Nodes-1+_T) = 1;
   	 A(Nodes-1+_T,source) = -1;
   	 if(~(g.edges.tail(edge_cnt+1)-1==0))
   	   A(Nodes-1+_T,g.edges.tail(edge_cnt+1)-1) = value;
   	 end
   	 if(~(g.edges.head(edge_cnt+1)==1))
   	   A(Nodes-1+_T,g.edges.head(edge_cnt+1)-1) = - value;
   	 end
       end
       if(~(sink==0))
   	 A(sink,Nodes-1+_T) = -1;
   	 A(Nodes-1+_T,sink) = 1;
   	 if(~(g.edges.tail(edge_cnt+1)-1==0))
   	   A(Nodes-1+_T,g.edges.tail(edge_cnt+1)-1) = -value;
   	 end
   	 if(~(g.edges.head(edge_cnt+1)-1==0))
   	   A(Nodes-1+_T,g.edges.head(edge_cnt+1)-1) = value;
   	 end
       end  
       _T=_T+1; 
      case 'H' then
       A(Nodes-1+_T,Nodes-1+_T-1) = -value;
       if(~(source==0))
   	 A(source,Nodes-1+_T) = 1;
   	 A(Nodes-1+_T,source) = 1;
       end
       if(~(sink==0))
   	 A(sink,Nodes-1+_T) = -1;
   	 A(Nodes-1+_T,sink) = -1;
       end  
       _T=_T+1; 
      else
       exit(0);
      end
   end
endfunction
