#!/usr/bin/python
# openProject.py is a python script to open an existing project. It is developed for OSCAD software. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
# Copyright (C) 2012 Yogesh Dilip Save, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

from Tkinter import *
import template
import tkMessageBox
import os.path
from string import maketrans

class ProjectInfo(template.MyTemplate):
  """ Class for accept model information from  user """
  def body(self, master):
  # Ask for compoent name  
    Label(master, text="Enter Project name:").grid(row=0)
    self.e1 = Entry(master)
    self.e1.grid(row=0, column=1,pady=10,columnspan=2)
    tempStr=os.getcwd()
    tempStr2=tempStr.split('/')
    self.e1.insert(0,tempStr2[len(tempStr2)-1])

# Collect project information
  def apply(self):
    """ a method for writing project information to the file"""
    self.text.insert(END, "Successfully opened project " + self.projectName+". \n")
    self.text.yview(END)
    pass

# Validate the model information
  def validate(self):
  # Remove trailing and leading spaces from modelName
    self.projectName=self.e1.get().strip()
    if len(self.projectName):
      self.text.insert(END, "Opening project " + self.projectName+" ...... \n")
      self.text.yview(END)
    # Read project file
      try:
        self.text.insert(END, "   Checking project information file " + self.projectName+".proj. ...... \n")
        self.text.yview(END)
        f = open(self.projectName+".proj","r")
      except :
        tkMessageBox.showwarning("Error","Project information file does not exist, Try again")
        return 0
      f.close()
      return 1
    else:
      tkMessageBox.showwarning("Bad input","Project Name is not specified, please try again")
      return 0

if __name__=='__main__':
  root=Tk()
  project= ProjectInfo(root)
  mainloop()

