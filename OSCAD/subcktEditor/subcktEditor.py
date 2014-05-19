#!/usr/bin/python
# subcktEditor.py is a python script to create a fornt for subcircuit editor. It developed for OSCAD software. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
# Copyright (C) 2012 Yogesh Dilip Save, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

from setPath import OSCAD_HOME
from Tkinter import *
from createSubckt import createSubckt
import tkMessageBox
import setPath
import newSubckt
import openSubckt
import selectSubckt
import exportSubckt
import importSubckt
import os
import sys

# Create a new subckt
def newEditor(e=None):
# Read subckt information (name and type)
  subckt= newSubckt.SubcktInfo(root)
# Create subckt file
  if subckt.status:
    os.system("eeschema "+subckt.subcktName+".sch")

# Open an existing subckt
def openEditor(e=None):
  subckt= openSubckt.ExistingSubcktInfo(root)
# Open subckt file
  if subckt.status:
    os.system("eeschema "+subckt.subcktName+".sch")

# Import an existing model from library
def importEditor(e=None):
  subckt=importSubckt.ImportSubckt(root)
  if os.system("cp "+OSCAD_HOME+"/subcktLibrary/"+subckt.Name+".* ."):
    tkMessageBox.showerror("Import Failed","Unable to import subcircuit file "+subckt.Name)
  else:
    tkMessageBox.showinfo("Successfully imported","Sub-circuit file "+subckt.Name+" is successfully imported to the project.") 

# Export an existing model to library
def exportEditor(e=None):
  subckt=exportSubckt.ExportSubckt(root)
  if os.system("cp "+subckt.Name+".* "+OSCAD_HOME+"/subcktLibrary/"):
    tkMessageBox.showerror("Export Failed","Unable to export subcircuit file "+subckt.Name)
  else:
    tkMessageBox.showinfo("Successfully exported","Subcircuit file "+subckt.Name+" is successfully exported to the subckt library") 

# Exit an subckt editor
def exitEditor(e=None):
  if tkMessageBox.askokcancel("QUIT","Do you really wish to quit?"):
    root.destroy()

# Display help content
def helpEditor(e=None):
  pass

# Display help content
def aboutEditor():
  tkMessageBox.showinfo("About Editor","Created by Yogesh Dilip Save.")

root = Tk()
root.title("Sub-circuit Editor")
root.geometry("600x400+300+125")

# Create and configure a menu
menu = Menu(root)
root.config(menu=menu)

# Create File menu
filemenu= Menu(menu)
menu.add_cascade(label="File", menu=filemenu)
filemenu.add_command(label="New   F2", command=newEditor)
filemenu.add_command(label="Open  F3", command=openEditor)
filemenu.add_separator()
filemenu.add_command(label="Import  F4", command=importEditor)
filemenu.add_command(label="Export  F5", command=exportEditor)
filemenu.add_separator()
filemenu.add_command(label="Exit  F6", command=exitEditor)

# Create help menu
helpmenu=Menu(menu)
menu.add_cascade(label="Help", menu=helpmenu)
helpmenu.add_command(label="Help  F1",command=helpEditor)
helpmenu.add_command(label="About...",command=aboutEditor)

# Select device from devices in circuit file
filename=sys.argv[1]
subckt=selectSubckt.SubcktNameList(root, filename)

if subckt.status:
 # Open the circuit file 
  subcktFile=subckt.subcktName+".sch"
 # Check subckt file already exists
  if os.path.exists(subcktFile):
    if tkMessageBox.askokcancel("Subckt already exists","Do you want to edit?"):
    # Call all pending idle tasks, without processing any other events.
      root.update_idletasks()
      os.system("eeschema "+subckt.subcktName+".sch")
    else:
      exitEditor()
  else:
    os.system("eeschema "+subckt.subcktName+".sch")
  status=createSubckt(subckt.subcktName)
  if status:
    tkMessageBox.showinfo("Error","Error while creating subcircuit")
  else:
    tkMessageBox.showinfo("Successful","Created sub-circuit "+subckt.subcktName+".sub")

# Protocol for deletion of main window
root.protocol("WM_DELETE_WINDOW",exitEditor)

# Create shortcut keys
root.bind("<F2>", newEditor)
root.bind("<F3>", openEditor)
root.bind("<F4>", importEditor)
root.bind("<F5>", exportEditor)
root.bind("<F6>", exitEditor)
root.bind("<F1>", helpEditor)

mainloop()
