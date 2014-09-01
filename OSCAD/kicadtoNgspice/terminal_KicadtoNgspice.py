#!/usr/bin/python
# KicadtoNgspice.py is a python script to convert a Kicad spice netlist to a ngspice netlist. It developed for OSCAD software. It is written by FOSSEE team, IIT B.  
# Copyright (C) FOSSEE Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

import sys
import os.path

def readNetlist(filename):
  """Read Pspice netList"""
# Open file if it exists
  if os.path.exists(filename):
    try:
      f = open(filename)
    except :
      print("Error in opening file")
      sys.exit()
  else:
    print filename + " does not exist"
    sys.exit()
  
# Read the data from file
  data=f.read()
  
# Close the file
  f.close()
  return data.splitlines()

def readParamInfo(data):
  """Read Parameter information and store it into dictionary"""
  param={}
  for eachline in lines:
    eachline=eachline.strip()
    if len(eachline)>1:
      words=eachline.split();
      option=words[0].lower()
      if option=='.param':
	for i in range(1, len(words), 1):
	  paramList=words[i].split('=')
	  param[paramList[0]]=paramList[1]
  return param

def preprocessNetlist(lines,param):
  """Preprocess netlist (replace parameters)"""
  netlist=[]
  for eachline in lines:
  # Remove leading and trailing blanks spaces from line 
    eachline=eachline.strip()
  # Remove special character $
    eachline=eachline.replace('$','')
  # Replace parameter with values
    for subParam in eachline.split():
      if '}' in subParam:
	key=subParam.split()[0]
	key=key.strip('{')
	key=key.strip('}')
	if key in param:
	  eachline=eachline.replace('{'+key+'}',param[key])
	else:
	  print "Parameter " + key +" does not exists"
	  value=raw_input('Enter parameter value: ')
	  eachline=eachline.replace('{'+key+'}',value)
   # Convert netlist into lower case letter	
    eachline=eachline.lower()
   # Construct netlist
    if len(eachline)>1:
      if eachline[0]=='+':
	netlist.append(netlist.pop()+eachline.replace('+',' '))
      else:
	netlist.append(eachline) 
 # Copy information line
  infoline=netlist[0]
  netlist.remove(netlist[0])	
  return netlist,infoline

def separateNetlistInfo(netlist):
  optionInfo=[]
  schematicInfo=[]
  
  for eachline in netlist:
    if eachline[0]=='*':
      continue
    elif eachline[0]=='.':
      optionInfo.append(eachline)
    else:
      schematicInfo.append(eachline)
  return optionInfo,schematicInfo


def addAnalysis(optionInfo):
  """Add Analysis to the netlist"""
# Open file if it exists
  filename="analysis"
  if os.path.exists(filename):
    try:
      f = open(filename)
    except :
      print("Error in opening file")
      sys.exit()
  else:
    print filename + " does not exist"
    sys.exit()

# Read the data from file
  data=f.read()
  
# Close the file
  f.close()

  analysisData=data.splitlines()
  for eachline in analysisData:
    eachline=eachline.strip()
    if len(eachline)>1:
      if eachline[0]=='.':
        optionInfo.append(eachline)
      else:
        pass
  return optionInfo

def findCurrent(schematicInfo,outputOption):
  """Find current through component by placing voltage source series with the component"""
  i=0
  for eachline in outputOption:
    words=eachline.split()
    option=words[0]
  # Add voltage sources in series with component to find current 
    if option=="print" or option=="plot":
      words.remove(option)
      updatedline=eachline
      for outputVar in words:
      # Find component name if output variable is current
	if outputVar[0]=='i':
	  outputVar=outputVar.strip('i')
	  outputVar=outputVar.strip('(')
	  compName=outputVar.strip(')')
	 # If component is voltage source, skip
	  if compName[0]=='v':
	    continue
	 # Find the component from the circuit
	  for compline in schematicInfo:
	    compInfo=compline.split()
	    if compInfo[0]==compName:
	    # Construct dummy node 
	      dummyNode='dummy_'+str(i)
	      i+=1
	    # Break the one node component and place zero value voltage source in between.
	      index=schematicInfo.index(compline)
	      schematicInfo.remove(compline)
	      compline=compline.replace(compInfo[2],dummyNode)
	      schematicInfo.insert(index,compline)
	      schematicInfo.append('v'+compName+' '+dummyNode+' '+compInfo[2]+' 0')
    # Update option information
	  updatedline=updatedline.replace('i('+compName+')','i(v'+compName+')')
      index=outputOption.index(eachline)
      outputOption.remove(eachline)
      outputOption.insert(index,updatedline) 
  return schematicInfo, outputOption

def insertSpecialSourceParam(schematicInfo):
  """Insert Special source parameters"""
  schematicInfo1=[]
  for compline in schematicInfo:
    words=compline.split()
    compName=words[0]
  # Ask for parameters of the source  
    if compName[0]=='v' or compName[0]=='i':
    # Find the index component from the circuit
      index=schematicInfo.index(compline)
      schematicInfo.remove(compline)
      if words[3]=="pulse":
        print "----------------------------------------------\n"
        print "Add parameters for pulse source "+compName
	v1=raw_input('  Enter initial value(Volts/Amps): ')
	v2=raw_input('  Enter pulsed value(Volts/Amps): ')
	td=raw_input('  Enter delay time (seconds): ')
	tr=raw_input('  Enter rise time (seconds): ')
	tf=raw_input('  Enter fall time (seconds): ')
	pw=raw_input('  Enter pulse width (seconds): ')
	tp=raw_input('  Enter period (seconds): ')
        print "----------------------------------------------"
	compline=compline + "("+v1+" "+v2+" "+td+" "+tr+" "+tf+" "+pw+" "+tp+")"
      elif words[3]=="sine":
        print "----------------------------------------------\n"
        print "Add parameters for sine source "+compName
	vo=raw_input('  Enter offset value (Volts/Amps): ')
	va=raw_input('  Enter amplitude (Volts/Amps): ')
	freq=raw_input('  Enter frequency (Hz): ')
	td=raw_input('  Enter delay time (seconds): ')
	theta=raw_input('  Enter damping factor (1/seconds): ')
        print "----------------------------------------------"
	compline=compline + "("+vo+" "+va+" "+freq+" "+td+" "+theta+")"
      elif words[3]=="ac":
        print "----------------------------------------------\n"
        print "Add parameters for ac source "+compName
	v_a=raw_input('  Enter amplitude (Volts/Amps): ')
	print "----------------------------------------------"
	compline=compline + " " + v_a
      elif words[3]=="exp":
        print "----------------------------------------------\n"
        print "Add parameters for exponential source "+compName
	v1=raw_input('  Enter initial value(Volts/Amps): ')
	v2=raw_input('  Enter pulsed value(Volts/Amps): ')
	td1=raw_input('  Enter rise delay time (seconds): ')
	tau1=raw_input('  Enter rise time constant (seconds): ')
	td2=raw_input('  Enter fall time (seconds): ')
	tau2=raw_input('  Enter fall time constant (seconds): ')
        print "----------------------------------------------"
	compline=compline + "("+v1+" "+v2+" "+td1+" "+tau1+" "+td2+" "+tau2+")"
      elif words[3]=="pwl":
        print "----------------------------------------------\n"
        print "Add parameters for piecewise linear source "+compName
	inp="y"
	compline=compline + "("
	while inp=="y":
	  t1=raw_input('  Enter time (seconds): ')
	  v1=raw_input('  Enter value(Volts/Amps): ')
	  compline=compline + t1+" "+v1+" "
	  inp=raw_input(' Do you want to continue(y/n): ')
        print "----------------------------------------------"
	compline=compline + ")"
      elif words[3]=="dc":
        print "----------------------------------------------\n"
        print "Add parameters for DC source "+compName
	v1=raw_input('  Enter value(Volts/Amps): ')
        print "----------------------------------------------"
	compline=compline + " "+v1
      schematicInfo.insert(index,compline)
    elif compName[0]=='h' or compName[0]=='f':
    # Find the index component from the circuit
      index=schematicInfo.index(compline)
      schematicInfo.remove(compline)
      schematicInfo.insert(index,"* "+compName)
      schematicInfo1.append("V"+compName+" "+words[3]+" "+words[4]+" 0")
      schematicInfo1.append(compName+" "+words[1]+" "+words[2]+" "+"V"+compName+" "+words[5])
  schematicInfo=schematicInfo+schematicInfo1
  return schematicInfo

def convertICintoBasicBlocks(schematicInfo,outputOption):
  """Insert Special source parameters"""
  k=1
  for compline in schematicInfo:
    words=compline.split()
    compName=words[0]
  # Find the IC from schematic 
    if compName[0]=='u':
    # Find the component from the circuit
      index=schematicInfo.index(compline)
      schematicInfo.remove(compline)
      compType=words[len(words)-1];
      if (compType=="7404" or compType=="74hc04" or compType=="74hct04" or compType=="74ls04" or compType=="74ls14"):
        i=1;
      # Add first three Not gates
        while words[i]!="0":
        # Add analog to digital converter for input A
          schematicInfo.append("a"+str(k)+" ["+words[i]+"] ["+words[i]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add Not gate
          schematicInfo.append("a"+str(k)+" "+words[i]+"_in "+words[i+1]+"_out "+compName)
          k=k+1
        # Add digital to analog converter for output B
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"_out] ["+words[i+1]+"] "+" "+compName+"dac")
          k=k+1
          i=i+2
        i=i+1
      # Add last three Not gates
        while i<len(words)-2: 
        # Add analog to digital converter for input A
          schematicInfo.append("a"+str(k)+" ["+words[i]+"] ["+words[i]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add Not gate
          schematicInfo.append("a"+str(k)+" "+words[i]+"_in "+words[i+1]+"_out "+compName)
          k=k+1
        # Add digital to analog converter for output B
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"_out] ["+words[i+1]+"] "+" "+compName+"dac")
          k=k+1
          i=i+2
       # Insert comment in-place of components
        schematicInfo.insert(index,"* "+compType)
       # Add model for inverter gate
        schematicInfo.append(".model "+ compName+" d_inverter")
       # Add model for analog-to-digital bridge
        schematicInfo.append(".model "+ compName+"adc adc_bridge(in_low=0.8 in_high=2.0)")
       # Add model for digital-to-analog bridge
        schematicInfo.append(".model "+ compName+"dac dac_bridge(out_low=0.25 out_high=5.0 out_undef=1.8 t_rise=0.5e-9 t_fall=0.5e-9)")
      elif (compType=="7400" or compType=="74hc00" or compType=="74hct00" or compType=="74ls00" or compType=="74ls37"):
        i=1;
      # Add first two Nand gates
        while words[i]!="0":
        # Add analog to digital converter for input A
          schematicInfo.append("a"+str(k)+" ["+words[i]+"] ["+words[i]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add analog to digital converter for input B
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"] ["+words[i+1]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add two-input Nand gate
          schematicInfo.append("a"+str(k)+" ["+words[i]+"_in "+words[i+1]+"_in] "+words[i+2]+"_out "+compName)
          k=k+1
        # Add digital to analog converter for output C
          schematicInfo.append("a"+str(k)+" ["+words[i+2]+"_out] ["+words[i+2]+"] "+" "+compName+"dac")
          k=k+1
          i=i+3
        i=i+1
      # Add Last two Nand gates
        while i<len(words)-2: 
        # Add analog to digital converter for input A
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"] ["+words[i+1]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add analog to digital converter for input B
          schematicInfo.append("a"+str(k)+" ["+words[i+2]+"] ["+words[i+2]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add two-input Nand gate
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"_in "+words[i+2]+"_in] "+words[i]+"_out "+compName)
          k=k+1
        # Add digital to analog converter for output C
          schematicInfo.append("a"+str(k)+" ["+words[i]+"_out] ["+words[i]+"] "+" "+compName+"dac")
          k=k+1
          i=i+3
       # Insert comment in-place of components
        schematicInfo.insert(index,"* "+compType)
       # Add model for nand gate
        schematicInfo.append(".model "+ compName+" d_nand")
       # Add model for analog-to-digital bridge
        schematicInfo.append(".model "+ compName+"adc adc_bridge(in_low=0.8 in_high=2.0)")
       # Add model for digital-to-analog bridge
        schematicInfo.append(".model "+ compName+"dac dac_bridge(out_low=0.25 out_high=5.0 out_undef=1.8 t_rise=0.5e-9 t_fall=0.5e-9)")
      elif (compType=="7408" or compType=="74hc08" or compType=="74hct08" or compType=="74ls08"):
        i=1;
      # Add first two And gates
        while words[i]!="0":
        # Add analog to digital converter for input A
          schematicInfo.append("a"+str(k)+" ["+words[i]+"] ["+words[i]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add analog to digital converter for input B
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"] ["+words[i+1]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add two-input And gate
          schematicInfo.append("a"+str(k)+" ["+words[i]+"_in "+words[i+1]+"_in] "+words[i+2]+"_out "+compName)
          k=k+1
        # Add digital to analog converter for output C
          schematicInfo.append("a"+str(k)+" ["+words[i+2]+"_out] ["+words[i+2]+"] "+" "+compName+"dac")
          k=k+1
          i=i+3
        i=i+1
      # Add Last two And gates
        while i<len(words)-2: 
        # Add analog to digital converter for input A
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"] ["+words[i+1]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add analog to digital converter for input B
          schematicInfo.append("a"+str(k)+" ["+words[i+2]+"] ["+words[i+2]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add two-input And gate
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"_in "+words[i+2]+"_in] "+words[i]+"_out "+compName)
          k=k+1
        # Add digital to analog converter for output C
          schematicInfo.append("a"+str(k)+" ["+words[i]+"_out] ["+words[i]+"] "+" "+compName+"dac")
          k=k+1
          i=i+3
       # Insert comment in-place of components
        schematicInfo.insert(index,"* "+compType)
       # Add model for And gate
        schematicInfo.append(".model "+ compName+" d_and")
       # Add model for analog-to-digital bridge
        schematicInfo.append(".model "+ compName+"adc adc_bridge(in_low=0.8 in_high=2.0)")
       # Add model for digital-to-analog bridge
        schematicInfo.append(".model "+ compName+"dac dac_bridge(out_low=0.25 out_high=5.0 out_undef=1.8 t_rise=0.5e-9 t_fall=0.5e-9)")
      elif (compType=="7432" or compType=="74hc32" or compType=="74hct32" or compType=="74ls32"):
        i=1;
      # Add first two Or gates
        while words[i]!="0":
        # Add analog to digital converter for input A
          schematicInfo.append("a"+str(k)+" ["+words[i]+"] ["+words[i]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add analog to digital converter for input B
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"] ["+words[i+1]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add two-input Or gate
          schematicInfo.append("a"+str(k)+" ["+words[i]+"_in "+words[i+1]+"_in] "+words[i+2]+"_out "+compName)
          k=k+1
        # Add digital to analog converter for output C
          schematicInfo.append("a"+str(k)+" ["+words[i+2]+"_out] ["+words[i+2]+"] "+" "+compName+"dac")
          k=k+1
          i=i+3
        i=i+1
      # Add Last two Or gates
        while i<len(words)-2: 
        # Add analog to digital converter for input A
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"] ["+words[i+1]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add analog to digital converter for input B
          schematicInfo.append("a"+str(k)+" ["+words[i+2]+"] ["+words[i+2]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add two-input Or gate
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"_in "+words[i+2]+"_in] "+words[i]+"_out "+compName)
          k=k+1
        # Add digital to analog converter for output C
          schematicInfo.append("a"+str(k)+" ["+words[i]+"_out] ["+words[i]+"] "+" "+compName+"dac")
          k=k+1
          i=i+3
       # Insert comment in-place of components
        schematicInfo.insert(index,"* "+compType)
       # Add model for Or gate
        schematicInfo.append(".model "+ compName+" d_or")
       # Add model for analog-to-digital bridge
        schematicInfo.append(".model "+ compName+"adc adc_bridge(in_low=0.8 in_high=2.0)")
       # Add model for digital-to-analog bridge
        schematicInfo.append(".model "+ compName+"dac dac_bridge(out_low=0.25 out_high=5.0 out_undef=1.8 t_rise=0.5e-9 t_fall=0.5e-9)")
      elif (compType=="7486" or compType=="74hc86" or compType=="74hct86" or compType=="74ls86"):
        i=1;
      # Add first two Xor gates
        while words[i]!="0":
        # Add analog to digital converter for input A
          schematicInfo.append("a"+str(k)+" ["+words[i]+"] ["+words[i]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add analog to digital converter for input B
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"] ["+words[i+1]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add two-input Xor gate
          schematicInfo.append("a"+str(k)+" ["+words[i]+"_in "+words[i+1]+"_in] "+words[i+2]+"_out "+compName)
          k=k+1
        # Add digital to analog converter for output C
          schematicInfo.append("a"+str(k)+" ["+words[i+2]+"_out] ["+words[i+2]+"] "+" "+compName+"dac")
          k=k+1
          i=i+3
        i=i+1
      # Add Last two Xor gates
        while i<len(words)-2: 
        # Add analog to digital converter for input A
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"] ["+words[i+1]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add analog to digital converter for input B
          schematicInfo.append("a"+str(k)+" ["+words[i+2]+"] ["+words[i+2]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add two-input Xor gate
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"_in "+words[i+2]+"_in] "+words[i]+"_out "+compName)
          k=k+1
        # Add digital to analog converter for output C
          schematicInfo.append("a"+str(k)+" ["+words[i]+"_out] ["+words[i]+"] "+" "+compName+"dac")
          k=k+1
          i=i+3
       # Insert comment in-place of components
        schematicInfo.insert(index,"* "+compType)
       # Add model for Xor gate
        schematicInfo.append(".model "+ compName+" d_xor")
       # Add model for analog-to-digital bridge
        schematicInfo.append(".model "+ compName+"adc adc_bridge(in_low=0.8 in_high=2.0)")
       # Add model for digital-to-analog bridge
        schematicInfo.append(".model "+ compName+"dac dac_bridge(out_low=0.25 out_high=5.0 out_undef=1.8 t_rise=0.5e-9 t_fall=0.5e-9)")
      elif (compType=="7402" or compType=="74hc02" or compType=="74hct02" or compType=="74ls02" or compType=="74ls28"):
        i=1;
      # Add first two Nor gates
        while words[i]!="0":
        # Add analog to digital converter for input A
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"] ["+words[i+1]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add analog to digital converter for input B
          schematicInfo.append("a"+str(k)+" ["+words[i+2]+"] ["+words[i+2]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add two-input Nor gate
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"_in "+words[i+2]+"_in] "+words[i]+"_out "+compName)
          k=k+1
        # Add digital to analog converter for output C
          schematicInfo.append("a"+str(k)+" ["+words[i]+"_out] ["+words[i]+"] "+" "+compName+"dac")
          k=k+1
          i=i+3
        i=i+1
        while i<len(words)-2: 
        # Add analog to digital converter for input A
          schematicInfo.append("a"+str(k)+" ["+words[i]+"] ["+words[i]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add analog to digital converter for input B
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"] ["+words[i+1]+"_in] "+" "+compName+"adc")
          k=k+1
        # Add two-input Nor gate
          schematicInfo.append("a"+str(k)+" ["+words[i]+"_in "+words[i+1]+"_in] "+words[i+2]+"_out "+compName)
          k=k+1
        # Add digital to analog converter for output C
          schematicInfo.append("a"+str(k)+" ["+words[i+2]+"_out] ["+words[i+2]+"] "+" "+compName+"dac")
          k=k+1
          i=i+3
       # Insert comment in-place of components
        schematicInfo.insert(index,"* "+compType)
       # Add model for Nor gate
        schematicInfo.append(".model "+ compName+" d_nor")
       # Add model for analog-to-digital bridge
        schematicInfo.append(".model "+ compName+"adc adc_bridge(in_low=0.8 in_high=2.0)")
       # Add model for digital-to-analog bridge
        schematicInfo.append(".model "+ compName+"dac dac_bridge(out_low=0.25 out_high=5.0 out_undef=1.8 t_rise=0.5e-9 t_fall=0.5e-9)")
      elif (compType=="7474" or compType=="74hc74" or compType=="74ls74"):
       # Add analog to digital converter for inputs
        schematicInfo.append("a"+str(k)+" ["+words[2]+" "+words[3]+" "+words[4]+" "+words[1]+"] ["+words[2]+"_in "+words[3]+"_in "+words[4]+"_in "+words[1]+"_in] "+compName+"adc")
        k=k+1
       # Add D Flip-flop
        schematicInfo.append("a"+str(k)+" "+words[2]+"_in "+words[3]+"_in ~"+words[4]+"_in ~"+words[1]+"_in "+words[5]+"_out "+words[6]+"_out "+compName)
        k=k+1
       # Add digital to analog converter for outputs
        schematicInfo.append("a"+str(k)+" ["+words[5]+"_out "+words[6]+"_out] ["+words[5]+" "+words[6]+"] "+" "+compName+"dac")
        k=k+1
        if len(words)>11: 
         # Add analog to digital converter for inputs
          schematicInfo.append("a"+str(k)+" ["+words[12]+" "+words[11]+" "+words[10]+" "+words[13]+"] ["+words[12]+"_in "+words[11]+"_in "+words[10]+"_in "+words[13]+"_in] "+compName+"adc")
          k=k+1
         # Add D Flip-flop
          schematicInfo.append("a"+str(k)+" "+words[12]+"_in "+words[11]+"_in ~"+words[10]+"_in ~"+words[13]+"_in "+words[9]+"_out "+words[8]+"_out "+compName)
          k=k+1
         # Add digital to analog converter for outputs
          schematicInfo.append("a"+str(k)+" ["+words[9]+"_out "+words[8]+"_out] ["+words[9]+" "+words[8]+"] "+" "+compName+"dac")
          k=k+1
       # Insert comment in-place of components
        schematicInfo.insert(index,"* "+compType)
       # Add model for D Flip-Flop
        schematicInfo.append(".model "+ compName+" d_dff")
       # Add model for analog-to-digital bridge
        schematicInfo.append(".model "+ compName+"adc adc_bridge(in_low=0.8 in_high=2.0)")
       # Add model for digital-to-analog bridge
        schematicInfo.append(".model "+ compName+"dac dac_bridge(out_low=0.25 out_high=5.0 out_undef=1.8 t_rise=0.5e-9 t_fall=0.5e-9)")
      elif (compType=="74107" or compType=="74hc107" or compType=="74ls107"):
        if len(words)>11: 
         # Add analog to digital converter for inputs
          schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[4]+" "+words[12]+" "+words[13]+"] ["+words[1]+"_in "+words[4]+"_in "+words[12]+"_in "+words[13]+"_in] "+compName+"adc")
          k=k+1
         # Add J-K Flip-flop
          schematicInfo.append("a"+str(k)+" "+words[1]+"_in "+words[4]+"_in ~"+words[12]+"_in ~"+words[13]+"_in ~"+words[13]+"_in "+words[3]+"_out "+words[2]+"_out "+compName)
          k=k+1
         # Add digital to analog converter for outputs
          schematicInfo.append("a"+str(k)+" ["+words[3]+"_out "+words[2]+"_out] ["+words[3]+" "+words[2]+"] "+" "+compName+"dac")
          k=k+1

         # Add analog to digital converter for inputs
          schematicInfo.append("a"+str(k)+" ["+words[8]+" "+words[11]+" "+words[9]+" "+words[10]+"] ["+words[8]+"_in "+words[11]+"_in "+words[9]+"_in "+words[10]+"_in] "+compName+"adc")
          k=k+1
         # Add J-K Flip-flop
          schematicInfo.append("a"+str(k)+" "+words[8]+"_in "+words[11]+"_in ~"+words[9]+"_in ~"+words[10]+"_in ~"+words[10]+"_in "+words[5]+"_out "+words[6]+"_out "+compName)
          k=k+1
         # Add digital to analog converter for outputs
          schematicInfo.append("a"+str(k)+" ["+words[5]+"_out "+words[6]+"_out] ["+words[5]+" "+words[6]+"] "+" "+compName+"dac")
          k=k+1
        else:
         # Add analog to digital converter for inputs
          schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[4]+" "+words[12]+" "+words[13]+"] ["+words[1]+"_in "+words[4]+"_in "+words[12]+"_in "+words[13]+"_in] "+compName+"adc")
          k=k+1
         # Add J-K Flip-flop
          schematicInfo.append("a"+str(k)+" "+words[1]+"_in "+words[4]+"_in ~"+words[12]+"_in ~"+words[13]+"_in ~"+words[13]+"_in "+words[3]+"_out "+words[2]+"_out "+compName)
          k=k+1
         # Add digital to analog converter for outputs
          schematicInfo.append("a"+str(k)+" ["+words[3]+"_out "+words[2]+"_out] ["+words[3]+" "+words[2]+"] "+" "+compName+"dac")
          k=k+1
       # Insert comment in-place of components
        schematicInfo.insert(index,"* "+compType)
       # Add model for JK Flip-Flop
        schematicInfo.append(".model "+ compName+" d_jkff")
       # Add model for analog-to-digital bridge
        schematicInfo.append(".model "+ compName+"adc adc_bridge(in_low=0.8 in_high=2.0)")
       # Add model for digital-to-analog bridge
        schematicInfo.append(".model "+ compName+"dac dac_bridge(out_low=0.25 out_high=5.0 out_undef=1.8 t_rise=0.5e-9 t_fall=0.5e-9)")
      elif (compType=="74109" or compType=="74hc109" or compType=="74ls109"):
       # Add analog to digital converter for inputs
        schematicInfo.append("a"+str(k)+" ["+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[1]+"] ["+words[2]+"_in "+words[3]+"_in "+words[4]+"_in "+words[5]+"_in "+words[1]+"_in] "+compName+"adc")
        k=k+1
       # Add J-K Flip-flop
        schematicInfo.append("a"+str(k)+" "+words[2]+"_in ~"+words[3]+"_in "+words[4]+"_in ~"+words[5]+"_in ~"+words[1]+"_in "+words[6]+"_out "+words[7]+"_out "+compName)
        k=k+1
       # Add digital to analog converter for outputs
        schematicInfo.append("a"+str(k)+" ["+words[6]+"_out "+words[7]+"_out] ["+words[6]+" "+words[7]+"] "+" "+compName+"dac")
        k=k+1
        if len(words)>12: 
         # Add analog to digital converter for inputs
          schematicInfo.append("a"+str(k)+" ["+words[14]+" "+words[13]+" "+words[12]+" "+words[11]+" "+words[15]+"] ["+words[14]+"_in "+words[13]+"_in "+words[12]+"_in "+words[11]+"_in "+words[15]+"_in] "+compName+"adc")
          k=k+1
         # Add J-K Flip-flop
          schematicInfo.append("a"+str(k)+" "+words[14]+"_in ~"+words[13]+"_in "+words[12]+"_in ~"+words[11]+"_in ~"+words[15]+"_in "+words[10]+"_out "+words[9]+"_out "+compName)
          k=k+1
         # Add digital to analog converter for outputs
          schematicInfo.append("a"+str(k)+" ["+words[10]+"_out "+words[9]+"_out] ["+words[10]+" "+words[9]+"] "+" "+compName+"dac")
          k=k+1
       # Insert comment in-place of components
        schematicInfo.insert(index,"* "+compType)
       # Add model for JK Flip-Flop
        schematicInfo.append(".model "+ compName+" d_jkff")
       # Add model for analog-to-digital bridge
        schematicInfo.append(".model "+ compName+"adc adc_bridge(in_low=0.8 in_high=2.0)")
       # Add model for digital-to-analog bridge
        schematicInfo.append(".model "+ compName+"dac dac_bridge(out_low=0.25 out_high=5.0 out_undef=1.8 t_rise=0.5e-9 t_fall=0.5e-9)")
      elif (compType=="74112" or compType=="74hc112" or compType=="74ls112"):
        if len(words)>12: 
          schematicInfo.append("a"+str(k)+" "+words[3]+" "+words[2]+" ~"+words[1]+" ~"+words[4]+" ~"+words[15]+" "+words[5]+" "+words[6]+" "+compName)
          k=k+1
          schematicInfo.append("a"+str(k)+" "+words[11]+" "+words[12]+" ~"+words[13]+" ~"+words[10]+" ~"+words[14]+" "+words[9]+" "+words[7]+" "+compName)
          k=k+1
        else:
          schematicInfo.append("a"+str(k)+" "+words[3]+" "+words[2]+" ~"+words[1]+" ~"+words[4]+" ~"+words[8]+" "+words[5]+" "+words[6]+" "+compName)
          k=k+1
        schematicInfo.insert(index,"* "+compType)
        schematicInfo.append(".model "+ compName+" d_jkff")
      elif compType=="dac":
        schematicInfo.append("a"+str(k)+" ["+words[1]+"] ["+words[2]+"] "+compName)
        k=k+1
        schematicInfo.insert(index,"* Digital to Analog converter "+compType)
        schematicInfo.append(".model "+ compName+" dac_bridge")
      elif compType=="adc":
        schematicInfo.append("a"+str(k)+" ["+words[1]+"] ["+words[2]+"] "+compName)
        k=k+1
        schematicInfo.insert(index,"* Analog to Digital converter "+compType)
        schematicInfo.append(".model "+ compName+" adc_bridge")
      elif compType=="adc8":
        for i in range(0,len(words)/2-1):
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"] ["+words[i+len(words)/2]+"] "+compName)
          k=k+1
        schematicInfo.insert(index,"* Analog to Digital converter "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for analog to digital converter "+compName
	in_low=raw_input('  Enter input low level voltage (default=0.8): ')
	in_high=raw_input('  Enter input high level voltage (default=2.0): ')
        print "-----------------------------------------------------------"
        if in_low=="": in_low="0.8"
        if in_high=="": in_high="2.0"
        schematicInfo.append(".model "+ compName+" adc_bridge(in_low="+in_low+" in_high="+in_high+" )")
      elif compType=="dac8":
        for i in range(0,len(words)/2-1):
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"] ["+words[i+len(words)/2]+"] "+compName)
          k=k+1
        schematicInfo.insert(index,"* Digital to Analog converter "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for digital to analog converter "+compName
	out_low=raw_input('  Enter output low level voltage (default=0.2): ')
	out_high=raw_input('  Enter output high level voltage (default=5.0): ')
	out_undef=raw_input('  Enter output for undefined voltage level (default=2.2): ')
        print "-----------------------------------------------------------"
        if out_low=="": out_low="0.2"
        if out_high=="": out_high="5.0"
        if out_undef=="": out_undef="5.0"
        schematicInfo.append(".model "+ compName+" dac_bridge(out_low="+out_low+" out_high="+out_high+" out_undef="+out_undef+" )")
      elif compType=="gain":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Gain "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Gain "+compName
	in_offset=raw_input('  Enter offset for input (default=0.0): ')
	gain=raw_input('  Enter gain (default=1.0): ')
	out_offset=raw_input('  Enter offset for output (default=0.0): ')
        print "-----------------------------------------------------------"
        if in_offset=="": in_offset="0.0"
        if gain=="": gain="1.0"
        if out_offset=="": out_offset="0.0"
        schematicInfo.append(".model "+ compName+" gain(in_offset="+in_offset+" out_offset="+out_offset+" gain="+gain+")")
      elif compType=="summer":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Summer "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Summer "+compName
	in1_offset=raw_input('  Enter offset for input 1 (default=0.0): ')
	in2_offset=raw_input('  Enter offset for input 2 (default=0.0): ')
	in1_gain=raw_input('  Enter gain for input 1 (default=1.0): ')
	in2_gain=raw_input('  Enter gain for input 2 (default=1.0): ')
	out_gain=raw_input('  Enter gain for output (default=1.0): ')
	out_offset=raw_input('  Enter offset for output (default=0.0): ')
        print "-----------------------------------------------------------"
        if in1_offset=="": in1_offset="0.0"
        if in2_offset=="": in2_offset="0.0"
        if in1_gain=="": in1_gain="1.0"
        if in2_gain=="": in2_gain="1.0"
        if out_gain=="": out_gain="1.0"
        if out_offset=="": out_offset="0.0"
        schematicInfo.append(".model "+ compName+" summer(in_offset=["+in1_offset+" "+in2_offset+"] in_gain=["+in1_gain+" "+in2_gain+"] out_offset="+out_offset+" out_gain="+out_gain+")")
      elif compType=="multiplier":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Multiplier "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Multiplier "+compName
	in1_offset=raw_input('  Enter offset for input 1 (default=0.0): ')
	in2_offset=raw_input('  Enter offset for input 2 (default=0.0): ')
	in1_gain=raw_input('  Enter gain for input 1 (default=1.0): ')
	in2_gain=raw_input('  Enter gain for input 2 (default=1.0): ')
	out_gain=raw_input('  Enter gain for output (default=1.0): ')
	out_offset=raw_input('  Enter offset for output (default=0.0): ')
        print "-----------------------------------------------------------"
        if in1_offset=="": in1_offset="0.0"
        if in2_offset=="": in2_offset="0.0"
        if in1_gain=="": in1_gain="1.0"
        if in2_gain=="": in2_gain="1.0"
        if out_gain=="": out_gain="1.0"
        if out_offset=="": out_offset="0.0"
        schematicInfo.append(".model "+ compName+" mult(in_offset=["+in1_offset+" "+in2_offset+"] in_gain=["+in1_gain+" "+in2_gain+"] out_offset="+out_offset+" out_gain="+out_gain+")")
      elif compType=="divider":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Divider "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Divider "+compName
	num_offset=raw_input('  Enter offset for numerator (default=0.0): ')
	den_offset=raw_input('  Enter offset for denominator (default=0.0): ')
	num_gain=raw_input('  Enter gain for numerator (default=1.0): ')
	den_gain=raw_input('  Enter gain for denominator (default=1.0): ')
	out_gain=raw_input('  Enter gain for output (default=1.0): ')
	out_offset=raw_input('  Enter offset for output (default=0.0): ')
	den_lower_limit=raw_input('  Enter lower limit for denominator value (default=1.0e-10): ')
        print "-----------------------------------------------------------"
        if num_offset=="": num_offset="0.0"
        if den_offset=="": den_offset="0.0"
        if num_gain=="": num_gain="1.0"
        if den_gain=="": den_gain="1.0"
        if out_gain=="": out_gain="1.0"
        if out_offset=="": out_offset="0.0"
        if den_lower_limit=="": den_lower_limit="1.0e-10"
        schematicInfo.append(".model "+ compName+" divide(num_offset="+num_offset+" den_offset="+den_offset+" num_gain="+num_gain+" den_gain="+den_gain+" out_offset="+out_offset+" out_gain="+out_gain+" den_lower_limit="+den_lower_limit+")")
      elif compType=="limit":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Limiter "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Limiter "+compName
	lowerLimit=raw_input('  Enter out lower limit (default=0.0): ')
	upperLimit=raw_input('  Enter out upper limit (default=5.0): ')
	in_offset=raw_input('  Enter offset for input (default=0.0): ')
	gain=raw_input('  Enter gain (default=1.0): ')
        print "-----------------------------------------------------------"
        if lowerLimit=="": lowerLimit="0.0"
        if upperLimit=="": upperLimit="5.0"
        if in_offset=="": in_offset="0.0"
        if gain=="": gain="1.0"
        schematicInfo.append(".model "+ compName+" limit(out_lower_limit="+lowerLimit+" out_upper_limit="+upperLimit+" in_offset="+in_offset+" gain="+gain+")")
      elif compType=="integrator":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Integrator "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Integrator "+compName
	out_lower_limit=raw_input('  Enter out lower limit (default=0.0): ')
	out_upper_limit=raw_input('  Enter out upper limit (default=5.0): ')
	in_offset=raw_input('  Enter offset for input (default=0.0): ')
	gain=raw_input('  Enter gain (default=1.0): ')
	out_ic=raw_input('  Enter initial condition on output (default=0.0): ')
        print "-----------------------------------------------------------"
        if out_lower_limit=="": out_lower_limit="0.0"
        if out_upper_limit=="": out_upper_limit="5.0"
        if in_offset=="": in_offset="0.0"
        if gain=="": gain="1.0"
        if out_ic=="": out_ic="0.0"
        schematicInfo.append(".model "+ compName+" int(out_lower_limit="+out_lower_limit+" out_upper_limit="+out_upper_limit+" in_offset="+in_offset+" gain="+gain+" out_ic="+out_ic+")")
      elif compType=="differentiator":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Differentiator "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Differentiator "+compName
	out_lower_limit=raw_input('  Enter out lower limit (default=0.0): ')
	out_upper_limit=raw_input('  Enter out upper limit (default=5.0): ')
	out_offset=raw_input('  Enter offset for output (default=0.0): ')
	gain=raw_input('  Enter gain (default=1.0): ')
        print "-----------------------------------------------------------"
        if out_lower_limit=="": out_lower_limit="0.0"
        if out_upper_limit=="": out_upper_limit="5.0"
        if out_offset=="": out_offset="0.0"
        if gain=="": gain="1.0"
        schematicInfo.append(".model "+ compName+" d_dt(out_lower_limit="+out_lower_limit+" out_upper_limit="+out_upper_limit+" out_offset="+out_offset+" gain="+gain+")")
      elif compType=="limit8":
        for i in range(0,len(words)/2-1):
          schematicInfo.append("a"+str(k)+" "+words[i+1]+" "+words[i+len(words)/2]+" "+compName)
          k=k+1
        schematicInfo.insert(index,"* Limiter "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Limiter "+compName
	lowerLimit=raw_input('  Enter out lower limit (default=0.0): ')
	upperLimit=raw_input('  Enter out upper limit (default=5.0): ')
	in_offset=raw_input('  Enter offset for input (default=0.0): ')
	gain=raw_input('  Enter gain (default=1.0): ')
        print "-----------------------------------------------------------"
        if lowerLimit=="": lowerLimit="0.0"
        if upperLimit=="": upperLimit="5.0"
        if in_offset=="": in_offset="0.0"
        if gain=="": gain="1.0"
        schematicInfo.append(".model "+ compName+" limit(out_lower_limit="+lowerLimit+" out_upper_limit="+upperLimit+" in_offset="+in_offset+" gain="+gain+")")
      elif compType=="controlledlimiter":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Controlled Limiter "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Controlled Limiter "+compName
	in_offset=raw_input('  Enter offset for input (default=0.0): ')
	gain=raw_input('  Enter gain (default=1.0): ')
        print "-----------------------------------------------------------"
        if in_offset=="": in_offset="0.0"
        if gain=="": gain="1.0"
        schematicInfo.append(".model "+ compName+" climit(in_offset="+in_offset+" gain="+gain+")")
      elif compType=="analogswitch":
        schematicInfo.append("a"+str(k)+" "+words[1]+" ("+words[2]+" "+words[3]+") "+compName)
        k=k+1
        schematicInfo.insert(index,"* Analog Switch "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Analog Switch "+compName
	cntl_on=raw_input('  Enter control ON voltage (default=5.0): ')
	cntl_off=raw_input('  Enter control OFF voltage (default=0.0): ')
	r_on=raw_input('  Enter ON resistance value (default=10.0): ')
	r_off=raw_input('  Enter OFF resistance value (default=1e6): ')
        print "-----------------------------------------------------------"
        if cntl_on=="": cntl_on="5.0"
        if cntl_off=="": cntl_off="0.0"
        if r_on=="": r_on="10.0"
        if r_off=="": r_off="1e6"
        schematicInfo.append(".model "+ compName+" aswitch(cntl_on="+cntl_on+" cntl_off="+cntl_off+" r_on="+r_on+" r_off="+r_off+")")
      elif compType=="zener":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Zener Diode "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Zener Diode "+compName
	v_breakdown=raw_input('  Enter Breakdown voltage (default=5.6): ')
	i_breakdown=raw_input('  Enter Breakdown current (default=2.0e-2): ')
	i_sat=raw_input('  Enter saturation current (default=1.0e-12): ')
	n_forward=raw_input('  Enter forward emission coefficient (default=0.0): ')
        print "-----------------------------------------------------------"
        if v_breakdown=="": v_breakdown="5.6"
        if i_breakdown=="": i_breakdown="1.0e-2"
        if i_sat=="": i_sat="1.0e-12"
        if n_forward=="": n_forward="1.0"
        schematicInfo.append(".model "+ compName+" zener(v_breakdown="+v_breakdown+" i_breakdown="+i_breakdown+" i_sat="+i_sat+" n_forward="+n_forward+")")
      elif compType=="d_buffer":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Buffer "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Buffer "+compName
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
	input_load=raw_input('  Enter input load capacitance (default=1e-12): ')
        print "-----------------------------------------------------------"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        if input_load=="": input_load="1e-12"
        schematicInfo.append(".model "+ compName+" d_buffer(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")")
      elif compType=="d_inverter":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Inverter "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Inverter "+compName
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
	input_load=raw_input('  Enter input load capacitance (default=1e-12): ')
        print "-----------------------------------------------------------"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        if input_load=="": input_load="1e-12"
        schematicInfo.append(".model "+ compName+" d_inverter(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")")
      elif compType=="d_and":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* And "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for And "+compName
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
	input_load=raw_input('  Enter input load capacitance (default=1e-12): ')
        print "-----------------------------------------------------------"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        if input_load=="": input_load="1e-12"
        schematicInfo.append(".model "+ compName+" d_and(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")")
      elif compType=="d_nand":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Nand "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Nand "+compName
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
	input_load=raw_input('  Enter input load capacitance (default=1e-12): ')
        print "-----------------------------------------------------------"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        if input_load=="": input_load="1e-12"
        schematicInfo.append(".model "+ compName+" d_nand(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")")
      elif compType=="d_or":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* OR "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for OR "+compName
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
	input_load=raw_input('  Enter input load capacitance (default=1e-12): ')
        print "-----------------------------------------------------------"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        if input_load=="": input_load="1e-12"
        schematicInfo.append(".model "+ compName+" d_or(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")")
      elif compType=="d_nor":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* NOR "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for NOR "+compName
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
	input_load=raw_input('  Enter input load capacitance (default=1e-12): ')
        print "-----------------------------------------------------------"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        if input_load=="": input_load="1e-12"
        schematicInfo.append(".model "+ compName+" d_nor(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")")
      elif compType=="d_xor":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* XOR "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for XOR "+compName
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
	input_load=raw_input('  Enter input load capacitance (default=1e-12): ')
        print "-----------------------------------------------------------"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        if input_load=="": input_load="1e-12"
        schematicInfo.append(".model "+ compName+" d_xor(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")")
      elif compType=="d_xnor":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* XNOR "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for XNOR "+compName
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
	input_load=raw_input('  Enter input load capacitance (default=1e-12): ')
        print "-----------------------------------------------------------"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        if input_load=="": input_load="1e-12"
        schematicInfo.append(".model "+ compName+" d_xnor(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")")
      elif compType=="d_tristate":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Tristate "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Tristate "+compName
	delay=raw_input('  Enter delay (default=1e-12): ')
	input_load=raw_input('  Enter input load capacitance (default=1e-12): ')
	enable_load=raw_input('  Enter enable load capacitance (default=1e-12): ')
        print "-----------------------------------------------------------"
        if delay=="": delay="1e-12"
        if input_load=="": input_load="1e-12"
        if enable_load=="": enable_load="1e-12"
        schematicInfo.append(".model "+ compName+" d_tristate(delay="+delay+" enable_load="+enable_load+" input_load="+input_load+")")
      elif compType=="d_pullup":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Pullup "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Pullup "+compName
	load=raw_input('  Enter load capacitance (default=1e-12): ')
        print "-----------------------------------------------------------"
        if load=="": load="1e-12"
        schematicInfo.append(".model "+ compName+" d_pullup(load="+load+")")
      elif compType=="d_pulldown":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* Pullup "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for Pullup "+compName
	load=raw_input('  Enter load capacitance (default=1e-12): ')
        print "-----------------------------------------------------------"
        if load=="": load="1e-12"
        schematicInfo.append(".model "+ compName+" d_pulldown(load="+load+")")
      elif compType=="d_srlatch":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+words[7]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* SR Latch "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for SR Latch "+compName
	sr_delay=raw_input('  Enter input to set-reset delay (default=1e-12): ')
	enable_delay=raw_input('  Enter enable delay (default=1e-12): ')
	set_delay=raw_input('  Enter set delay (default=1e-12): ')
	reset_delay=raw_input('  Enter reset delay (default=1e-12): ')
	ic=raw_input('  Enter initial condition on output (default=0): ')
	sr_load=raw_input('  Enter input to set-reset load (default=1e-12): ')
	enable_load=raw_input('  Enter enable load (default=1e-12): ')
	set_load=raw_input('  Enter set load (default=1e-12): ')
	reset_load=raw_input('  Enter reset load (default=1e-12): ')
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
        print "-----------------------------------------------------------"
        if sr_delay=="": sr_delay="1e-12"
        if enable_delay=="": enable_delay="1e-12"
        if set_delay=="": set_delay="1e-12"
        if reset_delay=="": reset_delay="1e-12"
        if ic=="": ic="0"
        if sr_load=="": sr_load="1e-12"
        if enable_load=="": enable_load="1e-12"
        if set_load=="": set_load="1e-12"
        if reset_load=="": reset_load="1e-12"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        schematicInfo.append(".model "+ compName+" d_srlatch(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+sr_load="+sr_load+" enable_load="+enable_load+" set_load="+set_load+" reset_load="+reset_load+"\n+sr_delay="+sr_delay+" enable_delay="+enable_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")")
      elif compType=="d_jklatch":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+words[7]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* JK Latch "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for JK Latch "+compName
	jk_delay=raw_input('  Enter input to j-k delay (default=1e-12): ')
	enable_delay=raw_input('  Enter enable delay (default=1e-12): ')
	set_delay=raw_input('  Enter set delay (default=1e-12): ')
	reset_delay=raw_input('  Enter reset delay (default=1e-12): ')
	ic=raw_input('  Enter initial condition on output (default=0): ')
	jk_load=raw_input('  Enter input to j-k load (default=1e-12): ')
	enable_load=raw_input('  Enter enable load (default=1e-12): ')
	set_load=raw_input('  Enter set load (default=1e-12): ')
	reset_load=raw_input('  Enter reset load (default=1e-12): ')
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
        print "-----------------------------------------------------------"
        if jk_delay=="": jk_delay="1e-12"
        if enable_delay=="": enable_delay="1e-12"
        if set_delay=="": set_delay="1e-12"
        if reset_delay=="": reset_delay="1e-12"
        if ic=="": ic="0"
        if jk_load=="": jk_load="1e-12"
        if enable_load=="": enable_load="1e-12"
        if set_load=="": set_load="1e-12"
        if reset_load=="": reset_load="1e-12"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        schematicInfo.append(".model "+ compName+" d_jklatch(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+jk_load="+jk_load+" enable_load="+enable_load+" set_load="+set_load+" reset_load="+reset_load+"\n+jk_delay="+jk_delay+" enable_delay="+enable_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")")
      elif compType=="d_dlatch":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* D Latch "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for D Latch "+compName
	data_delay=raw_input('  Enter input to data delay (default=1e-12): ')
	enable_delay=raw_input('  Enter enable delay (default=1e-12): ')
	set_delay=raw_input('  Enter set delay (default=1e-12): ')
	reset_delay=raw_input('  Enter reset delay (default=1e-12): ')
	ic=raw_input('  Enter initial condition on output (default=0): ')
	data_load=raw_input('  Enter input to data load (default=1e-12): ')
	enable_load=raw_input('  Enter enable load (default=1e-12): ')
	set_load=raw_input('  Enter set load (default=1e-12): ')
	reset_load=raw_input('  Enter reset load (default=1e-12): ')
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
        print "-----------------------------------------------------------"
        if data_delay=="": data_delay="1e-12"
        if enable_delay=="": enable_delay="1e-12"
        if set_delay=="": set_delay="1e-12"
        if reset_delay=="": reset_delay="1e-12"
        if ic=="": ic="0"
        if data_load=="": data_load="1e-12"
        if enable_load=="": enable_load="1e-12"
        if set_load=="": set_load="1e-12"
        if reset_load=="": reset_load="1e-12"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        schematicInfo.append(".model "+ compName+" d_dlatch(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+data_load="+data_load+" enable_load="+enable_load+" set_load="+set_load+" reset_load="+reset_load+"\n+data_delay="+data_delay+" enable_delay="+enable_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")")
      elif compType=="d_tlatch":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* T Latch "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for T Latch "+compName
	t_delay=raw_input('  Enter input to t delay (default=1e-12): ')
	enable_delay=raw_input('  Enter enable delay (default=1e-12): ')
	set_delay=raw_input('  Enter set delay (default=1e-12): ')
	reset_delay=raw_input('  Enter reset delay (default=1e-12): ')
	ic=raw_input('  Enter initial condition on output (default=0): ')
	t_load=raw_input('  Enter input to t load (default=1e-12): ')
	enable_load=raw_input('  Enter enable load (default=1e-12): ')
	set_load=raw_input('  Enter set load (default=1e-12): ')
	reset_load=raw_input('  Enter reset load (default=1e-12): ')
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
        print "-----------------------------------------------------------"
        if t_delay=="": t_delay="1e-12"
        if enable_delay=="": enable_delay="1e-12"
        if set_delay=="": set_delay="1e-12"
        if reset_delay=="": reset_delay="1e-12"
        if ic=="": ic="0"
        if t_load=="": t_load="1e-12"
        if enable_load=="": enable_load="1e-12"
        if set_load=="": set_load="1e-12"
        if reset_load=="": reset_load="1e-12"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        schematicInfo.append(".model "+ compName+" d_tlatch(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+t_load="+t_load+" enable_load="+enable_load+" set_load="+set_load+" reset_load="+reset_load+"\n+t_delay="+t_delay+" enable_delay="+enable_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")")
      elif compType=="d_srff":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+words[7]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* SR Flip-Flop "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for SR Flip-Flop "+compName
	clk_delay=raw_input('  Enter clk delay (default=1e-12): ')
	set_delay=raw_input('  Enter set delay (default=1e-12): ')
	reset_delay=raw_input('  Enter reset delay (default=1e-12): ')
	ic=raw_input('  Enter initial condition on output (default=0): ')
	sr_load=raw_input('  Enter input to set-reset load (default=1e-12): ')
	clk_load=raw_input('  Enter clk load (default=1e-12): ')
	set_load=raw_input('  Enter set load (default=1e-12): ')
	reset_load=raw_input('  Enter reset load (default=1e-12): ')
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
        print "-----------------------------------------------------------"
        if clk_delay=="": clk_delay="1e-12"
        if set_delay=="": set_delay="1e-12"
        if reset_delay=="": reset_delay="1e-12"
        if ic=="": ic="0"
        if sr_load=="": sr_load="1e-12"
        if clk_load=="": clk_load="1e-12"
        if set_load=="": set_load="1e-12"
        if reset_load=="": reset_load="1e-12"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        schematicInfo.append(".model "+ compName+" d_srff(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+sr_load="+sr_load+" clk_load="+clk_load+" set_load="+set_load+" reset_load="+reset_load+"\n+clk_delay="+clk_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")")
      elif compType=="d_jkff":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+words[7]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* JK Flip-Flop "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for JK Flip-Flop "+compName
	clk_delay=raw_input('  Enter clk delay (default=1e-12): ')
	set_delay=raw_input('  Enter set delay (default=1e-12): ')
	reset_delay=raw_input('  Enter reset delay (default=1e-12): ')
	ic=raw_input('  Enter initial condition on output (default=0): ')
	jk_load=raw_input('  Enter input to j-k load (default=1e-12): ')
	clk_load=raw_input('  Enter clk load (default=1e-12): ')
	set_load=raw_input('  Enter set load (default=1e-12): ')
	reset_load=raw_input('  Enter reset load (default=1e-12): ')
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
        print "-----------------------------------------------------------"
        if clk_delay=="": clk_delay="1e-12"
        if set_delay=="": set_delay="1e-12"
        if reset_delay=="": reset_delay="1e-12"
        if ic=="": ic="0"
        if jk_load=="": jk_load="1e-12"
        if clk_load=="": clk_load="1e-12"
        if set_load=="": set_load="1e-12"
        if reset_load=="": reset_load="1e-12"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        schematicInfo.append(".model "+ compName+" d_jkff(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+jk_load="+jk_load+" clk_load="+clk_load+" set_load="+set_load+" reset_load="+reset_load+"\n+clk_delay="+clk_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")")
      elif compType=="d_dff":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* D Flip-Flop "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for D Flip-Flop "+compName
	clk_delay=raw_input('  Enter clk delay (default=1e-12): ')
	set_delay=raw_input('  Enter set delay (default=1e-12): ')
	reset_delay=raw_input('  Enter reset delay (default=1e-12): ')
	ic=raw_input('  Enter initial condition on output (default=0): ')
	data_load=raw_input('  Enter input to data load (default=1e-12): ')
	clk_load=raw_input('  Enter clk load (default=1e-12): ')
	set_load=raw_input('  Enter set load (default=1e-12): ')
	reset_load=raw_input('  Enter reset load (default=1e-12): ')
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
        print "-----------------------------------------------------------"
        if clk_delay=="": clk_delay="1e-12"
        if set_delay=="": set_delay="1e-12"
        if reset_delay=="": reset_delay="1e-12"
        if ic=="": ic="0"
        if data_load=="": data_load="1e-12"
        if clk_load=="": clk_load="1e-12"
        if set_load=="": set_load="1e-12"
        if reset_load=="": reset_load="1e-12"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        schematicInfo.append(".model "+ compName+" d_dff(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+data_load="+data_load+" clk_load="+clk_load+" set_load="+set_load+" reset_load="+reset_load+"\n+clk_delay="+clk_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")")
      elif compType=="d_tff":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+compName)
        k=k+1
        schematicInfo.insert(index,"* T Flip-Flop "+compType)
        print "-----------------------------------------------------------\n"
        print "Add parameters for T Flip-Flip "+compName
	clk_delay=raw_input('  Enter clk delay (default=1e-12): ')
	set_delay=raw_input('  Enter set delay (default=1e-12): ')
	reset_delay=raw_input('  Enter reset delay (default=1e-12): ')
	ic=raw_input('  Enter initial condition on output (default=0): ')
	t_load=raw_input('  Enter input to t load (default=1e-12): ')
	clk_load=raw_input('  Enter clk load (default=1e-12): ')
	set_load=raw_input('  Enter set load (default=1e-12): ')
	reset_load=raw_input('  Enter reset load (default=1e-12): ')
	rise_delay=raw_input('  Enter rise delay (default=1e-12): ')
	fall_delay=raw_input('  Enter fall delay (default=1e-12): ')
        print "-----------------------------------------------------------"
        if t_delay=="": t_delay="1e-12"
        if enable_delay=="": enable_delay="1e-12"
        if set_delay=="": set_delay="1e-12"
        if reset_delay=="": reset_delay="1e-12"
        if ic=="": ic="0"
        if t_load=="": t_load="1e-12"
        if enable_load=="": enable_load="1e-12"
        if set_load=="": set_load="1e-12"
        if reset_load=="": reset_load="1e-12"
        if rise_delay=="": rise_delay="1e-12"
        if fall_delay=="": fall_delay="1e-12"
        schematicInfo.append(".model "+ compName+" d_tff(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+t_load="+t_load+" clk_load="+clk_load+" set_load="+set_load+" reset_load="+reset_load+"\n+clk_delay="+clk_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")")
      elif compType=="vplot1":
        outputOption.append("plot v("+words[1]+")\n")
        schematicInfo.insert(index,"* Plotting option "+compType)
      elif compType=="vplot8_1":
        outputOption.append("plot ")
        for i in range(1,len(words)-1):
          outputOption.append("v("+words[i]+") ")
        outputOption.append("\n")
        schematicInfo.insert(index,"* Plotting option "+compType)
      elif compType=="vprint1":
        outputOption.append("print v("+words[1]+")\n")
        schematicInfo.insert(index,"* Printing option "+compType)
      elif compType=="vprint8_1":
        outputOption.append("print ")
        for i in range(1,len(words)-1):
          outputOption.append("v("+words[i]+") ")
        outputOption.append("\n")
        schematicInfo.insert(index,"* Printing option "+compType)
      elif compType=="vplot":
        outputOption.append("plot v("+words[1]+")-v("+words[2]+")\n")
        schematicInfo.insert(index,"* Plotting option "+compType)
      elif compType=="vplot8":
        outputOption.append("plot ")
        for i in range(0,len(words)/2-1):
          if words[i+1]=="0":
            outputOption.append("-v("+words[i+len(words)/2]+") ")
          elif words[i+len(words)/2]=="0":
            outputOption.append("v("+words[i+1]+") ")
          else:
            outputOption.append("v("+words[i+1]+")-v("+words[i+len(words)/2]+") ")
        outputOption.append("\n")
      elif compType=="vprint":
        outputOption.append("print v("+words[1]+")-v("+words[2]+")\n")
        schematicInfo.insert(index,"* Printting option "+compType)
      elif compType=="iplot":
        schematicInfo.insert(index,"V_"+words[0]+" "+words[1]+" "+words[2]+" 0")
        outputOption.append("plot i(V_"+words[0]+")\n")
      elif compType=="ic":
        print "-----------------------------------------------------------"
	ic=raw_input('  Enter initial condition on output (default=0): ')
        print "-----------------------------------------------------------"
        if ic=="": ic="0"
        schematicInfo.insert(index,".ic v("+words[1]+")="+ic)
      elif compType=="transfo":
        schematicInfo.append("a"+str(k)+" ("+words[1]+" "+words[2]+") (2mmf "+words[2]+") primary")
        k=k+1
        print "-----------------------------------------------------------\n"
        print "Add parameters for primary "
	num_turns=raw_input('  Enter the number of turns in primary (default=310): ')	
        print "-----------------------------------------------------------\n"
        if num_turns=="": num_turns="310"
        schematicInfo.append(".model primary lcouple (num_turns = "+num_turns+ ")")
        schematicInfo.append("a"+str(k)+" (2mmf 3mmf) iron_core")
        k=k+1
        print "-----------------------------------------------------------\n"
        inp1=raw_input(' Do you want to populate the B-H table?y/n (if n, default values will be used): ')
        if inp1=='y' or inp1=='Y':
         print "Enter the values in the H, B table to construct B-H curve  "
	 inp="y"
	 h_array= "H_array = [ "
         b_array = "B_array = [ "
	 while inp=="y":
	   h1=raw_input('  Enter H value: ')
           h_array = h_array+ h1+" "
	   b1=raw_input('  Enter corresponding B value: ')
           b_array = b_array+ b1+" "
	   inp=raw_input(' Do you want to continue(y/n): ')
         modelline = h_array+" ] " + b_array+" ]"
        else:
         modelline = "H_array = [-1000 -500 -375 -250 -188 -125 -63 0 63 125 188 250 375 500 1000] B_array = [-3.13e-3 -2.63e-3 -2.33e-3 -1.93e-3 -1.5e-3 -6.25e-4 -2.5e-4 0 2.5e-4 6.25e-4 1.5e-3 1.93e-3 2.33e-3 2.63e-3 3.13e-3]"
        area =raw_input( 'Enter the cross-sectional area of the core: (default = 1)')
        length =raw_input( 'Enter the core length: (default = 0.01)')
        print "----------------------------------------------\n"
        if area=="": area="1"
        if length=="":length="0.01"
        schematicInfo.append(".model iron_core core ("+modelline+" area = "+area+" length = "+length +")")
        schematicInfo.append("a"+str(k)+" ("+words[4]+" "+words[3]+") (3mmf "+words[3]+") secondary")
        k=k+1
        print "-----------------------------------------------------------\n"
        print "Add parameters for secondary "
	num_turns2=raw_input('  Enter the number of turns in secondary (default=620): ')	
        print "-----------------------------------------------------------\n"
        if num_turns2=="": num_turns2="620"
        schematicInfo.append(".model secondary lcouple (num_turns = "+num_turns2+ ")")
      else: 
        schematicInfo.insert(index,compline)
    # Update option information
  return schematicInfo,outputOption

# Accept input file name from user if not provided
if len(sys.argv) < 2:
  filename=raw_input('Enter file name: ')
else:
  filename=sys.argv[1]

if len(sys.argv) < 3:
  finalNetlist=int(raw_input('Do you want to create final file: '))
else:
  finalNetlist=int(sys.argv[2])

print "=================================="
print "Kicad to Ngspice netlist converter "
print "=================================="
print "converting "+filename

# Read the netlist
lines=readNetlist(filename)

# Construct parameter information
param=readParamInfo(lines)

# Replace parameter with values
netlist, infoline=preprocessNetlist(lines,param)

# Separate option and schematic information
optionInfo, schematicInfo=separateNetlistInfo(netlist)

if finalNetlist:
 # Insert analysis from file
  optionInfo=addAnalysis(optionInfo)

# Find the analysis option
analysisOption=[]
outputOption=[]
initialCondOption=[]
simulatorOption=[]
includeOption=[]
model=[]

for eachline in optionInfo:
  words=eachline.split()
  option=words[0]
  if (option=='.ac' or option=='.dc' or 
      option=='.disto' or option=='.noise' or
      option=='.op' or option=='.pz' or
      option=='.sens' or option=='.tf' or
      option=='.tran'):
    analysisOption.append(eachline+'\n')
    print eachline
  elif (option=='.save' or option=='.print' or 
      option=='.plot' or option=='.four'):
    eachline=eachline.strip('.')
    outputOption.append(eachline+'\n')
  elif (option=='.nodeset' or option=='.ic'):  
    initialCondOption.append(eachline+'\n')
  elif option=='.option':  
    simulatorOption.append(eachline+'\n')
  elif (option=='.include' or option=='.lib'):
    includeOption.append(eachline+'\n')
  elif (option=='.model'):
    model.append(eachline+'\n')
  elif option=='.end':
    continue;

# Find the various model library required
modelList=[]
subcktList=[]
for eachline in schematicInfo:
  words=eachline.split()
  if eachline[0]=='d':
    modelName=words[3]
    if modelName in modelList:
      continue
    modelList.append(modelName)
  elif eachline[0]=='q':
    modelName=words[4]
    index=schematicInfo.index(eachline)
    schematicInfo.remove(eachline)
    schematicInfo.insert(index,words[0]+" "+words[3]+" "+words[2]+" "+words[1]+" "+words[4])
    if modelName in modelList:
       continue
    modelList.append(modelName)       
  elif eachline[0]=='m':
    modelName=words[4]
    index=schematicInfo.index(eachline)
    schematicInfo.remove(eachline)
    width=raw_input('  Enter width of mosfet '+words[0]+'(default=100u):')
    length=raw_input('  Enter length of mosfet '+words[0]+'(default=5u):')
    multiplicative_factor=raw_input('  Enter multiplicative factor of mosfet '+words[0]+'(default=1):')
    AD=raw_input('  Enter drain area, AD of mosfet '+words[0]+'(default=5*(L/2)*W): ')
    AS=raw_input('  Enter source area, AS of mosfet '+words[0]+'(default=5*(L/2)*W): ')
    PD=raw_input('  Enter drain perimeter, PD of mosfet '+words[0]+'(default=2*W+10*L/2): ')
    PS=raw_input('  Enter source perimeter, PS of mosfet '+words[0]+'(default=2*W+10*L/2): ')
    if width=="": width="0.0001"
    if multiplicative_factor=="": multiplicative_factor="1"
    if length=="": length="0.000005"
    if PD=="": PD = 2*float(width)+10*float(length)/2
    if PS=="": PS = 2*float(width)+10*float(length)/2
    if AD=="": AD = 5*(float(length)/2)*float(width)
    if AS=="": AS = 5*(float(length)/2)*float(width)
    
    schematicInfo.insert(index,words[0]+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[3]+" "+words[4]+" "+'M='+multiplicative_factor+" "+'L='+length+" "+'W='+width+" "+'PD='+str(PD)+" "+'PS='+str(PS)+" "+'AD='+str(AD)+" "+'AS='+str(AS))
    if modelName in modelList:
       continue
    modelList.append(modelName)
  elif eachline[0]=='j':
    modelName=words[4]
    index=schematicInfo.index(eachline)
    schematicInfo.remove(eachline)
    schematicInfo.insert(index,words[0]+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4])
    if modelName in modelList:
       continue
    modelList.append(modelName)
  elif eachline[0]=='x':
    subcktName=words[len(words)-1]
    if subcktName in subcktList:
      continue
    subcktList.append(subcktName)

# Find current through components
schematicInfo,outputOption=findCurrent(schematicInfo,outputOption)

# Add parameter to sources
schematicInfo=insertSpecialSourceParam(schematicInfo)

schematicInfo,outputOption=convertICintoBasicBlocks(schematicInfo,outputOption)

# Add newline in the schematic information
for i in range(len(schematicInfo),0,-1):
  schematicInfo.insert(i,'\n')

outfile=filename+".out"
cktfile=filename+".ckt"
out=open(outfile,"w")
ckt=open(cktfile,"w")
out.writelines(infoline)
out.writelines('\n')
ckt.writelines(infoline)
ckt.writelines('\n')

for modelName in modelList:
  if os.path.exists(modelName+".lib"):
    out.writelines('.include '+modelName+'.lib\n')
    ckt.writelines('.include '+modelName+'.lib\n')

for subcktName in subcktList:
  out.writelines('.include '+subcktName+'.sub\n')
  ckt.writelines('.include '+subcktName+'.sub\n')

if finalNetlist:
  sections=[simulatorOption, initialCondOption, schematicInfo, analysisOption]
else:
  sections=[simulatorOption, initialCondOption, schematicInfo]
for section in sections:
  if len(section) == 0:
    continue
  else:
   out.writelines('\n') 
   out.writelines(section)
   ckt.writelines('\n') 
   ckt.writelines(section)

if finalNetlist:
  out.writelines('\n* Control Statements \n')
  out.writelines('.control\n')
  out.writelines('run\n')
  out.writelines(outputOption)
  outputOption1=[]
  for option in outputOption:
    if (("plot" in option) or ("print" in option)):
      outputOption1.append("."+option)
    else:
      outputOption1.append(option)
  ckt.writelines(outputOption1)
  out.writelines('.endc\n')
  out.writelines('.end\n')
  ckt.writelines('.end\n')

out.close()
ckt.close()

print "The ngspice netlist has been written in "+filename+".out"
print "The scilab netlist has been written in "+filename+".ckt"
dummy=raw_input('Press Enter to quit')
