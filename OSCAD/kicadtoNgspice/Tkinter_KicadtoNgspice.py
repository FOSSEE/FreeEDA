#!/usr/bin/python
# KicadtoNgspice.py is a python script to convert a Kicad spice netlist to a ngspice netlist. It developed for OSCAD software. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
# Copyright (C) 2012 Yogesh Dilip Save, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

import sys
import os.path
import tkMessageBox
from setPath import OSCAD_HOME
from Tkinter import *

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
  """Open file if it exists"""
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
  #Find current through component by placing voltage source series with the component
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

def insertSpecialSourceParam(schematicInfo,sourcelist):
  #Inser Special source parameter
  schematicInfo1=[]
  
  for compline in schematicInfo:
    words=compline.split()
    compName=words[0]
  # Ask for parameters of source
    if compName[0]=='v' or compName=='i':
    # Find the index component from circuit
      index=schematicInfo.index(compline)
      #schematicInfo.remove(compline)
      if words[3]=="pulse":
	Title="Add parameters for pulse source "+compName
	v1='  Enter initial value(Volts/Amps): '
	v2='  Enter pulsed value(Volts/Amps): '
	td='  Enter delay time (seconds): '
	tr='  Enter rise time (seconds): '
	tf='  Enter fall time (seconds): '
	pw='  Enter pulse width (seconds): '
	tp='  Enter period (seconds): '
	sourcelist.append([index,compline,words[3],Title,v1,v2,td,tr,tf,pw,tp])
      
      elif words[3]=="sine":
	Title="Add parameters for sine source "+compName
	vo='  Enter offset value (Volts/Amps): '
	va='  Enter amplitude (Volts/Amps): '
	freq='  Enter frequency (Hz): '
	td='  Enter delay time (seconds): '
	theta='  Enter damping factor (1/seconds): '
	sourcelist.append([index,compline,words[3],Title,vo,va,freq,td,theta])
	
      elif words[3]=="pwl":
        Title="Add parameters for pwl source"+compName
        t_v=' Enter in pwl format without bracket i.e t1 v1 t2 v2.... '
	sourcelist.append([index,compline,words[3],Title,t_v])   
	
      elif words[3]=="ac":
	Title="Add parameters for ac source "+compName
	v_a='  Enter amplitude (Volts/Amps): '	  		 	 	   	
	sourcelist.append([index,compline,words[3],Title,v_a])

      elif words[3]=="exp":
	Title="Add parameters for exponential source "+compName
	v1='  Enter initial value(Volts/Amps): '
	v2='  Enter pulsed value(Volts/Amps): '
	td1='  Enter rise delay time (seconds): '
	tau1='  Enter rise time constant (seconds): '
	td2='  Enter fall time (seconds): '
	tau2='  Enter fall time constant (seconds): '
	sourcelist.append([index,compline,words[3],Title,v1,v2,td1,tau1,td2,tau2])

      elif words[3]=="dc":
	Title="Add parameters for DC source "+compName
	v1='  Enter value(Volts/Amps): '
	v2='  Enter zero frequency: '
	sourcelist.append([index,compline,words[3],Title,v1,v2])
      #schematicInfo.insert(index,compline)
      	
    elif compName[0]=='h' or compName[0]=='f':
    # Find the index component from the circuit
      index=schematicInfo.index(compline)
      schematicInfo.remove(compline)
      schematicInfo.insert(index,"* "+compName)
      schematicInfo1.append("V"+compName+" "+words[3]+" "+words[4]+" 0")
      schematicInfo1.append(compName+" "+words[1]+" "+words[2]+" "+"V"+compName+" "+words[5])
  schematicInfo=schematicInfo+schematicInfo1
  print sourcelist
  print schematicInfo
  return schematicInfo,sourcelist	
        	

def createrootwindow(sourcelist,sourcelisttrack):
	global frame
	global canvas
	global root_window	
	global window_height
	global window_width	
	root_window=Tk()
	window_width=700
	window_height=500
	canvas=Canvas(root_window,bg='#FFFFFF',width=window_width,height=window_height,scrollregion=(0,0,800,800))
        hbar=Scrollbar(root_window,orient=HORIZONTAL)
        hbar.pack(side=BOTTOM,fill=X)
        hbar.config(command=canvas.xview)
        vbar=Scrollbar(root_window,orient=VERTICAL)
        vbar.pack(side=RIGHT,fill=Y)
        vbar.config(command=canvas.yview)
        canvas.config(width=window_width,height=window_height)
    	canvas.config(xscrollcommand=hbar.set, yscrollcommand=vbar.set)
    	canvas.pack(side=LEFT,expand=True,fill=BOTH)
    	# make the canvas expandable
    	root_window.grid_rowconfigure(0, weight=1)
    	root_window.grid_columnconfigure(0, weight=1)
	frame=Frame(canvas,height=window_height,width=window_width)
	buttonframe=Frame(frame)
	#Addbutton=Button(buttonframe,text='Add',command=AddSourceValue)
	Nextbutton=Button(buttonframe,text='Next',command=NextPage)
        Clearbutton=Button(buttonframe,text='Clear',command=ClearSourceValue)
	global count
	count=0
	global entry_var
	entry_var={}
        ##Checking if source is present"
        if sourcelist:       
          for line in sourcelist:
	    print "Voltage source line index: ",line[0]
	    print "SourceList line Test: ",line	
	    track_id=line[0]
	    if line[2]=='sine':
	       entry_var[count]=StringVar()
	       label=Label(frame,text=line[3],font=('Times', 15),anchor=CENTER,bg="Red")
	       label.grid(row=count,column=1,ipadx=5,ipady=5,padx=5,pady=5)
	       count=count+1
	       start=count
 	       entry_var[count]=StringVar()		
	       label=Label(frame,text=line[4])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
               entry_var[count]=StringVar()
	       label=Label(frame,text=line[5])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
               entry_var[count]=StringVar()
	       label=Label(frame,text=line[6])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
	       entry_var[count]=StringVar()
	       label=Label(frame,text=line[7])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
               entry_var[count]=StringVar()
	       label=Label(frame,text=line[8])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       end=count
	       count=count+1
	       sourcelisttrack.append([track_id,'sine',start,end])	
	
	    elif line[2]=='pulse':
	       entry_var[count]=StringVar()
	       label=Label(frame,text=line[3],font=('Times', 15),anchor=CENTER,bg="Red")
	       label.grid(row=count,column=1,ipadx=5,ipady=5,padx=5,pady=5)
	       count=count+1
	       entry_var[count]=StringVar()
	       start=count			
	       label=Label(frame,text=line[4])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
	       entry_var[count]=StringVar()
	       label=Label(frame,text=line[5])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
	       entry_var[count]=StringVar()	
	       label=Label(frame,text=line[6])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
	       entry_var[count]=StringVar() 
	       label=Label(frame,text=line[7])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
	       entry_var[count]=StringVar()
	       label=Label(frame,text=line[8])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
	       entry_var[count]=StringVar() 	
	       label=Label(frame,text=line[9])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
	       entry_var[count]=StringVar()
	       label=Label(frame,text=line[10])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       end=count
	       count=count+1
	       sourcelisttrack.append([track_id,'pulse',start,end])

	    elif line[2]=='pwl':
               entry_var[count]=StringVar()
               label=Label(frame,text=line[3],font=('Times',15),anchor=CENTER,bg="Red")
               label.grid(row=count,column=1,ipadx=5,ipady=5,padx=5,pady=5)
	       count=count+1
	       entry_var[count]=StringVar()
               start=count
	       label=Label(frame,text=line[4])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       end=count
	       count=count+1
	       sourcelisttrack.append([track_id,'pwl',start,end])	
	        				
	       	
	    elif line[2]=='ac':
	       entry_var[count]=StringVar()
	       label=Label(frame,text=line[3],font=('Times', 15),anchor=CENTER,bg="Red")
	       label.grid(row=count,column=1,ipadx=5,ipady=5,padx=5,pady=5)
	       count=count+1
               entry_var[count]=StringVar() 
	       start=count			
	       label=Label(frame,text=line[4])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       end=count
	       count=count+1
	       sourcelisttrack.append([track_id,'ac',start,end])	 
	   
	    elif line[2]=='dc':
	       entry_var[count]=StringVar()
               label=Label(frame,text=line[3],font=('Times', 15),anchor=CENTER,bg="Red")
	       label.grid(row=count,column=1,ipadx=5,ipady=5,padx=5,pady=5)
	       count=count+1
	       entry_var[count]=StringVar()
	       start=count		
	       label=Label(frame,text=line[4])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       end=count
	       count=count+1
               sourcelisttrack.append([track_id,'dc',start,end]) 		
	
	    elif line[2]=='exp':
	       entry_var[count]=StringVar()
               label=Label(frame,text=line[3],font=('Times', 15),anchor=CENTER,bg="Red")
	       label.grid(row=count,column=1,ipadx=5,ipady=5,padx=5,pady=5)
	       count=count+1
	       entry_var[count]=StringVar()
	       start=count 		
	       label=Label(frame,text=line[4])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
	       entry_var[count]=StringVar()
	       label=Label(frame,text=line[5])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
	       entry_var[count]=StringVar()
	       label=Label(frame,text=line[6])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
               entry_var[count]=StringVar()
	       label=Label(frame,text=line[7])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
	       entry_var[count]=StringVar()
	       label=Label(frame,text=line[8])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       count=count+1
	       entry_var[count]=StringVar()
	       label=Label(frame,text=line[9])
	       label.grid(row=count,sticky=W+E+N+S,padx=5,pady=5)	
	       entry=Entry(frame,width=10,textvariable=entry_var[count])
	       entry.grid(row=count,column=1,sticky=W+E+N+S,padx=5,pady=5)  
	       end=count
	       count=count+1
	       sourcelisttrack.append([track_id,'exp',start,end])		
        else:
	    print "No source is present in your circuit"
	    tkMessageBox.showinfo("Source List Info","There is no source in your circuit,Please click next button")
		    

        frame.grid()
        buttonframe.grid()
	#Addbutton.grid(row=count,column=1,padx=5,pady=5)
	Nextbutton.grid(row=count,column=2,padx=5,pady=5)
        Clearbutton.grid(row=count,column=3,padx=5,pady=5)
	canvas.create_window(0, 0, anchor=NW, window=frame)
    	frame.update_idletasks()
    	canvas.config(scrollregion=canvas.bbox("all"))
	#frame.mainloop()
        root_window.title("Add Source and Model Parameter")
	root_window.mainloop()
        return sourcelist,sourcelisttrack

	

def AddSourceValue():
    print "Add Source Value"
    global sourcelistvalue
    sourcelistvalue=[]	
    global start
    global end
    start=0
    end=0
    print "Track Source List :",sourcelisttrack
    print "Initial Source List Value :",sourcelistvalue	
    for compline in sourcelisttrack:
	index=compline[0]
	addline=schematicInfo[index]
	
	if compline[1]=='sine':	
	   try:
	      start=compline[2]
	      end=compline[3]
	      vo_val=entry_var[start].get()
	      va_val=entry_var[start+1].get()
	      freq_val=entry_var[start+2].get()
	      td_val=entry_var[start+3].get()
	      theta_val=entry_var[end].get()
	      addline=addline.partition('(')[0] + "("+vo_val+" "+va_val+" "+freq_val+" "+td_val+" "+theta_val+")"
	      print "Line Added ",addline
	      sourcelistvalue.append([index,addline])
           except:
              print "Caught an exception in sine voltage source ",addline  
	     
	elif compline[1]=='pulse':
	   try:
	      start=compline[2]
	      end=compline[3]
	      v1_val=entry_var[start].get()
	      v2_val=entry_var[start+1].get()
	      td_val=entry_var[start+2].get()
	      tr_val=entry_var[start+3].get()
	      tf_val=entry_var[start+4].get()
	      pw_val=entry_var[start+5].get()
	      tp_val=entry_var[end].get() 	
	      addline=addline.partition('(')[0] + "("+v1_val+" "+v2_val+" "+td_val+" "+tr_val+" "+tf_val+" "+pw_val+" "+tp_val+")"
	      print "Line Added ",addline
	      sourcelistvalue.append([index,addline])
           except:
	      print "Caught an exception in pulse voltage source ",addline

        elif compline[1]=='pwl':
	   try:
	     start=compline[2]
	     t_v_val=entry_var[start].get()
	     addline=addline.partition('(')[0] + "("+t_v_val+")"
	     print "Line Added ",addline
	     sourcelistvalue.append([index,addline])
	   except:
	     print "Caught an exception in pwl voltage source ",addline 
               
	elif compline[1]=='ac':
           try:
	      start=compline[2]
              va_val=entry_var[start].get()
              addline=' '.join(addline.split())
              addline=addline.partition('ac')[0] +" "+'ac'+" "+ va_val
	      print "Line Added ",addline
	      sourcelistvalue.append([index,addline]) 
           except:
	      print "Caught an exception in ac voltage source ",addline
              
	elif compline[1]=='dc':
	   try:
	      start=compline[2]
	      v1_val=entry_var[start].get()
	      addline=' '.join(addline.split())	
	      addline=addline.partition('dc')[0] + " " +'dc'+ " "+v1_val
	      print "Line Added ",addline
	      sourcelistvalue.append([index,addline]) 
           except:
	      print "Caught an exception in dc voltage source",addline 
            
        elif compline[1]=='exp':
	   try:
	      start=compline[2]
	      end=compline[3]
	      v1_val=entry_var[start].get()
	      v2_val=entry_var[start+1].get()
	      td1_val=entry_var[start+2].get()
	      tau1_val=entry_var[start+3].get()
	      td2_val=entry_var[start+4].get()
	      tau2_val=entry_var[end].get()		
	      addline=addline.partition('(')[0] + "("+v1_val+" "+v2_val+" "+td1_val+" "+tau1_val+" "+td2_val+" "+tau2_val+")"
	      print "Line Added ",addline
	      sourcelistvalue.append([index,addline])
           except:
              print "Caught an exception in exp voltage source ",addline
    print "Final Source List Value :",sourcelistvalue
    ##Adding into schematicInfo
    for item in sourcelistvalue:
	del schematicInfo[item[0]]
	schematicInfo.insert(item[0],item[1])


   
def NextPage():
    print "Next Page"
    AddSourceValue()
    ##Destroying Frame
    frame.destroy()
    #frame.grid_forget()
    global schematicInfo
    global outputOption
    global guimodelvalue
    global guimodellisttrack
    global guimodellist
    guimodelvalue=[]	
    guimodellisttrack=[]
    guimodellist=['adc8','dac8','gain','summer','multiplier','divider','limit','integrator','differentiator','limit8','controlledlimiter',
'analogswitch','zener','d_buffer','d_inverter','d_and','d_nand','d_or','d_nor','d_xor','d_xnor','d_tristate','d_pullup',
'd_pulldown','d_srlatch','d_jklatch','d_dlatch','d_tlatch','d_srff','d_jkff','d_dff','ic']	
    
    ##Calling function which take information for entry and label		
    schematicInfo,outputOption,guimodelvalue=convertICintoBasicBlocks(schematicInfo,outputOption,guimodelvalue)		
	
    #Creating Frame and buttons for next page
    nextframe=Frame(canvas,height=window_height,width=window_width)
    nextbuttonframe=Frame(nextframe)
    #Addbutton=Button(nextbuttonframe,text='Add',command=AddModelParametr)
    Submitbutton=Button(nextbuttonframe,text='Submit & Exit',command=Submit)
    Clearbutton=Button(nextbuttonframe,text='Clear',command=ClearModelParamValue)
    global nextcount
    nextcount=0
    global nextentry_var
    nextentry_var={}
    	

    ##Checking if any model is present
    if guimodelvalue:			
    ## Calling Next frame generation function
       for line in guimodelvalue:
	   if line[2] in guimodellist:
	      print "ConvertICBlock index :",line[0]
	      nextcount=nextframegeneration(nextframe,line,nextentry_var,nextcount)	
	   else:
	      print "Please look whether model is added in guimodellist inside code" 
    else:
	print "There is no model in your circuit" 
	AddModelParametr()
	tkMessageBox.showinfo("Model List Info","There is no model in your circuit, please click on Submit & Exit Button" )
	
    
    """	
    for line in guimodelvalue:	
	print "ConvertICBlock index :",line[0]
	nextcount=nextframegeneration(nextframe,line,nextentry_var,nextcount)
	if line[2]=='adc8':
	   nextcount=nextframegeneration(nextframe,line,nextentry_var,nextcount)
	   
	   nextentry_var[nextcount]=StringVar()
	   label=Label(nextframe,text=line[5],font=('Times', 15),anchor=CENTER,bg="Red")
	   label.grid(row=nextcount,column=1,ipadx=5,ipady=5,padx=5,pady=5)
	   nextcount=nextcount+1
	   start=nextcount
	   for item in range(len(line)-6):
	       nextentry_var[nextcount]=StringVar()
	       label=Label(nextframe,text=line[6+item])
	       label.grid(row=nextcount,column=0,sticky=W+E+N+S,padx=5,pady=5)
	       entry=Entry(nextframe,width=10,textvariable=nextentry_var[nextcount])
	       entry.grid(row=nextcount,column=1,sticky=W+E+N+S,padx=5,pady=5)
	       nextcount=nextcount+1
	   end=nextcount-1
	   guimodellisttrack.append([line[0],line[1],line[2],line[3],line[4],start,end])
	
	else:
	   print "Please check whether model is available or not"
    """	  
    nextframe.grid()
    nextbuttonframe.grid()
    #Addbutton.grid(row=nextcount,column=1,padx=5,pady=5)
    Submitbutton.grid(row=nextcount,column=2,padx=5,pady=5)
    Clearbutton.grid(row=nextcount,column=3,padx=5,pady=5)
    canvas.create_window(0, 0, anchor=NW, window=nextframe)
    nextframe.update_idletasks()	
    canvas.config(scrollregion=canvas.bbox("all"))
    		

     	

def nextframegeneration(nextframe,line,nextentry_var,nextcount):
    print "Model Line in netlist is : ",line[1]
    nextentry_var[nextcount]=StringVar()
    label=Label(nextframe,text=line[5],font=('Times', 14),anchor=CENTER,bg="Red")
    label.grid(row=nextcount,column=1,ipadx=5,ipady=5,padx=5,pady=5)
    nextcount=nextcount+1
    start=nextcount
    if line[2]=='ic':
       for item in range(len(line)-7):
           nextentry_var[nextcount]=StringVar()
           label=Label(nextframe,text=line[7+item])
           label.grid(row=nextcount,column=0,sticky=W+E+N+S,padx=5,pady=5)
           entry=Entry(nextframe,width=10,textvariable=nextentry_var[nextcount])
           entry.grid(row=nextcount,column=1,sticky=W+E+N+S,padx=5,pady=5)
           nextcount=nextcount+1
       end=nextcount-1
       guimodellisttrack.append([line[0],line[1],line[2],line[3],line[4],start,end,line[6]])		
    else:
       for item in range(len(line)-6):
           nextentry_var[nextcount]=StringVar()
           label=Label(nextframe,text=line[6+item])
           label.grid(row=nextcount,column=0,sticky=W+E+N+S,padx=5,pady=5)
           entry=Entry(nextframe,width=10,textvariable=nextentry_var[nextcount])
           entry.grid(row=nextcount,column=1,sticky=W+E+N+S,padx=5,pady=5)
           nextcount=nextcount+1
       end=nextcount-1
       guimodellisttrack.append([line[0],line[1],line[2],line[3],line[4],start,end])	
    return nextcount

def AddModelParametr():
    print "Adding Model Parameter"
    print "GuiModelValue",guimodelvalue
    global guimodellisttrack	
    global modelparamvalue
    global addmodelline
    modelparamvalue=[]
    addmodelline=[]			
    
    for line in guimodellisttrack:
	print "GUI MODEL LIST TRACK",line
        if line[2]=='adc8':
	   try:
		start=line[5]
		end=line[6]
		in_low=nextentry_var[start].get()
		in_high=nextentry_var[end].get()
		if in_low=="": in_low="0.8"
		if in_high=="": in_high="2.0"
	        addmodelline=".model "+ line[3]+" adc_bridge(in_low="+in_low+" in_high="+in_high+" )"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	   except:
		print "Caught an exception in adc8 model ",line[1]

	elif line[2]=='dac8':
	     try:
		start=line[5]
		end=line[6]
		out_low=nextentry_var[start].get()
		out_high=nextentry_var[start+1].get()
		out_undef=nextentry_var[end].get()
		if out_low=="": out_low="0.2"
        	if out_high=="": out_high="5.0"
        	if out_undef=="": out_undef="5.0"
		addmodelline=".model "+ line[3]+" dac_bridge(out_low="+out_low+" out_high="+out_high+" out_undef="+out_undef+" )"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in dac8 model ",line[1]

	elif line[2]=='gain':
	     try:
		start=line[5]
		end=line[6]
		in_offset=nextentry_var[start].get()
		gain=nextentry_var[start+1].get()
		out_offset=nextentry_var[end].get()
	        if in_offset=="": in_offset="0.0"
	        if gain=="": gain="1.0"
	        if out_offset=="": out_offset="0.0"
	        addmodelline=".model "+ line[3]+" gain(in_offset="+in_offset+" out_offset="+out_offset+" gain="+gain+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in gain model ",line[1]

	elif line[2]=='summer':
	     try:
		start=line[5]
		end=line[6]
		in1_offset=nextentry_var[start].get()
		in2_offset=nextentry_var[start+1].get()
		in1_gain=nextentry_var[start+2].get()
		in2_gain=nextentry_var[start+3].get()
		out_gain=nextentry_var[start+4].get()
		out_offset=nextentry_var[end].get()
	        if in1_offset=="": in1_offset="0.0"
	        if in2_offset=="": in2_offset="0.0"
	        if in1_gain=="": in1_gain="1.0"
	        if in2_gain=="": in2_gain="1.0"
	        if out_gain=="": out_gain="1.0"
	        if out_offset=="": out_offset="0.0"
	        addmodelline=".model "+ line[3]+" summer(in_offset=["+in1_offset+" "+in2_offset+"] in_gain=["+in1_gain+" "+in2_gain+"] out_offset="+out_offset+" out_gain="+out_gain+")" 
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in summer model ",line[1] 

	elif line[2]=='multiplier':
	     try:
		start=line[5]
		end=line[6]
		in1_offset=nextentry_var[start].get()
		in2_offset=nextentry_var[start+1].get()
		in1_gain=nextentry_var[start+2].get()
		in2_gain=nextentry_var[start+3].get()
		out_gain=nextentry_var[start+4].get()
		out_offset=nextentry_var[end].get()
	        if in1_offset=="": in1_offset="0.0"
	        if in2_offset=="": in2_offset="0.0"
	        if in1_gain=="": in1_gain="1.0"
	        if in2_gain=="": in2_gain="1.0"
	        if out_gain=="": out_gain="1.0"
	        if out_offset=="": out_offset="0.0"
	        addmodelline=".model "+ line[3]+" mult(in_offset=["+in1_offset+" "+in2_offset+"] in_gain=["+in1_gain+" "+in2_gain+"] out_offset="+out_offset+" out_gain="+out_gain+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in multiplier model ",line[1]

	elif line[2]=='divider':
	     try:
		start=line[5]
		end=line[6]
		num_offset=nextentry_var[start].get()
		den_offset=nextentry_var[start+1].get()
		num_gain=nextentry_var[start+2].get()
		den_gain=nextentry_var[start+3].get()
		out_gain=nextentry_var[start+4].get()
		out_offset=nextentry_var[start+5].get()
		den_lower_limit=nextentry_var[end].get()
	        if num_offset=="": num_offset="0.0"
	        if den_offset=="": den_offset="0.0"
	        if num_gain=="": num_gain="1.0"
	        if den_gain=="": den_gain="1.0"
	        if out_gain=="": out_gain="1.0"
	        if out_offset=="": out_offset="0.0"
	        if den_lower_limit=="": den_lower_limit="1.0e-10"
	        addmodelline=".model "+ line[3]+" divide(num_offset="+num_offset+" den_offset="+den_offset+" num_gain="+num_gain+" den_gain="+den_gain+" out_offset="+out_offset+" out_gain="+out_gain+" den_lower_limit="+den_lower_limit+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in divider model ",line[1]

	elif line[2]=='limit':
	     try:
		start=line[5]
		end=line[6]
		lowerLimit=nextentry_var[start].get()
		upperLimit=nextentry_var[start+1].get()
		in_offset=nextentry_var[start+2].get()
		gain=nextentry_var[end].get()
        	if lowerLimit=="": lowerLimit="0.0"
	        if upperLimit=="": upperLimit="5.0"
	        if in_offset=="": in_offset="0.0"
	        if gain=="": gain="1.0"
	        addmodelline=".model "+ line[3]+" limit(out_lower_limit="+lowerLimit+" out_upper_limit="+upperLimit+" in_offset="+in_offset+" gain="+gain+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in limit model ",line[1]

	elif line[2]=='integrator':
	     try:
		start=line[5]
		end=line[6]
		out_lower_limit=nextentry_var[start].get()
		out_upper_limit=nextentry_var[start+1].get()
		in_offset=nextentry_var[start+2].get()
		gain=nextentry_var[start+3].get()
		out_ic=nextentry_var[end].get()
	        if out_lower_limit=="": out_lower_limit="0.0"
	        if out_upper_limit=="": out_upper_limit="5.0"
	        if in_offset=="": in_offset="0.0"
	        if gain=="": gain="1.0"
	        if out_ic=="": out_ic="0.0"
	        addmodelline=".model "+ line[3]+" int(out_lower_limit="+out_lower_limit+" out_upper_limit="+out_upper_limit+" in_offset="+in_offset+" gain="+gain+" out_ic="+out_ic+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in integrator model ",line[1]

	elif line[2]=='differentiator':
	     try:
		start=line[5]
		end=line[6]
		out_lower_limit=nextentry_var[start].get()
		out_upper_limit=nextentry_var[start+1].get()
		out_offset=nextentry_var[start+2].get()
		gain=nextentry_var[end].get()
	        if out_lower_limit=="": out_lower_limit="0.0"
	        if out_upper_limit=="": out_upper_limit="5.0"
	        if out_offset=="": out_offset="0.0"
	        if gain=="": gain="1.0"
	        addmodelline=".model "+ line[3]+" d_dt(out_lower_limit="+out_lower_limit+" out_upper_limit="+out_upper_limit+" out_offset="+out_offset+" gain="+gain+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in differentiator model ",line[1]

	elif line[2]=='limit8':
	     try:
		start=line[5]
		end=line[6]
		lowerLimit=nextentry_var[start].get()
		upperLimit=nextentry_var[start+1].get()
		in_offset=nextentry_var[start+2].get()
		gain=nextentry_var[end].get()
	        if lowerLimit=="": lowerLimit="0.0"
	        if upperLimit=="": upperLimit="5.0"
	        if in_offset=="": in_offset="0.0"
	        if gain=="": gain="1.0"
	        addmodelline=".model "+ line[3]+" limit(out_lower_limit="+lowerLimit+" out_upper_limit="+upperLimit+" in_offset="+in_offset+" gain="+gain+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in limit8 model ",line[1]

	elif line[2]=='controlledlimiter':
	     try:
		start=line[5]
		end=line[6]
		in_offset=nextentry_var[start].get()
		gain=nextentry_var[end].get()
                if in_offset=="": in_offset="0.0"
        	if gain=="": gain="1.0"
        	addmodelline=".model "+ line[3]+" climit(in_offset="+in_offset+" gain="+gain+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in controlledlimiter model ",line[1]	

	elif line[2]=='analogswitch':
	     try:
		start=line[5]
		end=line[6]
		cntl_on=nextentry_var[start].get()
		cntl_off=nextentry_var[start+1].get()
		r_on=nextentry_var[start+2].get()
		r_off=nextentry_var[end].get()
        	if cntl_on=="": cntl_on="5.0"
	        if cntl_off=="": cntl_off="0.0"
	        if r_on=="": r_on="10.0"
	        if r_off=="": r_off="1e6"
	        addmodelline=".model "+ line[3]+" aswitch(cntl_on="+cntl_on+" cntl_off="+cntl_off+" r_on="+r_on+" r_off="+r_off+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in analogswitch model ",line[1]  

	elif line[2]=='zener':
	     try:
		start=line[5]
		end=line[6]
		v_breakdown=nextentry_var[start].get()
		i_breakdown=nextentry_var[start+1].get()
		i_sat=nextentry_var[start+2].get()
		n_forward=nextentry_var[end].get()
	        if v_breakdown=="": v_breakdown="5.6"
	        if i_breakdown=="": i_breakdown="1.0e-2"
	        if i_sat=="": i_sat="1.0e-12"
	        if n_forward=="": n_forward="1.0"
	        addmodelline=".model "+ line[3]+" zener(v_breakdown="+v_breakdown+" i_breakdown="+i_breakdown+" i_sat="+i_sat+" n_forward="+n_forward+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in zener model ",line[1]   	

	elif line[2]=='d_buffer':
	     try:
		start=line[5]
		end=line[6]
		rise_delay=nextentry_var[start].get()
		fall_delay=nextentry_var[start+1].get()
		input_load=nextentry_var[end].get()
                if rise_delay=="": rise_delay="1e-12"
        	if fall_delay=="": fall_delay="1e-12"
        	if input_load=="": input_load="1e-12"
        	addmodelline=".model "+ line[3]+" d_buffer(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_buffer model ",line[1]

	elif line[2]=='d_inverter':
	     try:
		start=line[5]
		end=line[6]
		rise_delay=nextentry_var[start].get()
		fall_delay=nextentry_var[start+1].get()
		input_load=nextentry_var[end].get()
        	if rise_delay=="": rise_delay="1e-12"
	        if fall_delay=="": fall_delay="1e-12"
        	if input_load=="": input_load="1e-12"
        	addmodelline=".model "+ line[3]+" d_inverter(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_inverter model ",line[1]

	elif line[2]=='d_and':
	     try:
		start=line[5]
		end=line[6]
		rise_delay=nextentry_var[start].get()
		fall_delay=nextentry_var[start+1].get()
		input_load=nextentry_var[end].get()
        	if rise_delay=="": rise_delay="1e-12"
	        if fall_delay=="": fall_delay="1e-12"
        	if input_load=="": input_load="1e-12"
        	addmodelline=".model "+ line[3]+" d_and(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_and model ",line[1] 

	elif line[2]=='d_nand':
	     try:
		start=line[5]
		end=line[6]
		rise_delay=nextentry_var[start].get()
		fall_delay=nextentry_var[start+1].get()
		input_load=nextentry_var[end].get()
        	if rise_delay=="": rise_delay="1e-12"
	        if fall_delay=="": fall_delay="1e-12"
        	if input_load=="": input_load="1e-12"
        	addmodelline=".model "+ line[3]+" d_nand(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_nand model ",line[1] 

	elif line[2]=='d_or':
	     try:
		start=line[5]
		end=line[6]
		rise_delay=nextentry_var[start].get()
		fall_delay=nextentry_var[start+1].get()
		input_load=nextentry_var[end].get()
        	if rise_delay=="": rise_delay="1e-12"
	        if fall_delay=="": fall_delay="1e-12"
        	if input_load=="": input_load="1e-12"
        	addmodelline=".model "+ line[3]+" d_or(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_or model ",line[1] 

	elif line[2]=='d_nor':
	     try:
		start=line[5]
		end=line[6]
		rise_delay=nextentry_var[start].get()
		fall_delay=nextentry_var[start+1].get()
		input_load=nextentry_var[end].get()
        	if rise_delay=="": rise_delay="1e-12"
	        if fall_delay=="": fall_delay="1e-12"
        	if input_load=="": input_load="1e-12"
        	addmodelline=".model "+ line[3]+" d_nor(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_nor model ",line[1]   	

	elif line[2]=='d_xor':
	     try:
		start=line[5]
		end=line[6]
		rise_delay=nextentry_var[start].get()
		fall_delay=nextentry_var[start+1].get()
		input_load=nextentry_var[end].get()
        	if rise_delay=="": rise_delay="1e-12"
	        if fall_delay=="": fall_delay="1e-12"
        	if input_load=="": input_load="1e-12"
        	addmodelline=".model "+ line[3]+" d_xor(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_xor model ",line[1]   

	elif line[2]=='d_xnor':
	     try:
		start=line[5]
		end=line[6]
		rise_delay=nextentry_var[start].get()
		fall_delay=nextentry_var[start+1].get()
		input_load=nextentry_var[end].get()
        	if rise_delay=="": rise_delay="1e-12"
	        if fall_delay=="": fall_delay="1e-12"
        	if input_load=="": input_load="1e-12"
        	addmodelline=".model "+ line[3]+" d_xnor(rise_delay="+rise_delay+" fall_delay="+fall_delay+" input_load="+input_load+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_xnor model ",line[1]

	elif line[2]=='d_tristate':
	     try:
		start=line[5]
		end=line[6]
		delay=nextentry_var[start].get()
		input_load=nextentry_var[start+1].get()
		enable_load=nextentry_var[end].get()
        	if delay=="": delay="1e-12"
	        if input_load=="": input_load="1e-12"
        	if enable_load=="": enable_load="1e-12"
        	addmodelline=".model "+ line[3]+" d_tristate(delay="+delay+" enable_load="+enable_load+" input_load="+input_load+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_tristate model ",line[1] 

	elif line[2]=='d_pullup':
	     try:
		start=line[5]
		end=line[6]
		load=nextentry_var[start].get()
 		if load=="": load="1e-12"
        	addmodelline=".model "+ line[3]+" d_pullup(load="+load+")"
        	modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_pullup model ",line[1]

	elif line[2]=='d_pulldown':
	     try:
		start=line[5]
		end=line[6]
		load=nextentry_var[start].get()
 		if load=="": load="1e-12"
        	addmodelline=".model "+ line[3]+" d_pulldown(load="+load+")"
        	modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_pulldown model ",line[1]

	elif line[2]=='d_srlatch':
	     try:
		start=line[5]
		end=line[6]
		sr_delay=nextentry_var[start].get()
		enable_delay=nextentry_var[start+1].get()
		set_delay=nextentry_var[start+2].get()
		reset_delay=nextentry_var[start+3].get()
		ic=nextentry_var[start+4].get()
		sr_load=nextentry_var[start+5].get()
		enable_load=nextentry_var[start+6].get()
		set_load=nextentry_var[start+7].get()
		reset_load=nextentry_var[start+8].get()
		rise_delay=nextentry_var[start+9].get()
		fall_delay=nextentry_var[end].get()
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
        	addmodelline=".model "+ line[3]+" d_srlatch(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+sr_load="+sr_load+" enable_load="+enable_load+" set_load="+set_load+" reset_load="+reset_load+"\n+sr_delay="+sr_delay+" enable_delay="+enable_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_srlatch model ",line[1]  

	elif line[2]=='d_jklatch':
	     try:
		start=line[5]
		end=line[6]
		jk_delay=nextentry_var[start].get()
		enable_delay=nextentry_var[start+1].get()
		set_delay=nextentry_var[start+2].get()
		reset_delay=nextentry_var[start+3].get()
		ic=nextentry_var[start+4].get()
		jk_load=nextentry_var[start+5].get()
		enable_load=nextentry_var[start+6].get()
		set_load=nextentry_var[start+7].get()
		reset_load=nextentry_var[start+8].get()
		rise_delay=nextentry_var[start+9].get()
		fall_delay=nextentry_var[end].get()
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
        	addmodelline=".model "+ line[3]+" d_jklatch(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+jk_load="+jk_load+" enable_load="+enable_load+" set_load="+set_load+" reset_load="+reset_load+"\n+jk_delay="+jk_delay+" enable_delay="+enable_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_jklatch model ",line[1] 

	elif line[2]=='d_dlatch':
	     try:
		start=line[5]
		end=line[6]
		data_delay=nextentry_var[start].get()
		enable_delay=nextentry_var[start+1].get()
		set_delay=nextentry_var[start+2].get()
		reset_delay=nextentry_var[start+3].get()
		ic=nextentry_var[start+4].get()
		data_load=nextentry_var[start+5].get()
		enable_load=nextentry_var[start+6].get()
		set_load=nextentry_var[start+7].get()
		reset_load=nextentry_var[start+8].get()
		rise_delay=nextentry_var[start+9].get()
		fall_delay=nextentry_var[end].get()
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
        	addmodelline=".model "+ line[3]+" d_dlatch(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+data_load="+data_load+" enable_load="+enable_load+" set_load="+set_load+" reset_load="+reset_load+"\n+data_delay="+data_delay+" enable_delay="+enable_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_dlatch model ",line[1]  

	elif line[2]=='d_tlatch':
	     try:
		start=line[5]
		end=line[6]
		t_delay=nextentry_var[start].get()
		enable_delay=nextentry_var[start+1].get()
		set_delay=nextentry_var[start+2].get()
		reset_delay=nextentry_var[start+3].get()
		ic=nextentry_var[start+4].get()
		t_load=nextentry_var[start+5].get()
		enable_load=nextentry_var[start+6].get()
		set_load=nextentry_var[start+7].get()
		reset_load=nextentry_var[start+8].get()
		rise_delay=nextentry_var[start+9].get()
		fall_delay=nextentry_var[end].get()
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
        	addmodelline=".model "+ line[3]+" d_tlatch(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+t_load="+t_load+" enable_load="+enable_load+" set_load="+set_load+" reset_load="+reset_load+"\n+t_delay="+t_delay+" enable_delay="+enable_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_tlatch model ",line[1]  

	elif line[2]=='d_srff':
	     try:
		start=line[5]
		end=line[6]
		clk_delay=nextentry_var[start].get()
		set_delay=nextentry_var[start].get()
		reset_delay=nextentry_var[start].get()
		ic=nextentry_var[start].get()
		sr_load=nextentry_var[start].get()
		clk_load=nextentry_var[start].get()
		set_load=nextentry_var[start].get()
		reset_load=nextentry_var[start].get()
		rise_delay=nextentry_var[start].get()
		fall_delay=nextentry_var[start].get()
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
	        addmodelline=".model "+ line[3]+" d_srff(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+sr_load="+sr_load+" clk_load="+clk_load+" set_load="+set_load+" reset_load="+reset_load+"\n+clk_delay="+clk_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_srff model ",line[1] 

	elif line[2]=='d_jkff':
	     try:
		start=line[5]
		end=line[6]
		clk_delay=nextentry_var[start].get()
		set_delay=nextentry_var[start].get()
		reset_delay=nextentry_var[start].get()
		ic=nextentry_var[start].get()
		jk_load=nextentry_var[start].get()
		clk_load=nextentry_var[start].get()
		set_load=nextentry_var[start].get()
		reset_load=nextentry_var[start].get()
		rise_delay=nextentry_var[start].get()
		fall_delay=nextentry_var[start].get()
	        if clk_delay=="": clk_delay="1e-12"
	        if set_delay=="": set_delay="1e-12"
	        if reset_delay=="": reset_delay="1e-12"
	        if ic=="": ic="0"
	        if jk_load=="": sr_load="1e-12"
	        if clk_load=="": clk_load="1e-12"
	        if set_load=="": set_load="1e-12"
	        if reset_load=="": reset_load="1e-12"
	        if rise_delay=="": rise_delay="1e-12"
	        if fall_delay=="": fall_delay="1e-12"
	        addmodelline=".model "+ line[3]+" d_jkff(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+jk_load="+jk_load+" clk_load="+clk_load+" set_load="+set_load+" reset_load="+reset_load+"\n+clk_delay="+enable_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_jkff model ",line[1] 

	elif line[2]=='d_dff':
	     try:
		start=line[5]
		end=line[6]
		clk_delay=nextentry_var[start].get()
		set_delay=nextentry_var[start+1].get()
		reset_delay=nextentry_var[start+2].get()
		ic=nextentry_var[start+3].get()
		data_load=nextentry_var[start+4].get()
		clk_load=nextentry_var[start+5].get()
		set_load=nextentry_var[start+6].get()
		reset_load=nextentry_var[start+7].get()
		rise_delay=nextentry_var[start+8].get()
		fall_delay=nextentry_var[end].get()
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
        	addmodelline=".model "+ line[3]+" d_dff(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+data_load="+data_load+" clk_load="+clk_load+" set_load="+set_load+" reset_load="+reset_load+"\n+clk_delay="+clk_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_dff model ",line[1] 

	elif line[2]=='d_tff':
	     try:
		start=line[5]
		end=line[6]
		clk_delay=nextentry_var[start].get()
		set_delay=nextentry_var[start+1].get()
		reset_delay=nextentry_var[start+2].get()
		ic=nextentry_var[start+3].get()
		t_load=nextentry_var[start+4].get()
		clk_load=nextentry_var[start+5].get()
		set_load=nextentry_var[start+6].get()
		reset_load=nextentry_var[start+7].get()
		rise_delay=nextentry_var[start+8].get()
		fall_delay=nextentry_var[end].get()
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
        	addmodelline=".model "+ line[3]+" d_tff(rise_delay="+rise_delay+" fall_delay="+fall_delay+" ic="+ic+"\n+t_load="+t_load+" clk_load="+clk_load+" set_load="+set_load+" reset_load="+reset_load+"\n+clk_delay="+clk_delay+" set_delay="+set_delay+" reset_delay="+reset_delay+")"
		modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in d_tff model ",line[1]  

	elif line[2]=='ic':
	     try:
		start=line[5]
		end=line[6]
		ic=nextentry_var[start].get()
                if ic=="": ic="0"
		addmodelline=".ic v("+line[7]+")="+ic
        	modelparamvalue.append([line[0],addmodelline,line[4]])
	     except:
		print "Caught an exception in ic initial condition ",line[1] 				
		
        else:
	   print "No model found"
	   #tkMessageBox.showinfo("Model Info","Please check whether used model is available inside code")   	
    
    print "Model List has been added",modelparamvalue  	  


def ClearSourceValue():
    print "Clear Source Value"
    for line in sourcelisttrack:
	start=line[2]
	end=line[3]
	count=start
	for item in range(int(end-start+1)):
	    entry_var[count].set("")
	    count=count+1

def ClearModelParamValue():
    print "Clear Model Parameter value"
    for line in  guimodellisttrack:
	print "line",line
	start=line[5]
	end=line[6]
	count=start
	for item in range(end-start+1):
	    nextentry_var[count].set("")
	    count=count+1
	

def Submit():
    print "Submit button"
    try:
	AddModelParametr()	#Adding Model Parameter
    	for item in modelparamvalue:
	    schematicInfo.append(item[2])  #Adding Comment line
	    schematicInfo.append(item[1])  #Adding Model line
    	print "Successfully Closed"
    	root_window.quit()
    except:
	tkMessageBox.showinfo("Exception","Please Add before Submit") 	
    	


def convertICintoBasicBlocks(schematicInfo,outputOption,guimodelvalue):
  #Insert Special source parameters
  k=1
  for compline in schematicInfo:
    words=compline.split()
    compName=words[0]
  # Find the IC from schematic 
    if compName[0]=='u':
    # Find the component from the circuit
      index=schematicInfo.index(compline)
      compType=words[len(words)-1];
      schematicInfo.remove(compline) 
      	
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
      elif (compType=="7475" or compType=="74hc75" or compType=="74ls75"):
       # Add analog to digital converter for inputs
        schematicInfo.append("a"+str(k)+" ["+words[2]+" "+words[3]+" "+words[4]+" "+words[1]+"] ["+words[2]+"_in "+words[3]+"_in "+words[4]+"_in "+words[1]+"_in] "+compName+"adc")
        k=k+1
       # Add T Flip-flop
        schematicInfo.append("a"+str(k)+" "+words[2]+"_in "+words[3]+"_in ~"+words[4]+"_in ~"+words[1]+"_in "+words[5]+"_out "+words[6]+"_out "+compName)
        k=k+1
       # Add digital to analog converter for outputs
        schematicInfo.append("a"+str(k)+" ["+words[5]+"_out "+words[6]+"_out] ["+words[5]+" "+words[6]+"] "+" "+compName+"dac")
        k=k+1
       # Insert comment in-place of components
        schematicInfo.insert(index,"* "+compType)
       # Add model for T Flip-Flop
        schematicInfo.append(".model "+ compName+" d_tff")
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
      elif (compType=="7471" or compType=="74hc71" or compType=="74ls71"):
       # Add analog to digital converter for inputs
        schematicInfo.append("a"+str(k)+" ["+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[1]+"] ["+words[2]+"_in "+words[3]+"_in "+words[4]+"_in "+words[5]+"_in "+words[1]+"_in] "+compName+"adc")
        k=k+1
       # Add S-R Flip-flop
        schematicInfo.append("a"+str(k)+" "+words[2]+"_in ~"+words[3]+"_in "+words[4]+"_in ~"+words[5]+"_in ~"+words[1]+"_in "+words[6]+"_out "+words[7]+"_out "+compName)
        k=k+1
       # Add digital to analog converter for outputs
        schematicInfo.append("a"+str(k)+" ["+words[6]+"_out "+words[7]+"_out] ["+words[6]+" "+words[7]+"] "+" "+compName+"dac")
        k=k+1
       # Insert comment in-place of components
        schematicInfo.insert(index,"* "+compType)
       # Add model for SR Flip-Flop
        schematicInfo.append(".model "+ compName+" d_srff")
       # Add model for analog-to-digital bridge741
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
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)	        
	print "-----------------------------------------------------------\n"
	print "Adding Analog to Digital Converter"
	Comment='* Analog to Digital converter '+compType
        Title='Add parameters for analog to digital converter '+compName
	in_low='  Enter input low level voltage (default=0.8): '
	in_high='  Enter input high level voltage (default=2.0): '
        print "-----------------------------------------------------------"
	guimodelvalue.append([index,compline,compType,compName,Comment,Title,in_low,in_high])
      elif compType=="dac8":
        for i in range(0,len(words)/2-1):
          schematicInfo.append("a"+str(k)+" ["+words[i+1]+"] ["+words[i+len(words)/2]+"] "+compName)
          k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding Digital to Analog converter"
	Comment='* Digital to Analog converter '+compType
        Title='Add parameters for digital to analog converter '+compName
	out_low='  Enter output low level voltage (default=0.2): '
	out_high='  Enter output high level voltage (default=5.0): '
	out_undef='  Enter output for undefined voltage level (default=2.2): '
        print "-----------------------------------------------------------"
	guimodelvalue.append([index,compline,compType,compName,Comment,Title,out_low,out_high,out_undef])
      elif compType=="gain":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding Gain"
	Comment='* Gain '+compType
        Title='Add parameters for Gain '+compName
	in_offset='  Enter offset for input (default=0.0): '
	gain='  Enter gain (default=1.0): '
	out_offset='  Enter offset for output (default=0.0): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,in_offset,gain,out_offset])
      elif compType=="summer":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding summer"
	Comment='* Summer '+compType
        Title='Add parameters for Summer '+compName
	in1_offset='  Enter offset for input 1 (default=0.0): '
	in2_offset='  Enter offset for input 2 (default=0.0): '
	in1_gain='  Enter gain for input 1 (default=1.0): '
	in2_gain='  Enter gain for input 2 (default=1.0): '
	out_gain='  Enter gain for output (default=1.0): '
	out_offset='  Enter offset for output (default=0.0): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,in1_offset,in2_offset,in1_gain,in2_gain,out_gain,out_offset])
      elif compType=="multiplier":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding Multiplier"
	Comment='* Multiplier '+compType
        Title='Add parameters for Multiplier '+compName
	in1_offset='  Enter offset for input 1 (default=0.0): '
	in2_offset='  Enter offset for input 2 (default=0.0): '
	in1_gain='  Enter gain for input 1 (default=1.0): '
	in2_gain='  Enter gain for input 2 (default=1.0): '
	out_gain='  Enter gain for output (default=1.0): '
	out_offset='  Enter offset for output (default=0.0): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,in1_offset,in2_offset,in1_gain,in2_gain,out_gain,out_offset])
      elif compType=="divider":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding Divider"
	Comment='Divider '+compType
        Title='Add parameters for Divider '+compName
	num_offset='  Enter offset for numerator (default=0.0): '
	den_offset='  Enter offset for denominator (default=0.0): '
	num_gain='  Enter gain for numerator (default=1.0): '
	den_gain='  Enter gain for denominator (default=1.0): '
	out_gain='  Enter gain for output (default=1.0): '
	out_offset='  Enter offset for output (default=0.0): '
	den_lower_limit='  Enter lower limit for denominator value (default=1.0e-10): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,num_offset,den_offset,num_gain,den_gain,out_gain,out_offset,den_lower_limit])
      elif compType=="limit":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding limiter"
	Comment='* Limiter '+compType
        Title='Add parameters for Limiter '+compName
	lowerLimit='  Enter out lower limit (default=0.0): '
	upperLimit='  Enter out upper limit (default=5.0): '
	in_offset='  Enter offset for input (default=0.0): '
	gain='  Enter gain (default=1.0): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,lowerLimit,upperLimit,in_offset,gain])
      elif compType=="integrator":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding integrator"
	Comment='* Integrator '+compType
        Title='Add parameters for Integrator '+compName
	out_lower_limit='  Enter out lower limit (default=0.0): '
	out_upper_limit='  Enter out upper limit (default=5.0): '
	in_offset='  Enter offset for input (default=0.0): '
	gain='  Enter gain (default=1.0): '
	out_ic='  Enter initial condition on output (default=0.0): '
        print "-----------------------------------------------------------"
 	guimodelvalue.append([index,compline,compType,compName,Comment,Title,out_lower_limit,out_upper_limit,in_offset,gain,out_ic])
      elif compType=="differentiator":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding Differentiator"
	Comment='* Differentiator '+compType
        Title='Add parameters for Differentiator '+compName
	out_lower_limit='  Enter out lower limit (default=0.0): '
	out_upper_limit='  Enter out upper limit (default=5.0): '
	out_offset='  Enter offset for output (default=0.0): '
	gain='  Enter gain (default=1.0): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,out_lower_limit,out_upper_limit,out_offset,gain])
      elif compType=="limit8":
        for i in range(0,len(words)/2-1):
          schematicInfo.append("a"+str(k)+" "+words[i+1]+" "+words[i+len(words)/2]+" "+compName)
          k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding limiter"
	Comment='* Limiter '+compType        
	Title='Add parameters for Limiter '+compName
	lowerLimit='  Enter out lower limit (default=0.0): '
	upperLimit='  Enter out upper limit (default=5.0): '
	in_offset='  Enter offset for input (default=0.0): '
	gain='  Enter gain (default=1.0): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,lowerLimit,upperLimit,in_offset,gain])
      elif compType=="controlledlimiter":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding controlledlimiter"
	Comment='* Controlled Limiter '+compType        
	Title='Add parameters for Controlled Limiter '+compName
	in_offset='  Enter offset for input (default=0.0): '
	gain='  Enter gain (default=1.0): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,in_offset,gain])
      elif compType=="analogswitch":
        schematicInfo.append("a"+str(k)+" "+words[1]+" ("+words[2]+" "+words[3]+") "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding analogswitch"
	Comment='* Analog Switch '+compType
        Title='Add parameters for Analog Switch '+compName
	cntl_on='  Enter control ON voltage (default=5.0): '
	cntl_off='  Enter control OFF voltage (default=0.0): '
	r_on='  Enter ON resistance value (default=10.0): '
	r_off='  Enter OFF resistance value (default=1e6): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,cntl_on,cntl_off,r_on,r_off])
      elif compType=="zener":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding Zener"
	Comment='* Zener Diode '+compType
	Title='Add parameters for Zener Diode '+compName
	v_breakdown='  Enter Breakdown voltage (default=5.6): '
	i_breakdown='  Enter Breakdown current (default=2.0e-2): '
	i_sat='  Enter saturation current (default=1.0e-12): '
	n_forward='  Enter forward emission coefficient (default=0.0): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,v_breakdown,i_breakdown,i_sat,n_forward])
      elif compType=="d_buffer":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding Buffer"
	Comment='* Buffer '+compType
        Title='Add parameters for Buffer '+compName
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
	input_load='  Enter input load capacitance (default=1e-12): '
        print "-----------------------------------------------------------"
       	guimodelvalue.append([index,compline,compType,compName,Comment,Title,rise_delay,fall_delay,input_load])
      elif compType=="d_inverter":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding Inverter"
	Comment='* Inverter '+compType        
	Title='Add parameters for Inverter '+compName
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
	input_load='  Enter input load capacitance (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,rise_delay,fall_delay,input_load])
      elif compType=="d_and":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding AND"
	Comment='* And '+compType
        Title= 'Add parameters for And '+compName
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
	input_load='  Enter input load capacitance (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,rise_delay,fall_delay,input_load])
      elif compType=="d_nand":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding NAND"
        Comment='* Nand '+compType
	Title='Add parameters for Nand '+compName
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
	input_load='  Enter input load capacitance (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,rise_delay,fall_delay,input_load])
      elif compType=="d_or":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding OR"
	Comment='* OR '+compType
        Title='Add parameters for OR '+compName
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
	input_load='  Enter input load capacitance (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,rise_delay,fall_delay,input_load])
      elif compType=="d_nor":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding NOR"
	Comment='* NOR '+compType
        Title ='Add parameters for NOR '+compName
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
	input_load='  Enter input load capacitance (default=1e-12): '
        print "-----------------------------------------------------------"
	guimodelvalue.append([index,compline,compType,compName,Comment,Title,rise_delay,fall_delay,input_load])
      elif compType=="d_xor":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
        print "-----------------------------------------------------------\n"
	print "Adding XOR"	
	Comment='* XOR '+compType
        Title='Add parameters for XOR '+compName
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
	input_load='  Enter input load capacitance (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,rise_delay,fall_delay,input_load])
      elif compType=="d_xnor":
        schematicInfo.append("a"+str(k)+" ["+words[1]+" "+words[2]+"] "+words[3]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding XNOR"
	Comment='* XNOR '+compType
        Title='Add parameters for XNOR '+compName
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
	input_load='  Enter input load capacitance (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,rise_delay,fall_delay,input_load])
      elif compType=="d_tristate":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding Tristate"
	Comment='* Tristate '+compType
        Title='Add parameters for Tristate '+compName
	delay='  Enter delay (default=1e-12): '
	input_load='  Enter input load capacitance (default=1e-12): '
	enable_load='  Enter enable load capacitance (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,delay,input_load,enable_load])
      elif compType=="d_pullup":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding pullup"
	Comment='* Pullup '+compType
        Title='Add parameters for Pullup '+compName
	load='  Enter load capacitance (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,load])
      elif compType=="d_pulldown":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding pulldown"
	Comment='* Pulldown '+compType
        Title='Add parameters for Pulldown '+compName
	load='  Enter load capacitance (default=1e-12): '
        print "-----------------------------------------------------------"
	guimodelvalue.append([index,compline,compType,compName,Comment,Title,load])
      elif compType=="d_srlatch":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+words[7]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding SR Latch"
	Comment='* SR Latch '+compType
        Title='Add parameters for SR Latch '+compName
	sr_delay='  Enter input to set-reset delay (default=1e-12): '
	enable_delay='  Enter enable delay (default=1e-12): '
	set_delay='  Enter set delay (default=1e-12): '
	reset_delay='  Enter reset delay (default=1e-12): '
	ic='  Enter initial condition on output (default=0): '
	sr_load=' Enter input to set-reset load (default=1e-12): '
	enable_load='  Enter enable load (default=1e-12): '
	set_load='  Enter set load (default=1e-12): '
	reset_load='  Enter reset load (default=1e-12): '
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,sr_delay,enable_delay,set_delay,reset_delay,ic,sr_load,enable_load,set_load,reset_load,rise_delay,fall_delay])
      elif compType=="d_jklatch":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+words[7]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding JK Latch"
	Comment='* JK Latch '+compType
        Title= 'Add parameters for JK Latch '+compName
	jk_delay='  Enter input to j-k delay (default=1e-12): '
	enable_delay='  Enter enable delay (default=1e-12): '
	set_delay='  Enter set delay (default=1e-12): '
	reset_delay='  Enter reset delay (default=1e-12): '
	ic='  Enter initial condition on output (default=0): '
	jk_load='  Enter input to j-k load (default=1e-12): '
	enable_load='  Enter enable load (default=1e-12): '
	set_load='  Enter set load (default=1e-12): '
	reset_load='  Enter reset load (default=1e-12): '
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,jk_delay,enable_delay,set_delay,reset_delay,ic,enable_load,set_load,reset_load,rise_delay,fall_delay])
      elif compType=="d_dlatch":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding D Latch"
	Comment='* D Latch '+compType
        Title= 'Add parameters for D Latch '+compName
	data_delay='  Enter input to data delay (default=1e-12): '
	enable_delay='  Enter enable delay (default=1e-12): '
	set_delay='  Enter set delay (default=1e-12): '
	reset_delay='  Enter reset delay (default=1e-12): '
	ic='  Enter initial condition on output (default=0): '
	data_load='  Enter input to data load (default=1e-12): '
	enable_load='  Enter enable load (default=1e-12): '
	set_load='  Enter set load (default=1e-12): '
	reset_load='  Enter reset load (default=1e-12): '
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,data_delay,enable_delay,set_delay,reset_delay,ic,data_load,enable_load,set_load,reset_load,rise_delay,fall_delay])
      elif compType=="d_tlatch":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding T Latch"
	Comment='* T Latch '+compType
        Title= 'Add parameters for T Latch '+compName
	t_delay='  Enter input to t delay (default=1e-12): '
	enable_delay='  Enter enable delay (default=1e-12): '
	set_delay='  Enter set delay (default=1e-12): '
	reset_delay='  Enter reset delay (default=1e-12): '
	ic='  Enter initial condition on output (default=0): '
	t_load='  Enter input to t load (default=1e-12): '
	enable_load='  Enter enable load (default=1e-12): '
	set_load='  Enter set load (default=1e-12): '
	reset_load='  Enter reset load (default=1e-12): '
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,t_delay,enable_delay,set_delay,reset_delay,ic,t_load,enable_load,set_load,reset_load,rise_delay,fall_delay])
      elif compType=="d_srff":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+words[7]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding SR Flip-Flop"
	Comment='* SR Flip-Flop '+compType
        Title='Add parameters for SR Flip-Flop '+compName
	clk_delay='  Enter clk delay (default=1e-12): '
	set_delay='  Enter set delay (default=1e-12): '
	reset_delay='  Enter reset delay (default=1e-12): '
	ic='  Enter initial condition on output (default=0): '
	sr_load='  Enter input to set-reset load (default=1e-12): '
	clk_load='  Enter clk load (default=1e-12): '
	set_load='  Enter set load (default=1e-12): '
	reset_load='  Enter reset load (default=1e-12): '
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,clk_delay,set_delay,reset_delay,ic,sr_load,clk_load,set_load,reset_load,rise_delay,fall_delay])
      elif compType=="d_jkff":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+words[7]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding JK Flip-Flop"
	Comment='* JK Flip-Flop '+compType        
	Title= 'Add parameters for JK Flip-Flop '+compName
	clk_delay='  Enter clk delay (default=1e-12): '
	set_delay='  Enter set delay (default=1e-12): '
	reset_delay='  Enter reset delay (default=1e-12): '
	ic='  Enter initial condition on output (default=0): '
	jk_load='  Enter input to j-k load (default=1e-12): '
	clk_load='  Enter clk load (default=1e-12): '
	set_load='  Enter set load (default=1e-12): '
	reset_load='  Enter reset load (default=1e-12): '
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,clk_delay,set_delay,reset_delay,ic,jk_load,clk_load,set_load,reset_load,reset_load,rise_delay,fall_delay])
      elif compType=="d_dff":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding D Flip-Flop"
	Comment='* D Flip-Flop '+compType
        Title= 'Add parameters for D Flip-Flop '+compName
	clk_delay='  Enter clk delay (default=1e-12): '
	set_delay='  Enter set delay (default=1e-12): '
	reset_delay='  Enter reset delay (default=1e-12): '
	ic='  Enter initial condition on output (default=0): '
	data_load='  Enter input to data load (default=1e-12): '
	clk_load='  Enter clk load (default=1e-12): '
	set_load='  Enter set load (default=1e-12): '
	reset_load='  Enter reset load (default=1e-12): '
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,clk_delay,set_delay,reset_delay,ic,data_load,clk_load,set_load,reset_load,rise_delay,fall_delay])
      elif compType=="d_tff":
        schematicInfo.append("a"+str(k)+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[4]+" "+words[5]+" "+words[6]+" "+compName)
        k=k+1
	#Insert comment at remove line
	schematicInfo.insert(index,"* "+compline)
        print "-----------------------------------------------------------\n"
	print "Adding T Flip-Flop"
	Comment='* T Flip-Flop '+compType
        Title='Add parameters for T Flip-Flip '+compName
	clk_delay='  Enter clk delay (default=1e-12): '
	set_delay='  Enter set delay (default=1e-12): '
	reset_delay='  Enter reset delay (default=1e-12): '
	ic='  Enter initial condition on output (default=0): '
	t_load='  Enter input to t load (default=1e-12): '
	clk_load='  Enter clk load (default=1e-12): '
	set_load='  Enter set load (default=1e-12): '
	reset_load='  Enter reset load (default=1e-12): '
	rise_delay='  Enter rise delay (default=1e-12): '
	fall_delay='  Enter fall delay (default=1e-12): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,clk_delay,set_delay,reset_delay,ic,t_load,clk_load,set_load,reset_load,rise_delay,fall_delay])
      elif compType=="vplot1":
        outputOption.append("plot v("+words[1]+")\n")
        schematicInfo.insert(index,"* Plotting option "+compType)
      elif compType=="vplot8_1":
        outputOption.append("plot ")
        for i in range(1,len(words)-1):
          outputOption.append("v("+words[i]+") ")
        outputOption.append("\n")
        schematicInfo.insert(index,"* Plotting option "+compType)
      elif compType=="vdbplot8_1":
        outputOption.append("plot ")
        for i in range(1,len(words)-1):
          outputOption.append("db(v("+words[i]+")) ")
        outputOption.append("\n")
        schematicInfo.insert(index,"* Plotting option "+compType)
      elif compType=="vphase_plot8_1":
        outputOption.append("plot ")
        for i in range(1,len(words)-1):
          outputOption.append("ph(v("+words[i]+")) ")
        outputOption.append("\n")
        schematicInfo.insert(index,"* Plotting option "+compType)
      elif compType=="vprint1":
        outputOption.append("print v("+words[1]+")\n")
        schematicInfo.insert(index,"* Printing option "+compType)
      elif compType=="calc":
	outputOption.append("plot "+words[2]+"\n")
        schematicInfo.insert(index,"* Plotting option "+compType)
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
      elif compType=="powerplot":
        outputOption.append("print ((v("+words[1]+")-v("+words[2]+"))^2)/("+words[3]+")\n")
        schematicInfo.insert(index,"* Printting option "+compType)
      elif compType=="ic":
	Comment='*Adding initial Condition '+compType
	Title=' Add initial condition ' +compName
        print "-----------------------------------------------------------"
	print "Adding initial condition"
	ic='  Enter initial condition on output (default=0): '
        print "-----------------------------------------------------------"
        guimodelvalue.append([index,compline,compType,compName,Comment,Title,words[1],ic])
      elif compType=="opamp1":
        f = open(OSCAD_HOME)
        data = f.read()
        schematicInfo.insert(index,data)
      else: 
        schematicInfo.insert(index,compline)
    # Update option information
  return schematicInfo,outputOption,guimodelvalue


			
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
  """Insert analysis from file"""
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
    length=raw_input('  Enter length of mosfet '+words[0]+'(default=100u):')
    multiplicative_factor=raw_input('  Enter multiplicative factor of mosfet '+words[0]+'(default=1):')
    if width=="": width="100u"
    if multiplicative_factor=="": multiplicative_factor="100u"
    if length=="": length="100u"
    schematicInfo.insert(index,words[0]+" "+words[1]+" "+words[2]+" "+words[3]+" "+words[3]+" "+words[4]+" "+'M='+multiplicative_factor+" "+'L='+length+" "+'W='+width)
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

#List for storing source and its value
sourcelist=[]
sourcelisttrack=[]


# Add parameter to sources
schematicInfo,sourcelist=insertSpecialSourceParam(schematicInfo,sourcelist)

#Calling createrootwindow
sourcelist,sourcelisttrack=createrootwindow(sourcelist,sourcelisttrack)
print "Output Option",outputOption
print schematicInfo


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
#dummy=raw_input('Press Enter to quit')
