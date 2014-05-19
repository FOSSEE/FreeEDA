// buildMatricesSymbolic.sci is a scilab file to build equations of the circuit symbolically. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
// It is modified by Yogesh Dilip Save for OSCAD Software on October 2012
warning('off');
function [A,B,D,C,x,fx]=buildMatricesSymbolic(_T)
// Create Matrice A,  D, C and  vector b corresponding to circuit equation
   global g;
   global('model')
   Nodes=node_number(g);
   Edges=edge_number(g);
   A = emptystr(Nodes-1+_T,Nodes-1+_T);
   D = emptystr(Nodes-1+_T,length(model));
   C = emptystr(Nodes-1+_T,Nodes-1+_T);
   B = emptystr(Nodes-1+_T,1);
   x = emptystr(Nodes-1+_T,1);
   fx = emptystr(length(model),1);
   
   _T=1;
   X=1;
   controlledSourceFlag=%F
   for i=1:Nodes-1,
     x(i,1)="v_"+ msprintf("%d",i)
   end
   for edge_cnt = 1:edge_number(g),
      if(controlledSourceFlag)
        controlledSourceFlag=%F
        continue
      end
      source=g.edges.tail(edge_cnt)-1;
      sink=g.edges.head(edge_cnt)-1;
      value=g.edges.data.devName(edge_cnt);
      select (g.edges.data.type(edge_cnt))
      case 'R' then   // Resistor
       if(~(source==0)) 
         A(source,source) = A(source,source) + "+"+ value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) +"+"+ value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) +"-"+ value;
         A(sink,source) = A(sink,source) +"-"+ value;
       end

      case 'I' then  // Current source
        if(sscanf(value, "%c")=='I')
          if(~(source==0)) 
            B(source) = B(source)+"-"+value;
          end
          if(~(sink==0)) 
            B(sink) =B(sink) +"+"+ value;
          end
        end

      case 'V' then // Voltage source
       if(~(source==0))
         A(Nodes-1+_T,source) = "1";
         A(source,Nodes-1+_T) = "1";
       end
       if(~(sink==0))
         A(Nodes-1+_T,sink) = "-1";
         A(sink,Nodes-1+_T) = "-1";
       end  
       B(Nodes-1+_T) = value;
       x(Nodes-1+_T)="i_"+ value;
       _T=_T+1; 
       
      case 'C' then // Capacitor
        if(~(source==0)) 
          C(source,source) = C(source,source) +"+"+ value;
        end
        if(~(sink==0)) 
          C(sink,sink) = C(sink,sink) +" + "+ value;
        end
        if(~(sink==0) & ~(source==0))
          C(source,sink) = C(source,sink) +"-"+value;
          C(sink,source) = C(sink,source) +"-"+value;
        end
       
      case 'D' then // Diode
       if(~(source==0)) 
         D(source,X) = value+"_f";
       end
       if(~(sink==0)) 
         D(sink,X) = "-"+ value+"_f";
       end
       if(source==0) 
         fx(X)="(v_"+string(sink)+")";
       elseif(sink==0)
         fx(X)="(v_"+string(source)+")";
       else
         fx(X)="(v_"+string(source)+",v_"+string(sink)+")";
       end
       X=X+1;
       
      case 'G' then // Voltage controlled current source
       if(~(source==0)) 
         if(~(g.edges.tail(edge_cnt+1)-1==0))
           A(source,g.edges.tail(edge_cnt+1)-1) = A(source,g.edges.tail(edge_cnt+1)-1) +"+"+ convstr(value,'l');
         end
         if(~(g.edges.head(edge_cnt+1)-1==0))
            A(source,g.edges.head(edge_cnt+1)-1) = A(source,g.edges.head(edge_cnt+1)-1) +"-"+ convstr(value,'l');
         end
       end
       if(~(sink==0)) 
         if(~(g.edges.tail(edge_cnt+1)==1))
            A(sink,g.edges.tail(edge_cnt+1)-1) = A(sink,g.edges.tail(edge_cnt+1)-1) +"-"+ convstr(value,'l');
         end
         if(~(g.edges.head(edge_cnt+1)-1==0))
            A(sink,g.edges.head(edge_cnt+1)-1) = A(sink,g.edges.head(edge_cnt+1)-1) +"+"+ convstr(value,'l');
         end
       end
       controlledSourceFlag=%T
       
      case 'E' then  // Voltage controlled voltage source
       if(~(source==0))
         A(source,Nodes-1+_T) = "1";
         A(Nodes-1+_T,source) = "1";
        if(~(g.edges.tail(edge_cnt+1)-1==0))
          A(Nodes-1+_T,g.edges.tail(edge_cnt+1)-1) = convstr(value,'l');
        end
        if(~(g.edges.head(edge_cnt+1)==1))
          A(Nodes-1+_T,g.edges.head(edge_cnt+1)-1) = "-"+convstr(value,'l');
        end
       end
       if(~(sink==0))
          A(sink,Nodes-1+_T) = "-1";
          A(Nodes-1+_T,sink) = "-1";
          if(~(g.edges.tail(edge_cnt+1)-1==0))
            A(Nodes-1+_T,g.edges.tail(edge_cnt+1)-1) = "-"+convstr(value,'l');
          end
          if(~(g.edges.head(edge_cnt+1)-1==0))
            A(Nodes-1+_T,g.edges.head(edge_cnt+1)-1) = convstr(value,'l');
          end
       end  
       x(Nodes-1+_T)="i_"+ value;
       _T=_T+1;
       controlledSourceFlag=%T
        
      case 'F' then  // Current controlled current source
        A(Nodes-1+_T,Nodes-1+_T) = 1;
        A(Nodes-1+_T,Nodes-1+_T-1) = "-"+convstr(value,'l');
        if(~(source==0))
          A(source,Nodes-1+_T) = 1;
        end
        if(~(sink==0))
          A(sink,Nodes-1+_T) = -1;
        end  
        x(Nodes-1+_T)="i_"+ value;
        _T=_T+1;
         
      case 'H' then // Current controlled voltage source
        A(Nodes-1+_T,Nodes-1+_T-1) = "-"+convstr(value,'l');
        if(~(source==0))
          A(source,Nodes-1+_T) = "1";
          A(Nodes-1+_T,source) = "1";
        end
        if(~(sink==0))
          A(sink,Nodes-1+_T) = "-1";
          A(Nodes-1+_T,sink) = "-1";
        end  
        x(Nodes-1+_T)="i_"+ value;
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
         A(source,source) = A(source,source) +" + "+ value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) +" + "+ value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) +" - "+value;
         A(sink,source) = A(sink,source) +" - "+value;
       end
  
     else
        exit(0);
      end
   end
   _T=_T-1;   

   firstValue=%T
   mprintf("-----------------------------------------------------------\n");
   mprintf("System of Equations representing the electrical circuit:\n");
   mprintf("-----------------------------------------------------------\n");
// Fill zero entries
   for i=1:Nodes-1+_T,
     mprintf("\n     ");
     for j=1:Nodes-1+_T,
       if(length(A(i,j))==0)
         A(i,j)="0";
       elseif(sscanf(A(i,j), "%c")=='+')
         tempstr=strsplit(A(i,j),1);
         A(i,j)=tempstr(2);
         if firstValue then
           if ~(strcmp(A(i,j),'1')) then 
             mprintf("%s",x(j));
           else
             mprintf("(%s)%s",A(i,j),x(j));
           end
           firstValue=%F;
         else
           if ~(strcmp(A(i,j),'1')) then 
             mprintf(" + %s",x(j));
           else
             mprintf(" + (%s)%s",A(i,j),x(j));
           end
         end
       else
         if firstValue then
           if ~(strcmp(A(i,j),'1')) then 
             mprintf("%s",x(j));
           else
             mprintf("(%s)%s",A(i,j),x(j));
           end
           firstValue=%F;
         else
           if ~(strcmp(A(i,j),'1')) then 
             mprintf(" + %s",x(j));
           else
             mprintf(" + (%s)%s",A(i,j),x(j));
           end
         end
       end
       if(length(C(i,j))==0)
         C(i,j)="0";
       elseif(sscanf(C(i,j), "%c")=='+')
         tempstr=strsplit(C(i,j),1);
         C(i,j)=tempstr(2);
         if firstValue then
           mprintf("(%s)d%s/dt",C(i,j),x(j));
           firstValue=%F;
         else
           mprintf(" + (%s)d%s/dt",C(i,j),x(j));
         end
       else
         if firstValue then
           mprintf("(%s)d%s/dt",C(i,j),x(j));
           firstValue=%F;
         else
           mprintf(" + (%s)d%s/dt",C(i,j),x(j));
         end
       end
     end
     for j=1:length(model),
       if(length(D(i,j))==0)
         D(i,j)="0";
       elseif(firstValue)
         mprintf("%s%s",D(i,j),fx(j));
         firstValue=%F;
       else
          mprintf(" + %s%s",D(i,j),fx(j));
       end
     end
     if(length(B(i,1))==0)
       B(i,1)="0";
     elseif(sscanf(B(i,1), "%c")=='+')
       tempstr=strsplit(B(i,1),1);
       B(i,1)=tempstr(2);
     end
     mprintf(" = %s\n",B(i,1));
     firstValue=%T
   end
   global('NLFlag');
   if NLFlag then
     mprintf("-----------------------------------------------------------\n");
     mprintf(" Dn_f(v_a,v_b)=Is_n(1-e^((v_a-v_b)/vt_n))\n where Is_n=reverse saturation current and vt_n=threshold voltage of diode n\n")
   end
   mprintf("-----------------------------------------------------------\n");
endfunction

function [A,B,D,x,fx]=buildMatricesSymbStatic(_T)
global('currentAnalysis');
// Create Matrice A,  D, C and  vector b corresponding to circuit equation
   global g;
   global('model')
   Nodes=node_number(g);
   Edges=edge_number(g);
   A = emptystr(Nodes-1+_T,Nodes-1+_T);
   D = emptystr(Nodes-1+_T,length(model));
   B = emptystr(Nodes-1+_T,1);
   x = emptystr(Nodes-1+_T,1);
   fx = emptystr(length(model),1);
   
   _T=1;
   X=1;
   controlledSourceFlag=%F
   for i=1:Nodes-1,
     x(i,1)="v_"+ msprintf("%d",i)
   end
   for edge_cnt = 1:edge_number(g),
      if(controlledSourceFlag)
        controlledSourceFlag=%F
        continue
      end
      source=g.edges.tail(edge_cnt)-1;
      sink=g.edges.head(edge_cnt)-1;
      value=g.edges.data.devName(edge_cnt);
      select (g.edges.data.type(edge_cnt))
      case 'R' then   // Resistor
       if(~(source==0)) 
         A(source,source) = A(source,source) + "+"+ value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) +"+"+ value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) +"-"+ value;
         A(sink,source) = A(sink,source) +"-"+ value;
       end

      case 'I' then  // Current source
        if(sscanf(value, "%c")=='I')
          if(~(source==0)) 
            B(source) = B(source)+"-"+value;
          end
          if(~(sink==0)) 
            B(sink) =B(sink) +"+"+ value;
          end
        elseif((sscanf(value, "%c")=='C') & currentAnalysis)
          if(~(source==0)) 
            B(source) = B(source)+"-i_"+value;
          end
          if(~(sink==0)) 
            B(sink) =B(sink) +"+i_"+ value;
          end
        end
       
      case 'V' then // Voltage source
       if(~(source==0))
         A(Nodes-1+_T,source) = "1";
         A(source,Nodes-1+_T) = "1";
       end
       if(~(sink==0))
         A(Nodes-1+_T,sink) = "-1";
         A(sink,Nodes-1+_T) = "-1";
       end  
       B(Nodes-1+_T) = value;
       x(Nodes-1+_T)="i_"+ value;
       _T=_T+1; 
       
      case 'C' then // Capacitor
        if currentAnalysis then 
          if(~(source==0)) 
            A(source,source) = A(source,source) +"+R_"+ value;
          end
          if(~(sink==0)) 
            A(sink,sink) = A(sink,sink) +"+R_"+ value;
          end
          if(~(sink==0) & ~(source==0))
            A(source,sink) = A(source,sink) +"-R_"+value;
            A(sink,source) = A(sink,source) +"-R_"+value;
          end
        end
       
      case 'D' then // Diode
       if(~(source==0)) 
         D(source,X) = value+"_f";
       end
       if(~(sink==0)) 
         D(sink,X) = "-"+ value+"_f";
       end
       if(source==0) 
         fx(X)="(v_"+string(sink)+")";
       elseif(sink==0)
         fx(X)="(v_"+string(source)+")";
       else
         fx(X)="(v_"+string(source)+",v_"+string(sink)+")";
       end
       X=X+1;
       
      case 'G' then // Voltage controlled current source
       if(~(source==0)) 
         if(~(g.edges.tail(edge_cnt+1)-1==0))
           A(source,g.edges.tail(edge_cnt+1)-1) = A(source,g.edges.tail(edge_cnt+1)-1) +"+"+ convstr(value,'l');
         end
         if(~(g.edges.head(edge_cnt+1)-1==0))
            A(source,g.edges.head(edge_cnt+1)-1) = A(source,g.edges.head(edge_cnt+1)-1) +"-"+ convstr(value,'l');
         end
       end
       if(~(sink==0)) 
         if(~(g.edges.tail(edge_cnt+1)==1))
            A(sink,g.edges.tail(edge_cnt+1)-1) = A(sink,g.edges.tail(edge_cnt+1)-1) +"-"+ convstr(value,'l');
         end
         if(~(g.edges.head(edge_cnt+1)-1==0))
            A(sink,g.edges.head(edge_cnt+1)-1) = A(sink,g.edges.head(edge_cnt+1)-1) +"+"+ convstr(value,'l');
         end
       end
       controlledSourceFlag=%T
       
      case 'E' then  // Voltage controlled voltage source
       if(~(source==0))
         A(source,Nodes-1+_T) = "1";
         A(Nodes-1+_T,source) = "1";
        if(~(g.edges.tail(edge_cnt+1)-1==0))
          A(Nodes-1+_T,g.edges.tail(edge_cnt+1)-1) = convstr(value,'l');
        end
        if(~(g.edges.head(edge_cnt+1)==1))
          A(Nodes-1+_T,g.edges.head(edge_cnt+1)-1) = "-"+convstr(value,'l');
        end
       end
       if(~(sink==0))
          A(sink,Nodes-1+_T) = "-1";
          A(Nodes-1+_T,sink) = "-1";
          if(~(g.edges.tail(edge_cnt+1)-1==0))
            A(Nodes-1+_T,g.edges.tail(edge_cnt+1)-1) = "-"+convstr(value,'l');
          end
          if(~(g.edges.head(edge_cnt+1)-1==0))
            A(Nodes-1+_T,g.edges.head(edge_cnt+1)-1) = convstr(value,'l');
          end
       end  
       x(Nodes-1+_T)="i_"+ value;
       _T=_T+1;
       controlledSourceFlag=%T
        
      case 'F' then  // Current controlled current source
        A(Nodes-1+_T,Nodes-1+_T) = 1;
        A(Nodes-1+_T,Nodes-1+_T-1) = "-"+convstr(value,'l');
        if(~(source==0))
          A(source,Nodes-1+_T) = 1;
        end
        if(~(sink==0))
          A(sink,Nodes-1+_T) = -1;
        end  
        x(Nodes-1+_T)="i_"+ value;
        _T=_T+1;
         
      case 'H' then // Current controlled voltage source
        A(Nodes-1+_T,Nodes-1+_T-1) = "-"+convstr(value,'l');
        if(~(source==0))
          A(source,Nodes-1+_T) = "1";
          A(Nodes-1+_T,source) = "1";
        end
        if(~(sink==0))
          A(sink,Nodes-1+_T) = "-1";
          A(Nodes-1+_T,sink) = "-1";
        end  
        x(Nodes-1+_T)="i_"+ value;
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
         A(source,source) = A(source,source) +" + "+ value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) +" + "+ value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) +" - "+value;
         A(sink,source) = A(sink,source) +" - "+value;
       end
  
     else
        exit(0);
      end
   end
   _T=_T-1;   

   firstValue=%T
   mprintf("-----------------------------------------------------------\n");
   mprintf("System of Equations representing the electrical circuit:\n");
   mprintf("-----------------------------------------------------------\n");
// Fill zero entries
   for i=1:Nodes-1+_T,
     mprintf("\n     ");
     for j=1:Nodes-1+_T,
       if(length(A(i,j))==0)
         A(i,j)="0";
       elseif(sscanf(A(i,j), "%c")=='+')
         tempstr=strsplit(A(i,j),1);
         A(i,j)=tempstr(2);
         if firstValue then
           if ~(strcmp(A(i,j),'1')) then 
             mprintf("%s",x(j));
           else
             mprintf("(%s)%s",A(i,j),x(j));
           end
           firstValue=%F;
         else
           if ~(strcmp(A(i,j),'1')) then 
             mprintf(" + %s",x(j));
           else
             mprintf(" + (%s)%s",A(i,j),x(j));
           end
         end
       else
         if firstValue then
           if ~(strcmp(A(i,j),'1')) then 
             mprintf("%s",x(j));
           else
             mprintf("(%s)%s",A(i,j),x(j));
           end
           firstValue=%F;
         else
           if ~(strcmp(A(i,j),'1')) then 
             mprintf(" + %s",x(j));
           else
             mprintf(" + (%s)%s",A(i,j),x(j));
           end
         end
       end
     end
     for j=1:length(model),
       if(length(D(i,j))==0)
         D(i,j)="0";
       elseif(firstValue)
         mprintf("%s%s",D(i,j),fx(j));
         firstValue=%F;
       else
          mprintf(" + %s%s",D(i,j),fx(j));
       end
     end
     if(length(B(i,1))==0)
       B(i,1)="0";
     elseif(sscanf(B(i,1), "%c")=='+')
       tempstr=strsplit(B(i,1),1);
       B(i,1)=tempstr(2);
     end
     mprintf(" = %s\n",B(i,1));
     firstValue=%T
   end
   if NLFlag then
     mprintf("-----------------------------------------------------------\n");
     mprintf(" Dn_f(v_a,v_b)=Is_n(1-e^((v_a-v_b)/vt_n))\n where Is_n=reverse saturation current and vt_n=threshold voltage of diode n\n")
   end
   mprintf("-----------------------------------------------------------\n");
endfunction

function [A,B,C,x]=buildMatricesSymbLin(_T)
// Create Matrice A,  D, C and  vector b corresponding to circuit equation
   global g;
   global('currentAnalysis');
   Nodes=node_number(g);
   A = emptystr(Nodes-1+_T,Nodes-1+_T);
   C = emptystr(Nodes-1+_T,Nodes-1+_T);
   B = emptystr(Nodes-1+_T,1);
   x = emptystr(Nodes-1+_T,1);
   
   _T=1;
   controlledSourceFlag=%F
   for i=1:Nodes-1,
     x(i,1)="v_"+ msprintf("%d",i)
   end
   for edge_cnt = 1:edge_number(g),
      if(controlledSourceFlag)
        controlledSourceFlag=%F
        continue
      end
      source=g.edges.tail(edge_cnt)-1;
      sink=g.edges.head(edge_cnt)-1;
      value=g.edges.data.devName(edge_cnt);
      select (g.edges.data.type(edge_cnt))
      case 'R' then   // Resistor
       if(~(source==0)) 
         A(source,source) = A(source,source) + "+"+ value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) +"+"+ value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) +"-"+ value;
         A(sink,source) = A(sink,source) +"-"+ value;
       end

      case 'I' then  // Current source
        if(sscanf(value, "%c")=='I')
          if(~(source==0)) 
            B(source) = B(source)+"-"+value;
          end
          if(~(sink==0)) 
            B(sink) =B(sink) +"+"+ value;
          end
        elseif(~(sscanf(value, "%c")=='C') | currentAnalysis)
          if(~(source==0)) 
            B(source) = B(source)+"-i_"+value;
          end
          if(~(sink==0)) 
            B(sink) =B(sink) +"+i_"+ value;
          end
        end
       
      case 'V' then // Voltage source
       if(~(source==0))
         A(Nodes-1+_T,source) = "1";
         A(source,Nodes-1+_T) = "1";
       end
       if(~(sink==0))
         A(Nodes-1+_T,sink) = "-1";
         A(sink,Nodes-1+_T) = "-1";
       end  
       B(Nodes-1+_T) = value;
       x(Nodes-1+_T)="i_"+ value;
       _T=_T+1; 
       
      case 'C' then // Capacitor
        if currentAnalysis then
          if(~(source==0)) 
            C(source,source) = C(source,source) +"+"+ value;
          end
          if(~(sink==0)) 
            C(sink,sink) = C(sink,sink) +" + "+ value;
          end
          if(~(sink==0) & ~(source==0))
            C(source,sink) = C(source,sink) +"-"+value;
            C(sink,source) = C(sink,source) +"-"+value;
          end
        end
       
      case 'D' then // Diode
       if(~(source==0)) 
         A(source,source) = A(source,source) +"+R_"+ value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) +"+R_"+ value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) +"-R_"+ value;
         A(sink,source) = A(sink,source) +"-R_"+ value;
       end
       
      case 'G' then // Voltage controlled current source
       if(~(source==0)) 
         if(~(g.edges.tail(edge_cnt+1)-1==0))
           A(source,g.edges.tail(edge_cnt+1)-1) = A(source,g.edges.tail(edge_cnt+1)-1) +"+"+ convstr(value,'l');
         end
         if(~(g.edges.head(edge_cnt+1)-1==0))
            A(source,g.edges.head(edge_cnt+1)-1) = A(source,g.edges.head(edge_cnt+1)-1) +"-"+ convstr(value,'l');
         end
       end
       if(~(sink==0)) 
         if(~(g.edges.tail(edge_cnt+1)==1))
            A(sink,g.edges.tail(edge_cnt+1)-1) = A(sink,g.edges.tail(edge_cnt+1)-1) +"-"+ convstr(value,'l');
         end
         if(~(g.edges.head(edge_cnt+1)-1==0))
            A(sink,g.edges.head(edge_cnt+1)-1) = A(sink,g.edges.head(edge_cnt+1)-1) +"+"+ convstr(value,'l');
         end
       end
       controlledSourceFlag=%T
       
      case 'E' then  // Voltage controlled voltage source
       if(~(source==0))
         A(source,Nodes-1+_T) = "1";
         A(Nodes-1+_T,source) = "1";
        if(~(g.edges.tail(edge_cnt+1)-1==0))
          A(Nodes-1+_T,g.edges.tail(edge_cnt+1)-1) = convstr(value,'l');
        end
        if(~(g.edges.head(edge_cnt+1)==1))
          A(Nodes-1+_T,g.edges.head(edge_cnt+1)-1) = "-"+convstr(value,'l');
        end
       end
       if(~(sink==0))
          A(sink,Nodes-1+_T) = "-1";
          A(Nodes-1+_T,sink) = "-1";
          if(~(g.edges.tail(edge_cnt+1)-1==0))
            A(Nodes-1+_T,g.edges.tail(edge_cnt+1)-1) = "-"+convstr(value,'l');
          end
          if(~(g.edges.head(edge_cnt+1)-1==0))
            A(Nodes-1+_T,g.edges.head(edge_cnt+1)-1) = convstr(value,'l');
          end
       end  
       x(Nodes-1+_T)="i_"+ value;
       _T=_T+1;
       controlledSourceFlag=%T
        
      case 'F' then  // Current controlled current source
        A(Nodes-1+_T,Nodes-1+_T) = 1;
        A(Nodes-1+_T,Nodes-1+_T-1) = "-"+convstr(value,'l');
        if(~(source==0))
          A(source,Nodes-1+_T) = 1;
        end
        if(~(sink==0))
          A(sink,Nodes-1+_T) = -1;
        end  
        x(Nodes-1+_T)="i_"+ value;
        _T=_T+1;
         
      case 'H' then // Current controlled voltage source
        A(Nodes-1+_T,Nodes-1+_T-1) = "-"+convstr(value,'l');
        if(~(source==0))
          A(source,Nodes-1+_T) = 1;
          A(Nodes-1+_T,source) = 1;
        end
        if(~(sink==0))
          A(sink,Nodes-1+_T) = -1;
          A(Nodes-1+_T,sink) = -1;
        end  
        x(Nodes-1+_T)="i"+ value;
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
         A(source,source) = A(source,source) +" + "+ value;
       end
       if(~(sink==0)) 
         A(sink,sink) = A(sink,sink) +" + "+ value;
       end
       if(~(sink==0) & ~(source==0))
         A(source,sink) = A(source,sink) +" - "+value;
         A(sink,source) = A(sink,source) +" - "+value;
       end
  
     else
        exit(0);
      end
   end
   _T=_T-1;   

   firstValue=%T
   mprintf("-----------------------------------------------------------\n");
   mprintf("System of Equations representing the electrical circuit:\n");
   mprintf("-----------------------------------------------------------\n");
// Fill zero entries
   for i=1:Nodes-1+_T,
     mprintf("\n     ");
     for j=1:Nodes-1+_T,
       if(length(A(i,j))==0)
         A(i,j)="0";
       elseif(sscanf(A(i,j), "%c")=='+')
         tempstr=strsplit(A(i,j),1);
         A(i,j)=tempstr(2);
         if firstValue then
           if ~(strcmp(A(i,j),'1')) then 
             mprintf("%s",x(j));
           else
             mprintf("(%s)%s",A(i,j),x(j));
           end
           firstValue=%F;
         else
           if ~(strcmp(A(i,j),'1')) then 
             mprintf(" + %s",x(j));
           else
             mprintf(" + (%s)%s",A(i,j),x(j));
           end
         end
       else
         if firstValue then
           if ~(strcmp(A(i,j),'1')) then 
             mprintf("%s",x(j));
           else
             mprintf("(%s)%s",A(i,j),x(j));
           end
           firstValue=%F;
         else
           if ~(strcmp(A(i,j),'1')) then 
             mprintf(" + %s",x(j));
           else
             mprintf(" + (%s)%s",A(i,j),x(j));
           end
         end
       end
     end
     if(length(B(i,1))==0)
       B(i,1)="0";
     elseif(sscanf(B(i,1), "%c")=='+')
       tempstr=strsplit(B(i,1),1);
       B(i,1)=tempstr(2);
     end
     mprintf(" = %s\n",B(i,1));
     firstValue=%T
   end
   mprintf("-----------------------------------------------------------\n");
endfunction
