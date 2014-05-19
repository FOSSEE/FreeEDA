// NR.sci is a scilab file to perform linearization of nonlinear element using Newton-Raphson method. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
// It is modified by Yogesh Dilip Save for OSCAD Software on October 2012


function flag=checkForDeviceChar(voltage,current)
  global g;
  global model;
  Edges=edge_number(g);
  flag=%t;
  X=1;
  for edge_cnt = 1:Edges,
    if(g.edges.data.type(edge_cnt)=='D')
       tempModel=model(X);
       Is=tempModel(2); Vt=tempModel(3);
       currentByDiodeChar=Is*(exp(voltage(edge_cnt)/Vt)-1);
       diodeCurrent=current(edge_cnt)+current(edge_cnt+1);
       if(abs(currentByDiodeChar)<1d-9)
          err=(diodeCurrent-currentByDiodeChar);
       else
          err=(diodeCurrent-currentByDiodeChar)*100/currentByDiodeChar;
       end
       if(abs(err)>0.001)
         flag=%f; break;
       end
       X=X+1;
       clear tempModel;
    elseif(g.edges.data.type(edge_cnt)=='X')
       tempModel=model(X);
       generateCallingLibF(tempModel(1));
       exec('getlib.sci',-1);
       currentByFunc=func(voltage(edge_cnt),model(X));
       currentByAnalysis=current(edge_cnt)+current(edge_cnt+1);
       if(abs(currentByFunc)<1d-9)
         err=(currentByAnalysis-currentByFunc);
       else
         err=(currentByAnalysis-currentByFunc)*100/currentByFunc;
       end
       if(abs(err)>0.001)
         flag=%f; break;
       end
       X=X+1;
       clear tempModel;
    elseif(g.edges.data.type(edge_cnt)=='M')
       Vgs=voltage(edge_cnt+2);
       Vds=voltage(edge_cnt);
       tempModel=model(X);
       [Vt,beta1]=getMosPara(tempModel);
       if(tempModel(1)=='P')
          if(Vgs>Vt)  //Cut-OFF region
            currentByFunc=0;
          elseif((Vgs<=Vt) & (Vds<(Vgs-Vt))) // Saturation region
            currentByFunc=-beta1/2*(Vgs-Vt)*(Vgs-Vt);
          else                              // Linear region
            currentByFunc=-beta1*((Vgs-Vt)*Vds-Vds*Vds/2);
          end
       else
          if(Vgs<Vt)  //Cut-OFF region
            currentByFunc=0;
          elseif((Vgs>=Vt) & (Vds>(Vgs-Vt))) // Saturation region
            currentByFunc=beta1/2*(Vgs-Vt)*(Vgs-Vt);
          else                              // Linear region
            currentByFunc=beta1*((Vgs-Vt)*Vds-Vds*Vds/2);
          end
       end
       currentByAnalysis=current(edge_cnt)+current(edge_cnt+1);
       if(abs(currentByFunc)<1d-9)
         err=(currentByAnalysis-currentByFunc);
       else
         err=(currentByAnalysis-currentByFunc)*100/currentByFunc;
       end
       if(abs(err)>0.0001)
         flag=%f; break;
       end
       X=X+1;
       clear tempModel;
    end
  end
endfunction

function [A,B]=NR(A,B,voltage,current,NRitr)
  global g;
  global model;
  X=1;
  Edges=edge_number(g);
  for edge_cnt = 1:Edges,
   if(g.edges.data.type(edge_cnt)=='D')
     tempModel=model(X);
     Is=tempModel(2); Vt=tempModel(3);  Vtlimit=80*Vt;  // Diode Parameter
     tempVoltage=voltage(edge_cnt);
     tempCurrent=current(edge_cnt)+current(edge_cnt+1);
// Voltage Limiting
     if(~(tempVoltage==0))
        while(tempVoltage > Vtlimit)
          tempVoltage = log(tempVoltage);
        end
        while(tempVoltage < -Vtlimit)
          tempVoltage = -log(-tempVoltage);
        end
     end
// In forword bisaed use diode current to find voltage 
     if(tempVoltage>=0 & tempCurrent>=0)
       tempVoltage = Vt*log(tempCurrent/Is+1);
     end  
// Update diode conductance and current source
     Gnew=Is/Vt*exp(tempVoltage/Vt);
     Gupdate=Gnew-g.edges.data.value(edge_cnt)
     g.edges.data.value(edge_cnt)=Gnew;
     Inew=Is*(exp(tempVoltage/Vt)-1)-Gnew*tempVoltage;
     Iupdate=Inew-g.edges.data.value(edge_cnt+1); 
     g.edges.data.value(edge_cnt+1)=Inew;
// Update matrix A and rhs vector
     source=g.edges.tail(edge_cnt)-1;
     sink=g.edges.head(edge_cnt)-1;
     if(~(source==0)) 
       A(source,source) = A(source,source) + Gupdate;
       B(source) = B(source)-Iupdate;
     end
     if(~(sink==0)) 
       A(sink,sink) = A(sink,sink) + Gupdate;
       B(sink) =B(sink) + Iupdate;
     end
     if(~(sink==0) & ~(source==0))
       A(source,sink) = A(source,sink) - Gupdate;
       A(sink,source) = A(sink,source) - Gupdate;
     end
     X=X+1;
     clear tempModel;
   elseif(g.edges.data.type(edge_cnt)=='X')
     tempVoltage=voltage(edge_cnt);
     tempCurrent=current(edge_cnt)+current(edge_cnt+1);
     tempModel=model(X);
     generateCallingLibF(tempModel(1));
     exec('getlib.sci',-1);
// Update conductance and current source of nonlinear device
     Gnew=jacobian(tempVoltage,model(X));
     Gupdate=Gnew-g.edges.data.value(edge_cnt)
     g.edges.data.value(edge_cnt)=Gnew;
     Inew=func(tempVoltage,model(X))-Gnew*tempVoltage;
     Iupdate=Inew-g.edges.data.value(edge_cnt+1); 
     g.edges.data.value(edge_cnt+1)=Inew;
// Update matrix A and rhs vector
     source=g.edges.tail(edge_cnt)-1;
     sink=g.edges.head(edge_cnt)-1;
     if(~(source==0)) 
       A(source,source) = A(source,source) + Gupdate;
       B(source) = B(source)-Iupdate;
     end
     if(~(sink==0)) 
       A(sink,sink) = A(sink,sink) + Gupdate;
       B(sink) =B(sink) + Iupdate;
     end
     if(~(sink==0) & ~(source==0))
       A(source,sink) = A(source,sink) - Gupdate;
       A(sink,source) = A(sink,source) - Gupdate;
     end
     X=X+1;  
     clear tempModel;
   elseif(g.edges.data.type(edge_cnt)=='M')
     Vgs=voltage(edge_cnt+2);
     Vds=voltage(edge_cnt);
     tempModel=model(X);
     [Vt,beta1]=getMosPara(tempModel);
     Vtlimit=abs(80*Vt);
// MOS Voltage Limiting
     if(~(Vgs==0))
        while(Vgs > Vtlimit)
          Vgs = log(Vgs)
        end
        while(Vgs < -Vtlimit)
          Vgs = -log(-Vgs)
        end
     end
     if(~(Vds==0))
        while(Vds > Vtlimit)
          Vds = log(Vds);
        end
        while(Vds < -Vtlimit)
          Vds = -log(-Vds);
        end
     end
// Update conductance and current source of MOSFET 
     if(tempModel(1)=='P')
        if(Vgs>Vt)  //Cut-OFF region
           Gnew=1e-12;
           Inew=0;
        elseif((Vgs<=Vt) & (Vds<(Vgs-Vt))) // Saturation region
           Gnew=1e-12;
           Inew=-beta1/2*(Vgs-Vt)*(Vgs-Vt);
        else                              // Linear region
           Gnew=abs(beta1*((-Vgs+Vt)+Vds));
           Inew=-beta1/2*Vds*Vds;
        end
     else
        if(Vgs<Vt)  //Cut-OFF region
           Gnew=1e-12;
           Inew=0;
        elseif((Vgs>=Vt) & (Vds>(Vgs-Vt))) // Saturation region
           Gnew=1e-12;
           Inew=beta1/2*(Vgs-Vt)*(Vgs-Vt);
        else                              // Linear region
           Gnew=abs(beta1*((Vgs-Vt)-Vds));
           Inew=beta1/2*Vds*Vds;
        end
     end
     Gupdate=Gnew-g.edges.data.value(edge_cnt)
     g.edges.data.value(edge_cnt)=Gnew;
     Iupdate=Inew-g.edges.data.value(edge_cnt+1); 
     g.edges.data.value(edge_cnt+1)=Inew;
// Update matrix A and rhs vector
     source=g.edges.tail(edge_cnt)-1;
     sink=g.edges.head(edge_cnt)-1;
     if(~(source==0)) 
       A(source,source) = A(source,source) + Gupdate;
       B(source) = B(source)-Iupdate;
     end
     if(~(sink==0)) 
       A(sink,sink) = A(sink,sink) + Gupdate;
       B(sink) =B(sink) + Iupdate;
     end
     if(~(sink==0) & ~(source==0))
       A(source,sink) = A(source,sink) - Gupdate;
       A(sink,source) = A(sink,source) - Gupdate;
     end
     X=X+1;  
     clear tempModel;
   end
  end
endfunction 

