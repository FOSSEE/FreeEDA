#!/usr/bin/python
# createSubckt.py is a python script to convert a Kicad spice netlist to a ngspice subcircuit netlist. It developed for OSCAD software. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
# Copyright (C) 2012 Yogesh Dilip Save, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

import sys
import os.path
from setPath import OSCAD_HOME

def createSubckt(subcktName):
  """Read subcircuit netList"""
  command="xterm -e \""+OSCAD_HOME+"/kicadtoNgspice/KicadtoNgspice.py "+subcktName+".cir 0\""
  os.system(command)
  
# Open file if it exists
  if os.path.exists(subcktName+".cir.out"):
    try:
      f = open(subcktName+".cir.out")
    except :
      print("Error in opening circuit file.")
      return 1
  else:
    print subcktName + ".cir.out does not exist. Please create a spice netlist."
    return 1
  
# Read the data from file
  data=f.read()
  
# Close the file
  f.close()
  netlist=data.splitlines()

  newNetlist=[]
  for eachline in netlist:
    eachline=eachline.strip()
    if len(eachline)<1:
      continue
    words=eachline.split()
    if eachline[0]=='u':
      if words[len(words)-1]=="port":
        subcktInfo=".subckt "+subcktName+" "
        for i in range(1,len(words)-1):
          subcktInfo+=words[i]+" "
        continue
    if words[0]==".end":
      continue
    else:
      newNetlist.append(eachline)

  outfile=subcktName+".sub"
  out=open(outfile,"w")
  out.writelines("* Subcircuit " + subcktName)
  out.writelines('\n')
  out.writelines(subcktInfo)
  out.writelines('\n')
  
  # for subcktName in subcktList:
  #   out.writelines('.include '+subcktName+'.sub\n')
  #   ckt.writelines('.include '+subcktName+'.sub\n')
  
 # Add newline in the schematic information
  for i in range(len(newNetlist),0,-1):
    newNetlist.insert(i,'\n')

  out.writelines(newNetlist)
  out.writelines('\n') 
  
  out.writelines('.ends ' + subcktName)
  print "The subcircuit has been written in "+subcktName+".sub"
  return 0
