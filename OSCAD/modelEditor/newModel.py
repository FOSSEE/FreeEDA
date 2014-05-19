#!/usr/bin/python
# newModel.py is a python script to create a new model. It developed for OSCAD software. It is written by Yogesh Dilip Save (yogessave@gmail.com) and Shalini Shrivastava.  
# Copyright (C) 2012 Yogesh Dilip Save and Shalini Shrivastava, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

from setPath import OSCAD_HOME
from Tkinter import *
import template
import tkMessageBox
import os.path
from string import maketrans

class ModelInfo(template.MyTemplate):
  """ Class for accept model information from  user """
  def body(self, master):
  # Define component type and set it to Diode
    self.component = StringVar()
    self.component.set("D")

  # Ask for compoent name  
    Label(master, text="Enter Component name:").grid(row=0)
    self.e1 = Entry(master)
    self.e1.grid(row=0, column=1,pady=10,columnspan=2)

  # Ask for component type
    Label(master, text="Enter type of Component:").grid(row=1)
    Label(master,text="Diode").grid(row=2,column=1,columnspan=2,sticky=W)
    Radiobutton(master, text="Diode", variable=self.component, value="D").grid(row=3,column=1,columnspan=2,sticky=W)
    Label(master, text="Bipolar Junction Transistor (BJT)").grid(row=4,column=1,columnspan=2,sticky=W)
    Radiobutton(master, text="NPN", variable=self.component, value="NPN").grid(row=5,column=1,sticky=W)
    Radiobutton(master, text="PNP", variable=self.component, value="PNP").grid(row=5,column=2,sticky=W)
    Label(master, text="Metal Oxide Semiconductor (MOS)").grid(row=6,column=1,columnspan=2,sticky=W)
    Radiobutton(master, text="NMOS(Level-1 5um)", variable=self.component, value="NMOS-5um").grid(row=7,column=1,sticky=W)
    Radiobutton(master, text="PMOS(Level-1 5um)", variable=self.component, value="PMOS-5um").grid(row=7,column=2,sticky=W)
    Radiobutton(master, text="NMOS(Level-3 0.5um)", variable=self.component, value="NMOS-0.5um").grid(row=8,column=1,sticky=W)
    Radiobutton(master, text="PMOS(Level-3 0.5um)", variable=self.component, value="PMOS-0.5um").grid(row=8,column=2,sticky=W)
    Radiobutton(master, text="NMOS(Level-8 180nm)", variable=self.component, value="NMOS-180nm").grid(row=9,column=1,sticky=W)
    Radiobutton(master, text="PMOS(Level-8 180nm)", variable=self.component, value="PMOS-180nm").grid(row=9,column=2,sticky=W)
    Label(master, text="Junction Field Effect Transistor (JFET)").grid(row=10,column=1,columnspan=2,sticky=W)
    Radiobutton(master, text="N-JFET", variable=self.component, value="NJF").grid(row=11,column=1,sticky=W)
    Radiobutton(master, text="P-JFET", variable=self.component, value="PJF").grid(row=11,column=2,sticky=W)
    Label(master, text="IGBT").grid(row=12,column=1,columnspan=2,sticky=W)
    Radiobutton(master, text="N-IGBT", variable=self.component, value="NIGBT").grid(row=13,column=1,sticky=W)
    Radiobutton(master, text="P-IGBT", variable=self.component, value="PIGBT").grid(row=13,column=2,sticky=W)
    Label(master, text="Magnetic Core").grid(row=14,column=1,columnspan=2,sticky=W)
    Radiobutton(master, text="Magnetic Core", variable=self.component, value="CORE").grid(row=15,column=1,columnspan=2,sticky=W)

# Collect model information  
  def apply(self):
    self.modelType=self.component.get()

# Validate the model information
  def validate(self):
  # Remove trailing and leading spaces from modelName
    self.modelName=self.e1.get().strip()
    if len(self.modelName):
      return 1
    else:
      tkMessageBox.showwarning("Bad input","Component Name is not specified, please try again")
      return 0

class ModelParam(template.MyTemplate):
  """Class for specifying parameter of the model"""
  def __init__(self,parent,name,type):
  # Collect model information
    self.modelName=name
    self.modelType=type

  # Call base class MyTemplate
    template.MyTemplate.__init__(self,parent)

  def body(self, master):
    try:
      self.OSCAD_HOME=OSCAD_HOME
    except NameError:
      try:
        self.OSCAD_HOME=os.environ["OSCAD_HOME"]
      except KeyError:
        tkMessageBox.showerror("Error OSCAD_HOME is not set","Please set OSCAD_HOME variable in .bashrc\n\nStep to set  OSCAD_HOME variable:\n  1) Open ~/.bashrc using text editor (vi ~/.bash).\n   2) Add the line \"Export OSCAD_HOME=<path_of_oscad>\" to it.\n  3) source ~/.bashrc")
        exit(0)

    HOME=self.OSCAD_HOME+"/modelEditor/"
  # Open template of the library file corresponding model 
    fileName=HOME+self.modelType+".lib"
   # Find model information and parameters
    self.info, self.params=readSpecs(fileName)
      
  # Construct parameter editor window
    i,j=0,0
    for each in self.params.keys():
    # Display parameter name
      Label(master, text=each, padx=5, pady=5).grid(row=j, column=2*i, sticky=W)
   
    # Create entry for parameter value  
      vars(self)[each] = Entry(master)
      vars(self)[each].insert(0,self.params[each])
      vars(self)[each].grid(row=j, column=2*i+1)
    
    # Display help information in the status bar
      vars(self)[each].bind('<Enter>', self.enterSpec)
      vars(self)[each].bind('<Leave>', self.leaveSpec)

    # Column and row adjustment for proper display  
      i+=1
      if i%5==0:
        i,j=0,j+1

  def enterSpec(self,event):
    self.statusbar.configure(text="Find help in the " +self.modelType+".hlp file")

  def leaveSpec(self,event):
    self.statusbar.configure(text='')

  def apply(self):
  # Copy model infomation
    self.info[1]=self.modelName
    self.info[2]=self.modelType
  # Write model parameters to file
    if self.writeModelFile():
      tkMessageBox.showinfo("Info","Model file " +self.modelName+" is created")

  def writeModelFile(self):
    """ a method for writing model file"""
  # Create model file for writing
    try:
      f = open(self.info[1]+".lib","w")
    except :
      tkMessageBox.showwarning("Error","Model file can not be wriiten. please check the file system permission")
      return 0 
    f.write(".model " + self.info[1] + " " + self.info[2] + "( ")
    i=0
    for param in self.params.keys():
      paramName = getattr(self,param)
      paramValueGet = getattr(paramName,'get')
      f.write(param + "=" + paramValueGet()+" ")
      i+=1
    # Column and row adjustment for proper display  
      if i%5==0:
        i=0
        f.write("\n+ ")
    f.write(")")
    f.close()
    return 1
 
def readSpecs(fileName):
  """Read parameters and model information"""
# Variable to store parameter and model information
  params={}
  info=[]

# Open parameter file
  if os.path.exists(fileName):
    try:
      f = open(fileName)
    except :
      tkMessageBox.showwarning("Bad input","Model file does not exit, please try again")
      return info, params
  else:
      tkMessageBox.showwarning("Bad input","Model file does not exit, please try again")
      return info, params
  data=f.read()
  f.close()

# Seperate model and parameter information
  data=data.split('(')
  infoData=data[0]
  paramsData=data[1]
  
# Collect model information in the list
  info=infoData.split()

# Collect model parameter in the dictionary  
  paramsData=paramsData.translate(maketrans('\n+)','   '))
  paramsData=paramsData.split()
  for each in paramsData:
    paramdata=each.split('=')
    params[paramdata[0]]=paramdata[1]
  return info, params

if __name__=='__main__':
  root=Tk()
  model= ModelInfo(root)
  modelParam = ModelParam(root,model.modelName,model.modelType)
  mainloop()

