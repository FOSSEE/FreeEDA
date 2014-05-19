// readfile.sci is a scilab file to read a netlist of the circuit. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
// It is modified by Yogesh Dilip Save for OSCAD Software on October 2012

warning('off');

function Index=findIndexStrList(value,searchList)
  for i=1:1:length(searchList)
    if(~strcmp(searchList(i),value))
       Index=i;
       return;
    end 		    	
  end
  Index=-1;
endfunction

// Get circuit analysis option from circuit file
function [transParameter,sweep,Analysis,Nodes]=getAnalysisOption(filename)
global vPrintList;
global vPlotList;
global iPrintList;
global iPlotList;
global initialVoltage;
global dynamicFlag;
global nodeMap;

transParameter=list(0.0,0.0,0.0,0);
sweep=list(0.0,0.0,0.0);
vPrintList=list(0);
vPlotList=list(0);
iPrintList=list(0);
iPlotList=list(0);
nodeMap=list("0");
vPrintIndex=1;
vPlotIndex=1;
iPrintIndex=1;
iPlotIndex=1;
icIndex=1;
Analysis=0;

//try
// Open the circuit file
fid = mopen(filename, 'r');
if (fid == -1)
  error("cannot open file for reading");
end
Nodes=2;

while (1)
   tempStr=mgetl(fid,1);
   tempStr=stripblanks(tempStr);
   if (length(tempStr)==0)
     continue;
   end
   if (part(tempStr,1)=='*')
     continue;
   end
   tempStr=convstr(tempStr,'u');
   [dev] = sscanf(tempStr, "%s");
   if (dev=='.END')
     break;
   elseif (dev=='.INCLUDE')
     continue;
   elseif (dev=='.OP')   // Operation Point Analysis
     Analysis=0;
   elseif (dev=='.TRAN')  // Transient Analysis
     Analysis=1; UIC=0;
     [UICstr] = msscanf(tempStr, "%*s %*f %*f %*f %s");
     if(UICstr=='UIC') UIC=1; end
     [stepSize,stopTime,startTime] = sscanf(tempStr, "%*s %f %f %f");
     transParameter=list(startTime,stopTime,stepSize,UIC);
   elseif (dev=='.DC')  // DC Analysis
     Analysis=2;
     [start,stop,step] = sscanf(tempStr, "%*s %f %f %f");
     sweep=list(start,stop,step);
   elseif (dev=='.AC')  // AC Analysis
     Analysis=3;
     [axisType,NP,start,stop] = sscanf(tempStr, "%*s %s %d %f %f");
     sweep=list(start,stop,NP,axisType);
   elseif (dev=='.IC')  // intial condition
     if(icIndex==1)
       initialVoltage=list(0);
     end
     token = strtok(tempStr," ");
     while( token <> '' )
       token = strtok(" ");
       if(length(token)) 
        [NodeNumber,potential]=sscanf(token,"V(%d)=%f");
        initialVoltage(icIndex)=[NodeNumber,potential];
        icIndex=icIndex+1; 
       end
     end
// Get Output variable for printing
   elseif (dev=='.PRINT') 
     token = strtok(tempStr," ");
     while( token <> '' )
       token = strtok(" ");
       if(length(token))
         if(msscanf(token,"%c")=='V')
           if(length(strchr(token,'-')))
             if(length(strchr(token,'-'))==length(token))
               printNode=sscanf(token,"-V(%d)"); 
               vPrintList(vPrintIndex)=-findIndexStrList(string(printNode),nodeMap);
             else
               [printNode,printNode1]=sscanf(token,"V(%d)-V(%d)");
               vPrintList(vPrintIndex)=[findIndexStrList(string(printNode),nodeMap),findIndexStrList(string(printNode1),nodeMap)];
             end
           else                
             printNode=sscanf(token,"V(%d)"); 
             vPrintList(vPrintIndex)=findIndexStrList(string(printNode),nodeMap);
           end
           vPrintIndex=vPrintIndex+1;
         elseif(msscanf(token,"%c")=='I')
           if(length(strchr(token,'-')))
             printNode=msscanf(token,"-I(%*c%d)"); 
             iPrintList(iPrintIndex)=-printNode;
           else                
             printNode=msscanf(token,"I(%*c%d)"); 
             iPrintList(iPrintIndex)=printNode;
           end
           iPrintIndex=iPrintIndex+1;
         end
       end
     end
// Get Output variable for plotting
   elseif (dev=='.PLOT')
     token = strtok(tempStr," ");
     while( token <> '' )
       token = strtok(" ");
       if(length(token))
         if(msscanf(token,"%c")=='V')
           if(length(strchr(token,'-')))
             if(length(strchr(token,'-'))==length(token))
               printNode=sscanf(token,"-V(%d)"); 
               vPlotList(vPlotIndex)=-findIndexStrList(string(printNode),nodeMap);
             else
               [printNode,printNode1]=sscanf(token,"V(%d)-V(%d)");
               vPlotList(vPlotIndex)=[findIndexStrList(string(printNode),nodeMap),findIndexStrList(string(printNode1),nodeMap)];
             end
           else                
             printNode=sscanf(token,"V(%d)"); 
             vPlotList(vPlotIndex)=findIndexStrList(string(printNode),nodeMap);
           end
           vPlotIndex=vPlotIndex+1;
         elseif(msscanf(token,"%c")=='I')
           if(length(strchr(token,'-')))
             printNode=msscanf(token,"-I(%*c%d)"); 
             iPlotList(iPlotIndex)=-printNode;
           else                
             printNode=msscanf(token,"I(%*c%d)"); 
             iPlotList(iPlotIndex)=printNode;
           end
           iPlotIndex=iPlotIndex+1;
         end
       end
     end
// Find number of nodes in the circuit
   else
     devtype=sscanf(tempStr, "%c");
     if(devtype=='M')
       [source,sink,gate] = sscanf(tempStr, "%*s %s %s %s");
       Index=findIndexStrList(gate,nodeMap);
       if(Index==-1) 
         nodeMap(Nodes)=gate;
         Nodes=Nodes+1;
       end
     else
        [source,sink] = sscanf(tempStr, "%*s %s %s");
     end
     Index=findIndexStrList(source,nodeMap);
     if(Index==-1) 
       nodeMap(Nodes)=source;
       Nodes=Nodes+1;
     end
     Index=findIndexStrList(sink,nodeMap);
     if(Index==-1) 
       nodeMap(Nodes)=sink;
       Nodes=Nodes+1
     end
   end
  end
err=mclose(fid)

Nodes=Nodes-1;
//catch
//   disp("Error in circuit file. Error code:110. Exiting.......");
//   abort;
//end
endfunction

function T=convertCircuitIntoGraph(filename,Nodes)
global g;
global model;
global wave;
global iPrintList;
global iPlotList;
global cValue;
global cInitial;
global NLFlag;
global dynamicFlag;
global nodeMap;

model=list(0);
wave=list(0);
Edges=0;
T=0;
X=0;

//try
// Open the circuit file
fid=mopen(filename,'r');
firstEdge=%t
X=1;
C=1;
waveIndex=1;

// Scan each line of the circuit file
while (1)
   tempStr=mgetl(fid,1);
   tempStr=stripblanks(tempStr);
   if (length(tempStr)==0)
     continue;
   end
   if (part(tempStr,1)=='*')
     continue;
   end
   tempStr=convstr(tempStr,'u')
   [dev] = sscanf(tempStr, "%s");
   if (dev=='.END')
     break;
   elseif (dev=='.OP'|dev=='.TRAN'|dev=='.DC'|dev=='.IC'|dev=='.PLOT'|dev=='.PRINT'|dev=='.AC'|dev=='.INCLUDE')
     continue;
   else
      [sourceS, sinkS] = sscanf(tempStr, "%*s %s %s");
      source=findIndexStrList(sourceS,nodeMap);
      sink=findIndexStrList(sinkS,nodeMap);
      Edges=Edges+1;
      if(firstEdge) // initializing graph with first edge
        g = make_graph('my_graph',1,Nodes,source,sink);
        g = add_edge_data(g,'type');
        g = add_edge_data(g,'value');
        g = add_edge_data(g,'devName');
        firstEdge=%f; 
      else
        g=add_edge(source,sink,g);
      end
      [device_type] = sscanf(dev, "%c");
      g.edges.data.devName(Edges) = dev;
      select (device_type)
        case 'R' then    // Resistance
          g.edges.data.type(Edges) = device_type;
          [value] = sscanf(tempStr, "%*s %*s %*s %f"); 
          g.edges.data.value(Edges) = 1/value;
        
        case 'I' then    // Current Source
          tempWave=list(0);
          g.edges.data.type(Edges) = device_type;
          wavtype = sscanf(tempStr, "%*s %*s %*s %s");
          [wave(waveIndex),g.edges.data.value(Edges)] = getSourceParam(tempStr,wavtype);
          waveIndex=waveIndex+1;
          
        case 'V' then   // Voltage Source
          tempWave=list(0);
          g.edges.data.type(Edges) = device_type;
          Index=msscanf(tempStr, "%*c%d"); 
          wavtype1 = sscanf(tempStr, "%*s %*s %*s %s");
          wavtype2=strsplit(wavtype1,'(');
          wavtype=wavtype2(1);
          [wave(waveIndex),g.edges.data.value(Edges)] = getSourceParam(tempStr,wavtype);
          waveIndex=waveIndex+1;
          T=T+1;
       // For printing and plotting current variables    
          if(~(iPlotList(1)==0))
            Index=findIndex(Index,iPlotList);
            if(~(Index==0)) 
              iPlotList(Index)=T;
            end 
          end
          if(~(iPrintList(1)==0))
            Index=findIndex(Index,iPrintList);
            if(~(Index==0)) 
              iPrintList(Index)=T;
            end 
          end
        
        case 'G' then   // Voltage Controlled Current Source
          g.edges.data.type(Edges) = device_type;
          [sourceCS sinkCS value] = sscanf(tempStr, "%*s %*s %*s %s %s %f");
          sourceC=findIndexStrList(sourceCS,nodeMap);
          sinkC=findIndexStrList(sinkCS,nodeMap);
          g.edges.data.value(Edges) = value;
          Edges=Edges+1;
       // Add Current Source for voltage sensing
          g=add_edge(sourceC,sinkC,g); 
          g.edges.data.type(Edges) = 'I';
          g.edges.data.value(Edges) = 0;
          tempWave=list(0);
          tempWave(1)='dc';
          wave(waveIndex)=tempWave;            
          waveIndex=waveIndex+1;
          clear tempWave;
          
        case 'E' then   // Voltage Controlled Voltage Source
          g.edges.data.type(Edges) = device_type;
          [sourceCS sinkCS value] = sscanf(tempStr, "%*s %*s %*s %s %s %f");
          sourceC=findIndexStrList(sourceCS,nodeMap);
          sinkC=findIndexStrList(sinkCS,nodeMap);
          g.edges.data.value(Edges) = value;
          Edges=Edges+1;
       // Add Current Source for voltage sensing
          g=add_edge(sourceC,sinkC,g);
          g.edges.data.type(Edges) = 'I';
          g.edges.data.value(Edges) = 0;
          T=T+1;
          tempWave=list(0);
          tempWave(1)='dc';
          wave(waveIndex)=tempWave;            
          waveIndex=waveIndex+1;
          clear tempWave;

        case 'F' then   // Current Controlled Current Source
          g.edges.data.type(Edges) = device_type;
          [value] = sscanf(tempStr, "%*s %*s %*s %*s %f");
          g.edges.data.value(Edges) = value;
          Edges=Edges+1;
          T=T+1;

        case 'H' then  // Current Controlled Voltage Source
          g.edges.data.type(Edges) = device_type;
          [value] = sscanf(tempStr, "%*s %*s %*s %*s %f");
          g.edges.data.value(Edges) = value;
          Edges=Edges+1;
          T=T+1;
          
        case 'D' then  // Diode
          NLFlag=%T;
          tempModel=list(0);
          g.edges.data.type(Edges) = 'D';
          tempModel(1) = sscanf(tempStr, "%*s %*s %*s %s");
          token = strtok(tempStr,"(");
          i=2;
          while( token <> '' )
            token = strtok(" )");
            if(length(token))
               tempModel(i)=atof(token);
               i=i+1; 
            end
          end
          if(length(tempModel)==1)
            tempModel(2)=1e-14;
            tempModel(3)=0.026;
          end
          Is=tempModel(2);
          Vt=tempModel(3);
          model(X)=tempModel;            
          g.edges.data.value(Edges) = Is/Vt;
          Edges=Edges+1;
       // Add Current Source parallel with resistance(linearization)
          g=add_edge(source,sink,g);
          g.edges.data.type(Edges) = 'I';
          g.edges.data.value(Edges) = 0;
          tempWave=list(0);
          tempWave(1)='dc';
          wave(waveIndex)=tempWave;            
          waveIndex=waveIndex+1;
          clear tempWave;
          X=X+1;
          clear tempModel;

        case 'M' then  // MOSFET 
          tempModel=list(0);
          g.edges.data.type(Edges) = device_type;
          g.edges.data.value(Edges) = 1e-12;
          Edges=Edges+1;
          [gateNodeS,tempModel(1)] = sscanf(tempStr, "%*s %*s %*s %s %s");
          gateNode=findIndexStrList(gateNode,nodeMap);
          token = strtok(tempStr,"(");
          i=2;
          while( token <> '' )
            token = strtok(" )");
            if(length(token))
              tempModel(i)=atof(token);
              i=i+1; 
            end
          end
          model(X)=tempModel;            
     
     // Add current source drain to source
          g=add_edge(source,sink,g);
          g.edges.data.type(Edges) = 'I';
          g.edges.data.value(Edges) = 0;
          tempWave=list(0);
          tempWave(1)='dc';
          wave(waveIndex)=tempWave;            
          waveIndex=waveIndex+1;
          clear tempWave;
          Edges=Edges+1;
       
       // Add current source gate to source   
          g=add_edge(gateNode,sink,g);
          g.edges.data.type(Edges) = 'I';
          g.edges.data.value(Edges) = 0;
          tempWave=list(0);
          tempWave(1)='dc';
          wave(waveIndex)=tempWave;            
          waveIndex=waveIndex+1;
          clear tempWave;
          X=X+1;
          Edges=Edges+1;
        
       // Add capactior gate to drain  
          g=add_edge(gateNode,source,g);
          g.edges.data.type(Edges) = 'C';
          cValue(C)=0.5*tempModel(4)*tempModel(2)*tempModel(3);
          g.edges.data.value(Edges) = 1e-12;
          Edges=Edges+1;
          
          g=add_edge(source,gateNode+1,g);
          g.edges.data.type(Edges) = 'I';
          g.edges.data.value(Edges) = 0;
          tempWave=list(0);
          tempWave(1)='dc';
          wave(waveIndex)=tempWave;            
          waveIndex=waveIndex+1;
          clear tempWave;
          C=C+1;
          Edges=Edges+1;
        
        // Add capacitor gate to source
          g=add_edge(gateNode,sink,g);
          g.edges.data.type(Edges) = 'C';
          cValue(C)=0.5*tempModel(4)*tempModel(2)*tempModel(3);
          g.edges.data.value(Edges) = 1e-12;
          Edges=Edges+1;
     
          g=add_edge(sink,gateNode,g);
          g.edges.data.type(Edges) = 'I';
          g.edges.data.value(Edges) = 0;
          tempWave=list(0);
          tempWave(1)='dc';
          wave(waveIndex)=tempWave;            
          waveIndex=waveIndex+1;
          clear tempWave;
          C=C+1;
          clear tempModel;
          
        case 'C' then  // Capacitor 
          dynamicFlag=%T;
          g.edges.data.type(Edges) = 'C';
          [value] = sscanf(tempStr, "%*s %*s %*s %f");
          token=strtok(tempStr,"=");
          token = strtok(" ");
          if(token <> '')
            cInitial(C)=atof(token);  
          else
            cInitial(C)=0.0;  
          end
          cValue(C)=value;
          g.edges.data.value(Edges) = 0.0;
          Edges=Edges+1;
          g=add_edge(sink,source,g);
          g.edges.data.type(Edges) = 'I';
          g.edges.data.value(Edges) = 0;
          tempWave=list(0);
          tempWave(1)='dc';
          wave(waveIndex)=tempWave;            
          waveIndex=waveIndex+1;
          clear tempWave;
          C=C+1;

        case 'X' then  // UserDefined Component
          tempModel=list(0);
          g.edges.data.type(Edges) = 'X';
          tempModel(1) = sscanf(tempStr, "%*s %*s %*s %s");
          i=2;
          token = strtok(tempStr,"(");
          while( token <> '' )
            token = strtok(" )");
            if(length(token))
              tempModel(i)=atof(token);
              i=i+1; 
            end
          end
          model(X)=tempModel;            
          generateCallingLibF(tempModel(1));
          exec('getlib.sci',-1); 
          value=jacobian(0.0,model(X));
          if(value>1d-6)      
            g.edges.data.value(Edges) = value;
          else
            g.edges.data.value(Edges) = 1d-6;
          end
          Edges=Edges+1;
          g=add_edge(source,sink,g);
          g.edges.data.type(Edges) = 'I';
          g.edges.data.value(Edges) = 0;
          tempWave=list(0);
          tempWave(1)='dc';
          wave(waveIndex)=tempWave;            
          waveIndex=waveIndex+1;
          clear tempWave;
          X=X+1;
          clear tempModel;
        else
          printf("Incorrect input file\n");
          exit(0);
        end
   end
end //while
mclose(fid);
//catch
//   disp("Error in circuit file. Error code: 120 Exiting.......");
//   abort;
//end
endfunction
          
function [tempWave,value]=getSourceParam(tempStr,wavtype)
  tempWave=list(0);
  tempWave(1)=wavtype;
  if(wavtype=='DC') 
    value = sscanf(tempStr, "%*s %*s %*s %*s %f");
  elseif(wavtype=='SWEEP') 
    value = sscanf(tempStr, "%*s %*s %*s %*s %f");
  elseif(wavtype=='AC') 
    value = sscanf(tempStr, "%*s %*s %*s %*s %f");
  else
    token = strtok(tempStr,"(");
    i=2;
    while( token <> '' )
      token = strtok(" )");
      if(length(token))
         tempWave(i)=atof(token);
         i=i+1; 
      end
    end            
    value = 0;
  end
endfunction
