// printSolution.sci is a scilab file to display solution of the circuit. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
// It is modified by Yogesh Dilip Save for OSCAD Software on October 2012


function printOPSolution(fileName,voltage,current,Wmode)
  global g;
  global nodeMap;
  fid = mopen(fileName, Wmode);
  if(fid == -1)
     error("cannot open file for writing");
  end
  mfprintf(fid,'Name\t Source\t Sink\t       Voltage\t       Current\n');
  mfprintf(fid,'----------------------------------------------------------\n');
    
  Edges=edge_number(g);
  edge_cnt=1;
  while(edge_cnt<=Edges)
    if(g.edges.data.type(edge_cnt)=='D'|g.edges.data.type(edge_cnt)=='X')
      mfprintf(fid,'%c\t %s\t %s\t %15.10f %15.10f\n',g.edges.data.type(edge_cnt),nodeMap(g.edges.tail(edge_cnt)),nodeMap(g.edges.head(edge_cnt)),voltage(edge_cnt),current(edge_cnt)+current(edge_cnt+1));
      edge_cnt=edge_cnt+2;
    elseif(g.edges.data.type(edge_cnt)=='M')
      mfprintf(fid,'%c\t %s\t %s\t %15.10f %15.10f\n',g.edges.data.type(edge_cnt),nodeMap(g.edges.tail(edge_cnt)),nodeMap(g.edges.head(edge_cnt)),voltage(edge_cnt),current(edge_cnt)+current(edge_cnt+1));
      edge_cnt=edge_cnt+7;
    else
      mfprintf(fid,'%c\t %s\t %s\t %15.10f %15.10f\n',g.edges.data.type(edge_cnt),nodeMap(g.edges.tail(edge_cnt)),nodeMap(g.edges.head(edge_cnt)),voltage(edge_cnt),current(edge_cnt));
      edge_cnt=edge_cnt+1;
    end
  end
  mclose(fid);
endfunction

function initArrays(t_itr)
  global vPrintArray; global vPlotArray;
  global iPrintArray; global iPlotArray;
  vPrintArray = zeros(t_itr,length(vPrintList)+1);
  vPlotArray = zeros(t_itr,length(vPlotList));
  iPrintArray = zeros(t_itr,length(iPrintList)+1);
  iPlotArray = zeros(t_itr,length(iPlotList));
endfunction

function buildOutput(x,s,itr)
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

function fill_vPrintArray(x,i)
  global vPrintList;
  global vPrintArray;
  for j=1:1:length(vPrintList);
     if(length(vPrintList(j))==1)
       if(vPrintList(j)<0)
        vPrintArray(i,j+1)=-x((-vPrintList(j))-1);
       else		
        vPrintArray(i,j+1)=x(vPrintList(j)-1);
       end
     elseif(length(vPrintList(j))==2)
	mylist=vPrintList(j);
	vPrintArray(i,j+1)=x(mylist(1)-1)-x(mylist(2)-1);
     end 
  end
endfunction

function fill_vPlotArray(x,i)
  global vPlotList;
  global vPlotArray;
  for j=1:1:length(vPlotList);
    if(length(vPlotList(j))==1)
      if(vPlotList(j)<0)
        vPlotArray(i,j)=-x((-vPlotList(j))-1);
      else			
        vPlotArray(i,j)=x(vPlotList(j)-1);
      end
    elseif(length(vPlotList(j))==2)
      mylist=vPlotList(j);
      vPlotArray(i,j)=x(mylist(1)-1)-x(mylist(2)-1);
    end
  end
  clear mylist;
endfunction

function fill_iPrintArray(x,i)
  global iPrintList;
  global iPrintArray;
  global g;
  Nodes=node_number(g);
  for j=1:1:length(iPrintList);
    if(vPrintList(j)<0)
       iPrintArray(i,j+1)=-x(-iPrintList(j)+Nodes-1);
    else			
       iPrintArray(i,j+1)=x(iPrintList(j)+Nodes-1);
    end
  end
endfunction

function fill_iPlotArray(x,i)
  global iPlotList;
  global iPlotArray;
  global g;
  Nodes=node_number(g);
  for j=1:1:length(iPlotList);
    if(iPlotList(j)<0)
       iPlotArray(i,j)=-x(-iPlotList(j)+Nodes-1);
    else			
       iPlotArray(i,j)=x(iPlotList(j)+Nodes-1);
    end
  end
endfunction

function printSolution(xArray,xaxis,axisType);
  global vPrintList; global vPlotList;
  global iPrintList; global iPlotList;
  global vPrintArray; global vPlotArray 
  global iPrintArray; global iPlotArray;
  if(~(vPlotList(1)==0))
    plot(xArray,vPlotArray);
    for(i=1:size(vPlotArray,2))
        temp=vPlotList(i);
        for(j=1:size(temp,2))
            if(j==1)
                a(i)="v("+string(temp(j))+")";
            else
                a(i)=a(i)+"-v("+string(temp(j))+")";
            end
        end
    end
    legend(a);  
    xlabel(xaxis);
    ylabel('voltage(V)');
  end
  if(~(vPrintList(1)==0))
    disp(vPrintArray);
  end
  if(~(iPlotList(1)==0))
    plot(xArray,iPlotArray);
    for(i=1:size(iPlotArray,2))
        temp=iPlotList(i);
        disp(temp);
        for(j=1:size(temp,2))
            if(j==1)
                a(i)="i("+string(temp(j))+")";
            else
                a(i)=a(i)+"-i("+string(temp(j))+")";
            end
        end
    end
    legend(a);  
    xlabel(xaxis);
    ylabel('current(A)');
  end
  if(~(iPrintList(1)==0))
    disp(iPrintArray);
  end
endfunction
