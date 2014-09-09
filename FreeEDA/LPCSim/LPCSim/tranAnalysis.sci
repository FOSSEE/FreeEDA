// tranAnalysis.sci is a scilab file to perform Transient Analysis. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.


function [A,B,x]=transientAnalysis(A,B,x,t,i)
  global LPCSim_HOME;
  exec(LPCSim_HOME+'discretization.sci',-1);
  MaxNRitr=50;
  if(i-2)
// Discretize time dependent component and update matrices
  	[A,B]=discretization(A,B,x,t,i);

// Perform Operating Point Analysis on static circuit
  	[A,B,x]=OPAnalysis(A,B);

// Store Output Variable for plotting/printing 
        buildOutput(x,t,i);
   else
// Perform Operating Point Analysis on static circuit at t=0+
  // Build Modified Nodal Matrix for linear devices
        [C,d]=buildMatrices2(g,x);

  // Perform Operating Point Analysis on static circuit
  	[C,d,x]=OPAnalysis(C,d);

  // Store Output Variable for plotting/printing 
        buildOutput(x,t,i);
   end
endfunction 

function [x]=setIntialCondition(K,y,x,_T,UIC)
// Compute fictitious node potential at t=0 
  global g;
  _C=1;
  first_edge=%t;
  Nodes=node_number(g);
  nodeCovered=zeros(Nodes,1);
  xnew=zeros(Nodes,1);
  Edges=1;

// Build a tree of Voltage sources
  for edge_cnt = 1:edge_number(g),
    if(g.edges.data.type(edge_cnt)=='V'|g.edges.data.type(edge_cnt)=='E'|g.edges.data.type(edge_cnt)=='H')
      source=g.edges.tail(edge_cnt);
      sink=g.edges.head(edge_cnt);
      if(first_edge)
      	g1 = make_graph('mygraph1',1,Nodes,source,sink);
        g1 = add_edge_data(g1,'voltage');
        g1 = add_edge_data(g1,'number');
        if(g.edges.data.type(edge_cnt)=='V')
          g1.edges.data.voltage(Edges) = g.edges.data.value(edge_cnt);
        else
          g1.edges.data.voltage(Edges) = x(source)-x(sink);
        end
        g1.edges.data.number(Edges) = edge_cnt;
        Edges=Edges+1; 
        first_edge=%f;
      else 
        g1=add_edge(source,sink,g1);
        if(g.edges.data.type(edge_cnt)=='V')
          g1.edges.data.voltage(Edges) = g.edges.data.value(edge_cnt);
        else
          g1.edges.data.voltage(Edges) = x(source)-x(sink);
        end
        g1.edges.data.number(Edges) = edge_cnt;
        Edges=Edges+1; 
      end
      if(~nodeCovered(source))
         nodeCovered(source)=1;
      end
      if(~nodeCovered(sink))
         nodeCovered(sink)=1;
      end
    end
  end
  
  chargeBalanceRequired=%f; 
// If UIC is set then use device intial condition (with highest priority)
  if(UIC==1)
 // Extend the tree by adding voltage source corresponding to capacitor with initial condition
    global cInitial;
    for edge_cnt = 1:edge_number(g),
      if(g.edges.data.type(edge_cnt)=='C')
        source=g.edges.tail(edge_cnt);
        sink=g.edges.head(edge_cnt);
        if(~nodeCovered(source))
           if(~nodeCovered(sink))
              nodeCovered(sink)=1;
           end
           nodeCovered(source)=1;
           g1=add_edge(source,sink,g1);
           g1.edges.data.voltage(Edges)=cInitial(_C);
        elseif(~nodeCovered(sink))
           nodeCovered(sink)=1;
           g1=add_edge(source,sink,g1);
           g1.edges.data.voltage(Edges)=cInitial(_C);
        else
    	 [nc,ncomp]=connex(g1);
           if(ncomp(source)~=ncomp(sink))
             g1=add_edge(source,sink,g1);
             g1.edges.data.voltage(Edges)=cInitial(_C);
           else
             g1=add_edge(source,sink,g1);
             g1.edges.data.voltage(Edges)=cInitial(_C);
             if(~chargeBalanceRequired)
               cap=list(Edges);
               chargeBalanceRequired=%t;
             else
               cap($+1)=Edges; 
             end
           end
        end
        g1.edges.data.number(Edges) = edge_cnt;
        Edges=Edges+1;
        _C=_C+1;
      end
    end 
  end 

  if(~chargeBalanceRequired)
  // Insert voltage sources corresponding to intial condition
    global initialVoltage;
    for j=1:1:length(initialVoltage);
      templist=initialVoltage(j);
      source=templist(1)+1;
      sink=1;
      if(~nodeCovered(source))
        nodeCovered(source)=1;
        g1=add_edge(source,sink,g1);
        g1.edges.data.voltage(Edges)=templist(2);
        g1.edges.data.number(Edges) = Edges;
        Edges=Edges+1;
      end 
    end
  
  // Extend the tree to complete graph  
    if(UIC==1)
       for edge_cnt = 1:edge_number(g),
         if(edge_number(g1)==Nodes-1) break; end;
         if(~(g.edges.data.type(edge_cnt)=='C'|g.edges.data.type(edge_cnt)=='V'|g.edges.data.type(edge_cnt)=='E'|g.edges.data.type(edge_cnt)=='H'|g.edges.data.type(edge_cnt)=='I'))
  	   source=g.edges.tail(edge_cnt);
  	   sink=g.edges.head(edge_cnt);
  	   if(~nodeCovered(source))
  	      if(~nodeCovered(sink))
  	         nodeCovered(sink)=1;
  	      end
  	      nodeCovered(source)=1;
  	      g1=add_edge(source,sink,g1);
  	      g1.edges.data.voltage(Edges)=0.0;
              g1.edges.data.number(Edges) = Edges;
  	      Edges=Edges+1;
  	   elseif(~nodeCovered(sink))
  	      nodeCovered(sink)=1;
  	      g1=add_edge(source,sink,g1);
  	      g1.edges.data.voltage(Edges)=0.0;
              g1.edges.data.number(Edges) = Edges;
  	      Edges=Edges+1;
  	   else
  	      [nc,ncomp]=connex(g1);
  	      if(nc==1) break; end;
  	      if(ncomp(source)~=ncomp(sink))
  	        g1=add_edge(source,sink,g1);
  	        g1.edges.data.voltage(Edges)=0.0;
                g1.edges.data.number(Edges) = Edges;
  	        Edges=Edges+1;
  	      end
  	   end
         end
       end
    else 
      for edge_cnt = 1:edge_number(g),
        if(~(g.edges.data.type(edge_cnt)=='V'|g.edges.data.type(edge_cnt)=='E'|g.edges.data.type(edge_cnt)=='H'|g.edges.data.type(edge_cnt)=='I'))
          source=g.edges.tail(edge_cnt);
          sink=g.edges.head(edge_cnt);
          if(~nodeCovered(source))
             if(~nodeCovered(sink))
                nodeCovered(sink)=1;
             end
             nodeCovered(source)=1;
             g1=add_edge(source,sink,g1);
             g1.edges.data.voltage(Edges)=0.0;
             g1.edges.data.number(Edges) = Edges;
             Edges=Edges+1;
          elseif(~nodeCovered(sink))
             nodeCovered(sink)=1;
             g1=add_edge(source,sink,g1);
             g1.edges.data.voltage(Edges)=0.0;
             g1.edges.data.number(Edges) = Edges;
             Edges=Edges+1;
          else
             [nc,ncomp]=connex(g1);
             if(nc==1) break; end;
             if(ncomp(source)~=ncomp(sink))
               g1=add_edge(source,sink,g1);
               g1.edges.data.voltage(Edges)=0.0;
               g1.edges.data.number(Edges) = Edges;
               Edges=Edges+1;
             end
          end
        end
      end
    end
 // Find the node potentials from tree branch voltages at t=0  
    g1.directed=0;
    listOfNodes=list(1);
    nodeCovered(1)=0;
    for i=1:Nodes
      predecessor=listOfNodes(i);
      neNodes=neighbors(predecessor,g1);
      [k1 k2]=size(neNodes);
      for j=1:k2
        sucessor=neNodes(j);
        if(nodeCovered(sucessor))
  	listOfNodes=lstcat(listOfNodes,sucessor);
  	nodeCovered(sucessor)=0;
  	e=nodes_2_path([predecessor sucessor],g1);
  	if(g.edges.tail(e)==predecessor)
  	  xnew(sucessor)=xnew(predecessor)-g1.edges.data.voltage(e); 
  	else
  	  xnew(sucessor)=xnew(predecessor)+g1.edges.data.voltage(e); 
  	end
        end
      end
    end
    x(1:Nodes-1,1)=xnew(2:Nodes,1);

 // Charge Balance scheme using equivalent electrical representation 
  else
   // Find the components which require charge balancing
    [nc,ncomp]=connex(g1);
    for j=1:1:length(cap),
      if(j==1)
        CBcomp=list(ncomp(g.edges.tail(g1.edges.data.number(cap(j)))));
      else
        tempBlock=ncomp(g.edges.tail(g1.edges.data.number(cap(j))));
        blockFound=%f
        for j=1:1:length(CBcomp),
           if(CBcomp(j)==tempBlock)
              blockFound=%t;
           end
        end
        if(~blockFound)
          CBcomp($+1)=ncomp(g.edges.tail(g1.edges.data.number(cap(j))));
        end
      end
    end

   // Find edge voltages of the components by operating point analysis 
    for j=1:1:length(CBcomp),
      disp(length(CBcomp));
      firstEdge=%t;
      Edges=1;
      k=1;
      _C=0;
      for i=1:Nodes
        if(ncomp(i)==CBcomp(j))
          nodeMap(k)=i;
          nodeReverseMap(i)=k;
          k=k+1;
        end
      end 
      for edge_cnt = 1:edge_number(g1),
        edge_cnt1=g1.edges.data.number(edge_cnt);
        source=g.edges.tail(edge_cnt1);
        sink=g.edges.head(edge_cnt1);
        if(g.edges.data.type(edge_cnt1)=='C')
          _C=_C+1;
        end
        if(~(ncomp(source)==CBcomp(j)))
           continue; 
        end  
        source=nodeReverseMap(source);
        sink=nodeReverseMap(sink);
        if(firstEdge) // initializing graph with first edge
           g2 = make_graph('mygraph2',1,k-1,source,sink);
           g2 = add_edge_data(g2,'type');
           g2 = add_edge_data(g2,'value');
           g2 = add_edge_data(g2,'number');
           firstEdge=%f; 
        else
           g2=add_edge(source,sink,g2);
        end
        if(g.edges.data.type(edge_cnt1)=='V')
          g2.edges.data.type(Edges) = 'V';
          g2.edges.data.value(Edges) = g.edges.data.value(edge_cnt1);
          g2.edges.data.number(Edges) = edge_cnt;
          Edges=Edges+1;
      // Replace capacitor with conductance parallel with conductance
        else
          g2.edges.data.type(Edges) = 'R'
          g2.edges.data.value(Edges) = g.edges.data.value(edge_cnt1);
          g2.edges.data.number(Edges) = edge_cnt;
          Edges=Edges+1;
          g2=add_edge(source,sink,g2);
          g2.edges.data.type(Edges) = 'I'
          g2.edges.data.value(Edges) =-g.edges.data.value(edge_cnt1)*cInitial(_C);
          g2.edges.data.number(Edges) = edge_cnt;
          Edges=Edges+1;
        end 
      end
     // Build Modified Nodal Matrix for linear devices
      [C,d]=buildMatrices3(g2);
 
     // Find node potetial 
      xnew=findNodePotential(C,d);
     
     // Find branch voltages from node potential
      Edges=edge_number(g2);
      for edge_cnt = 1:Edges,
        if(g2.edges.head(edge_cnt)==1)
          g1.edges.data.voltage(g2.edges.data.number(edge_cnt))=xnew(g2.edges.tail(edge_cnt)-1);
        elseif(g.edges.tail(edge_cnt)==1)
          g1.edges.data.voltage(g2.edges.data.number(edge_cnt))=-xnew(g2.edges.head(edge_cnt)-1);
        else 
          g1.edges.data.voltage(g2.edges.data.number(edge_cnt))=xnew(g2.edges.tail(edge_cnt)-1)-xnew(g2.edges.head(edge_cnt)-1);
        end     
      end
      clear g2;
      clear xnew;
    end  
  // Extend it to form tree of complete graph 
    Nodes=node_number(g);
    for edge_cnt = 1:edge_number(g),
      if(edge_number(g1)==Nodes-1) break; end;
      if(~(g.edges.data.type(edge_cnt)=='C'|g.edges.data.type(edge_cnt)=='V'|g.edges.data.type(edge_cnt)=='E'|g.edges.data.type(edge_cnt)=='H'|g.edges.data.type(edge_cnt)=='I'))
        source=g.edges.tail(edge_cnt);
        sink=g.edges.head(edge_cnt);
        if(~nodeCovered(source))
           if(~nodeCovered(sink))
              nodeCovered(sink)=1;
           end
           nodeCovered(source)=1;
           g1=add_edge(source,sink,g1);
           g1.edges.data.voltage(Edges)=0.0;
           g1.edges.data.number(Edges) = Edges;
           Edges=Edges+1;
        elseif(~nodeCovered(sink))
           nodeCovered(sink)=1;
           g1=add_edge(source,sink,g1);
           g1.edges.data.voltage(Edges)=0.0;
           g1.edges.data.number(Edges) = Edges;
           Edges=Edges+1;
        else
           [nc,ncomp]=connex(g1);
           if(nc==1) break; end;
           if(ncomp(source)~=ncomp(sink))
             g1=add_edge(source,sink,g1);
             g1.edges.data.voltage(Edges)=0.0;
             g1.edges.data.number(Edges) = Edges;
             Edges=Edges+1;
           end
        end
      end
    end
    
    xnew=zeros(Nodes,1);
    g1.directed=0;
    listOfNodes=list(1);
    nodeCovered(1)=0;
    for i=1:Nodes
      predecessor=listOfNodes(i);
      neNodes=neighbors(predecessor,g1);
      [k1 k2]=size(neNodes);
      for j=1:k2
        sucessor=neNodes(j);
        if(nodeCovered(sucessor))
          listOfNodes=lstcat(listOfNodes,sucessor);
          nodeCovered(sucessor)=0;
          e=nodes_2_path([predecessor sucessor],g1);
          if(g.edges.tail(e)==predecessor)
            xnew(sucessor)=xnew(predecessor)-g1.edges.data.voltage(e); 
          else
            xnew(sucessor)=xnew(predecessor)+g1.edges.data.voltage(e); 
          end
        end
      end
    end
    x(1:Nodes-1,1)=xnew(2:Nodes,1);
  end
endfunction
