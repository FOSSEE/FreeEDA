#!/usr/bin/python
# helpEditor.py is a python script to display help for the model editor. It developed for OSCAD software. It is written by Yogesh Dilip Save (yogessave@gmail.com) and Shalini Shrivastava.  
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

class HelpInfo(template.MyTemplate):
  """ Class for displaying help information """
  def body(self, master):
  # Help heading
    master.configure(width=768, height=576)
    Label(master, text="Ngspice Model Editor Help", font=("Helvetica", 16), padx=20, pady=20).grid(row=0)

# Add standard button box (OK)
  def buttonbox(self):
  # Construct a new frame
    box = Frame(self)
  # Create buttons  
    w = Button(box, text="OK", width=10, command=self.ok, default=ACTIVE)
    w.pack(padx=5, pady=5)

  # Bind Return and escape keys
    self.bind("<Return>", self.ok)
    self.bind("<Escape>", self.ok)
  # Create the frame "box"
    box.pack()

  def statusBar(self):
    pass

if __name__=='__main__':
  root=Tk()
  model= HelpInfo(root)
  mainloop()

