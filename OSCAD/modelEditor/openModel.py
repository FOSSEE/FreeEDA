#!/usr/bin/python
# openModel.py is a python script to open an existing model. It developed for OSCAD software. It is written by Yogesh Dilip Save (yogessave@gmail.com) and Shalini Shrivastava.  
# Copyright (C) 2012 Yogesh Dilip Save and Shalini Shrivastava, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

from Tkinter import *
import template
import tkMessageBox
import os.path
from string import maketrans
from newModel import readSpecs

class ExistingModelInfo(template.MyTemplate):
  """ Class for accept model information from  user """
  def body(self, master):
  # Ask for compoent name  
    Label(master, text="Enter Component name:").grid(row=0)
    self.e1 = Entry(master)
    self.e1.grid(row=0, column=1,pady=10,columnspan=2)

# Collect model information  
  def apply(self):
    pass

# Validate the model information
  def validate(self):
  # Remove trailing and leading spaces from modelName
    self.modelName=self.e1.get().strip()
    if len(self.modelName):
      return 1
    else:
      tkMessageBox.showwarning("Bad input","Component Name is not specified, please try again")
      return 0

class ExistingModelParam(template.MyTemplate):
  """Class for specifying parameter of the model"""
  def __init__(self,parent,name):
  # Collect model information
    self.modelName=name

  # Call base class MyTemplate
    template.MyTemplate.__init__(self,parent)
    	

  def body(self, master):
  # Open template of the library file corresponding model 
    fileName=self.modelName+".lib"
   # Find model information and parameters
    self.info, self.params=readSpecs(fileName)

   # Return if model information is not available
    if len(self.info) == 0:
      self.cancel()
      
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
    self.statusbar.configure(text="Find help in the " +self.info[2]+".hlp file")

  def leaveSpec(self,event):
    self.statusbar.configure(text='')

  def apply(self):
  # Write model parameters to file
    if self.writeModelFile():
      tkMessageBox.showinfo("Info","Model file " +self.modelName+" is modified")

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

if __name__=='__main__':
  root=Tk()
  model= ExistingModelInfo(root)
  modelParam = ExistingModelParam(root,model.modelName)
  mainloop()

