#!/usr/bin/python
# importSubckt.py is a python script to import a component subcircuit definition from library. It developed for FreeEDA software. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
# Copyright (C) 2012 Yogesh Dilip Save, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

from setPath import FreeEDA_HOME
from Tkinter import *
from Tkinter import *
import template
import tkMessageBox
import os.path
import os
import Pmw
from string import maketrans

class ImportSubckt():
  """Class for importing a subckt from the library"""
  def __init__(self,parent):
    self.parent=parent
    self.Name=""
  # Collect model information available in the model library
    try:
      self.FreeEDA_HOME=FreeEDA_HOME
    except NameError:
      try:
        self.FreeEDA_HOME=os.environ["FreeEDA_HOME"]
      except KeyError:
        tkMessageBox.showerror("Error FreeEDA_HOME is not set","Please set FreeEDA_HOME variable in .bashrc\n\nStep to set  FreeEDA_HOME variable:\n  1) Open ~/.bashrc using text editor (vi ~/.bash).\n   2) Add the line \"Export FreeEDA_HOME=<path_of_freeeda>\" to it.\n  3) source ~/.bashrc")
        exit(0)

    fileList=os.listdir(self.FreeEDA_HOME+"/subcktLibrary")
    subcktList=[]
    
    for fileName in fileList:
      if "sub" in fileName:
        subcktName=fileName.split('.')
        subcktList.append(subcktName[0])

  # Create the dialog.
    self.dialog = Pmw.SelectionDialog(parent,
      title = 'Sub-circuit Selector',
      buttons = ('OK', 'Cancel'),
      defaultbutton = 'OK',
      scrolledlist_labelpos = 'n',
      label_text = 'Please select the subcircuit',
      scrolledlist_items=subcktList,
      command = self.apply,
    )
    self.dialog.pack(fill = 'both', expand=1, padx=5, pady=5)
    self.dialog.activate()

  # Protocol when window is deleted.
    self.dialog.protocol("WM_DELETE_WINDOW",self.cancel)

  def apply(self,result):
    sels = self.dialog.getcurselection()
    if result=="OK":
      if len(sels) == 0:
        print 'You clicked on', result, '(no selection)'
        return
      else:
        self.Name=sels[0]
        self.status=1
    else:
      self.status=0
    self.dialog.withdraw()
  # Put focus back to the parent window
    self.parent.focus_set()
  # Destroy child window
    self.dialog.deactivate()

# Action taken when cancel pressed
  def cancel(self, event=None, status=0):
  # Catch the status
    self.status=status
  # Put focus back to the parent window
    self.parent.focus_set()
  # Destroy child window
    self.destroy()

if __name__=='__main__':
  root=Tk()
  subckt= ImportSubckt(root,"xxx")
  mainloop()

