// Main.sci is a main scilab file of a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
// It is modified by Yogesh Dilip Save for OSCAD Software on October 2012
warning('off');
clear
global('LPCSim_HOME')
OSCAD_HOME=set_PATH_to_OSCAD
LPCSim_HOME=OSCAD_HOME+'/LPCSim/LPCSim/'
//%format('e',10);
MaxNRitr=100;
symbolic=%F;
displayMatrix=%F;

// Open the circuit file
try
  fid = mopen(LPCSim_HOME+"option", 'r');
  if (fid == -1)
    error("cannot open file for reading");
  end
  tempStr=mgetl(fid,1);
  tempStr=stripblanks(tempStr);
  [option] = sscanf(tempStr, "%d");
catch
  disp("Can not open option. Running default mode");
  option=1
end

if (option == 1)
 symbolic=%T
elseif (option == 2)
 symbolic=%T
 displayMatrix=%T
end

// Metanet Graph library
  // exec('metanet-0.4/loader.sce',-1);

// Supporting function library
exec(LPCSim_HOME+'support/atof.sci',-1);
exec(LPCSim_HOME+'support/findIndex.sci',-1);

exec(LPCSim_HOME+'lib/mos.sci',-1);
exec(LPCSim_HOME+'readfile.sci',-1);
exec(LPCSim_HOME+'buildMatrices.sci',-1);
exec(LPCSim_HOME+'buildMatricesSymbolic.sci',-1);
exec(LPCSim_HOME+'OpAnalysis.sci',-1);
exec(LPCSim_HOME+'NR.sci',-1);
exec(LPCSim_HOME+'genrateCallingLibF.sci',-1);
exec(LPCSim_HOME+'printSolution.sci',-1);
exec(LPCSim_HOME+'tranAnalysis.sci',-1);
exec(LPCSim_HOME+'DCAnalysis.sci',-1);
exec(LPCSim_HOME+'ACAnalysis.sci',-1);
//getf('LUT/ids.sce');
fileName = 'ckt/nodalExample.ckt';
fileName = 'ckt/ModifiednodalExample.ckt';
fileName = 'ckt/linear.ckt';
fileName = 'ckt/ForwardBiasedDiode.ckt';
fileName = 'ckt/bridge.ckt';
//fileName='ckt/Vsweep.ckt';
//fileName='ckt/myCompSweep.ckt';
//fileName='ckt/rc1.ckt';
//fileName='ckt/rc_ac.ckt'
fileName='ckt/HWRectifierFilter.ckt';
//fileName = readc_();
args=sciargs();
fileName= args(5);

global('g');
global('model')
global('wave')
global('cValue','cInitial')
global('vPrintList','vPlotList')
global('iPrintList','iPlotList')
global('initialVoltage')
global('displayNLFlag');
global('NLFlag');
global('dynamicFlag');
global('currentAnalysis')
global('nodeMap')
displayNLFlag=%T;
dynamicFlag=%F;
NLFlag=%F;
currentAnalysis=0;

// Get circuit analysis option from circuit file 
[transParameter,sweep,Analysis,_Nodes]=getAnalysisOption(fileName);

// Read circuit form file and convert it into graph
_T=convertCircuitIntoGraph(fileName,_Nodes); 

// Build Modified Nodal Matrix for linear devices
[A,B]=buildMatrices(_T);

if symbolic then
  mprintf("-----------------------------------------------------------\n");
  mprintf("Simulation of %s: \n",fileName);
  [Asymb,Bsymb,Dsymb,Csymb,xsymb,fxsymb]=buildMatricesSymbolic(_T);
  if displayMatrix then
    mprintf("The system of equations Ax+D_f(w)+C(dx/dt)=b (Symbolically):\n");
    mprintf("Where A, D and C represent matrices corresponding to linear,\n  nonlinear and time dependent electrical elements respectively.\n");
    mprintf("  b represents the vector corresponding to sources.\n"); 
    mprintf("-----------------------------------------------------------\n");
    if dynamicFlag then
      disp(fxsymb,"w=",xsymb,"x=",Csymb,"C=",Dsymb,"D_f=",Bsymb,"B=",Asymb,"A=");
    elseif NLFlag then
      disp(fxsymb,"w=",xsymb,"x=",0,"C=",Dsymb,"D_f=",Bsymb,"B=",Asymb,"A=");
    else
      disp(fxsymb,"w=",xsymb,"x=",0,"C=",0,"D_f=",Bsymb,"B=",Asymb,"A=");
    end
    mprintf("The number of equations are %d\n",_Nodes+_T-1);
    mprintf("Unknowns:\n");
    mprintf("  Node potentials: %d Current Variables: %d\n",_Nodes-1,_T);
    mprintf("Note that the matrix contains r entries (corresponding to resistors) whose values are equal to 1/r\n");
    pause;
  end
end

// Perform Operating Point Analysis on static circuit
if symbolic then
  mprintf("-----------------------------------------------------------\n");
  mprintf("Operating Point (DC) Analysis: \n");
  mprintf("All capacitors are open circuited and inductors are short circuited \n");
  [Asymb,Bsymb,Dsymb,xsymb,fxsymb]=buildMatricesSymbStatic(_T);
  if displayMatrix then
    mprintf("The system of equations Ax+D_f(w))=b (Symbolically):\n");
    mprintf("Where A and D represent matrices corresponding to linear,\n  and nonlinear electrical elements respectively.\n");
    mprintf("  b represents the vector corresponding to sources.\n"); 
    mprintf("-----------------------------------------------------------\n");
    if NLFlag then
      disp(fxsymb,"w=",xsymb,"x=",Dsymb,"D_f=",Bsymb,"B=",Asymb,"A=");
    else
      disp(fxsymb,"w=",xsymb,"x=",0,"D_f=",Bsymb,"B=",Asymb,"A=");
    end
    mprintf("The number of equations are %d\n",_Nodes+_T-1);
    mprintf("Unknowns:\n");
    mprintf("  Node potentials: %d Current Variables: %d\n",_Nodes-1,_T);
    mprintf("Note that the matrix contains r entries (corresponding to resistors) whose values are equal to 1/r\n");
    pause;
  end
end
[A,B,x]=OPAnalysis(A,B);
if displayMatrix then
  mprintf("-----------------------------------------------------------\n");
  mprintf("Operating Point (DC) Analysis: \n");
  mprintf("All capacitors are open circuited and inductors are short circuited \n");
  mprintf("The system of equations Ax=b (Numerically):\n");
  mprintf("-----------------------------------------------------------\n");
  format('e',10);
  disp(B,"B=",A,"A=");
  pause;
end

if displayMatrix then
  mprintf("-----------------------------------------------------\n");
  mprintf("The solution of the circuit x:\n");
  mprintf("-----------------------------------------------------\n");
  format('e',10);
  disp(x,"x=");
  pause;
end

// Find branch voltage from node potential
voltage=findBranchVoltage(x);

// Find branch current from branch voltage using device characteristic
current=findBranchCurrent(x,voltage);

// Print the Operating Point Solution
fileName=fileName+".sol";
Wmode="w"; 
printOPSolution(fileName,voltage,current,Wmode);
mprintf("-----------------------------------------------------\n");
mprintf("The complete solution (Operating Point) of the circuit\n\t is written in %s\n",fileName);
mprintf("-----------------------------------------------------\n");

if(Analysis==1)      // Transient Analysis  
  currentAnalysis=1;
  mprintf("-----------------------------------------------------\n");
  mprintf("Transient Analysis: \n");
  mprintf("-----------------------------------------------------\n");
  global('sweepArray','vPrintArray','vPlotArray','iPrintArray','iPlotArray');

  if symbolic then
    [Asymb,Bsymb,Dsymb,Csymb,xsymb,fxsymb]=buildMatricesSymbolic(_T);
    if displayMatrix then
      mprintf("The system of equations Ax+D_f(w)+C(dx/dt)=b (Symbolically):\n");
      mprintf("Where A, D and C represent matrices corresponding to linear,\n  nonlinear and time dependent electrical elements respectively.\n");
      mprintf("  b represents the vector corresponding to sources.\n"); 
      mprintf("-----------------------------------------------------------\n");
      if dynamicFlag then
        disp(fxsymb,"w=",xsymb,"x=",Csymb,"C=",Dsymb,"D_f=",Bsymb,"B=",Asymb,"A=");
      elseif NLFlag then
        disp(fxsymb,"w=",xsymb,"x=",0,"C=",Dsymb,"D_f=",Bsymb,"B=",Asymb,"A=");
      else
        disp(fxsymb,"w=",xsymb,"x=",0,"C=",0,"D_f=",Bsymb,"B=",Asymb,"A=");
      end
      mprintf("The number of equations are %d\n",_Nodes+_T-1);
      mprintf("Unknowns:\n");
      mprintf("  Node potentials: %d Current Variables: %d\n",_Nodes-1,_T);
      mprintf("Note that the matrix contains r entries (corresponding to resistors) whose values are equal to 1/r\n");
      pause;
    end
  end
  
  // Perform Transient Analysis on static circuit
  if symbolic then
    mprintf("-----------------------------------------------------------\n");
    mprintf("A static circuit at time t: \n");
    [Asymb,Bsymb,Dsymb,xsymb,fxsymb]=buildMatricesSymbStatic(_T);
    if displayMatrix then
      mprintf("The system of equations Ax+D_f(w))=b (Symbolically):\n");
      mprintf("Where A and D represent matrices corresponding to linear,\n  and nonlinear electrical elements respectively.\n");
      mprintf("  b represents the vector corresponding to sources.\n"); 
      mprintf("-----------------------------------------------------------\n");
      if NLFlag then
        disp(fxsymb,"w=",xsymb,"x=",Dsymb,"D_f=",Bsymb,"B=",Asymb,"A=");
      else
        disp(fxsymb,"w=",xsymb,"x=",0,"D_f=",Bsymb,"B=",Asymb,"A=");
      end
      mprintf("The number of equations are %d\n",_Nodes+_T-1);
      mprintf("Unknowns:\n");
      mprintf("  Node potentials: %d Current Variables: %d\n",_Nodes-1,_T);
      mprintf("Note that the matrix contains r entries (corresponding to resistors) whose values are equal to 1/r\n");
      pause;
    end
  end

  t_start=transParameter(1);
  t_end=transParameter(2);
  t_step=transParameter(3);
  UIC=transParameter(4);
  t_itr=(t_end-t_start)/t_step+2;
  initArrays(t_itr);
  sweepArray = zeros(t_itr,1);
  i=1;
 // Find Initial condition at t=0
  [x]=setIntialCondition(A,B,x,_T,UIC);
 // Store Output Variable for plotting/printing 
  buildOutput(x,0,i);
  i=i+1;
  for t=t_start:t_step:t_end
    if(i==2) t=t+t_step/100; end;
    [A,B,x]=transientAnalysis(A,B,x,t,i);
    i=i+1;
  end
  xaxis='time(sec)';
  printSolution(sweepArray,xaxis,'lin');
end

if(Analysis==2)    // DC Analysis
  global('sweepArray','vPrintArray','vPlotArray','iPrintArray','iPlotArray');
  s_start=sweep(1);
  s_end=sweep(2);
  s_step=sweep(3);
  s_itr=(s_end-s_start)/s_step+1;
  initArrays(s_itr);
  sweepArray = zeros(s_itr,1);
  i=1;
  for s=s_start:s_step:s_end
     [A,B,x]=DCAnalysis(A,B,s);
     buildOutput(x,s,i);
     i=i+1;
  end
  xaxis='Voltage(V)';
  printSolution(sweepArray,xaxis,'lin');
end

if(Analysis==3)    // AC Analysis
  global('sweepArray','vPrintArray','vPlotArray','iPrintArray','iPlotArray');
  f_start=sweep(1);
  f_end=sweep(2);
  f_itr=sweep(3)+1;
  axisType=sweep(4);
  f_step=(f_end-f_start)/(f_itr-1);
  initArrays(f_itr);
  sweepArray = zeros(f_itr,1);
  i=1;
  buildOutput(x,0,i);
  i=i+1;
  for f=f_start:f_step:f_end
     [A,B,x]=ACAnalysis(A,B,f);
     buildDCOutput(x,f,i);
     i=i+1;
  end
  xaxis='frequency(Hz)';
  printSolution(sweepArray,xaxis,axisType);
end
clearglobal();
//quit
///////////////////////////////////////////////////////////////////////////////   
