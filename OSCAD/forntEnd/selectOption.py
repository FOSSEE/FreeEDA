#!/usr/bin/python
# selectOption.py is a python script to select option for Scilab based circuit simulator. It is developed for OSCAD software. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
# Copyright (C) 2012 Yogesh Dilip Save, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

from setPath import OSCAD_HOME
from Tkinter import *
import template
import tkMessageBox
import os.path
from string import maketrans

class SelectOption(template.MyTemplate):
  """ Class for accept model information from  user """
  def body(self, master):
  # Define default mode type and set it to symbolic
    self.option = StringVar()
    self.option.set("1")

  # Ask for scilab option
    Label(master, text="Enter mode for scilab based circuit simulator:").grid(row=1)
    Radiobutton(master, text="Normal", variable=self.option, value="0").grid(row=2,column=0,columnspan=2,sticky=W)
    Radiobutton(master, text="Symbolic", variable=self.option, value="1").grid(row=3,column=0,columnspan=2,sticky=W)
    Radiobutton(master, text="Matrix", variable=self.option, value="2").grid(row=4,column=0,columnspan=2,sticky=W)

# Collect model information  
  def apply(self):
    self.mode=self.option.get()
    try:
      self.OSCAD_HOME=OSCAD_HOME
    except NameError:
      try:
        self.OSCAD_HOME=os.environ["OSCAD_HOME"]
      except KeyError:
        tkMessageBox.showerror("Error OSCAD_HOME is not set","Please set OSCAD_HOME variable in .bashrc\n\nStep to set  OSCAD_HOME variable:\n  1) Open ~/.bashrc using text editor (vi ~/.bash).\n   2) Add the line \"Export OSCAD_HOME=<path_of_oscad>\" to it.\n  3) source ~/.bashrc")
        exit(0) 
    HOME=self.OSCAD_HOME+"/LPCSim/LPCSim/"
  # Open file for writing option
    fileName=HOME+"option"
    os.system("rm -rf "+ fileName)
  # Create model file for writing
    try:
      f = open(fileName,"w")
    except :
      tkMessageBox.showwarning("Error","Model file can not be wriiten. please check the file system permission")
    f.write(self.mode)
    f.close()
 
if __name__=='__main__':
  root=Tk()
  model= SelectOption(root)
  mainloop()

