#!/usr/bin/python
# openSubckt.py is a python script to open an existing subcircuit. It developed for OSCAD software. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
# Copyright (C) 2012 Yogesh Dilip Save, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

from Tkinter import *
import template
import tkMessageBox
import os.path
from string import maketrans

class ExistingSubcktInfo(template.MyTemplate):
  """ Class for accept subckt information from  user """
  def body(self, master):
  # Ask for compoent name  
    Label(master, text="Enter Component name:").grid(row=0)
    self.e1 = Entry(master)
    self.e1.grid(row=0, column=1,pady=10,columnspan=2)

# Collect subckt information  
  def apply(self):
    pass

# Validate the subckt information
  def validate(self):
  # Remove trailing and leading spaces from subcktName
    self.subcktName=self.e1.get().strip()
    if len(self.subcktName):
      return 1
    else:
      tkMessageBox.showwarning("Bad input","Component Name is not specified, please try again")
      return 0

if __name__=='__main__':
  root=Tk()
  subckt= ExistingSubcktInfo(root)
  mainloop()

