#!/usr/bin/python
# modelEditor.py is a python script to display fornt end of the model editor. It developed for OSCAD software. It is written by Yogesh Dilip Save (yogessave@gmail.com) and Shalini Shrivastava.  
# Copyright (C) 2012 Yogesh Dilip Save and Shalini Shrivastava, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

from setPath import OSCAD_HOME
from Tkinter import *
import tkMessageBox
import newModel
import openModel
import selectModel
import importModel
import exportModel
import os
import sys

# Create a new model
def newEditor(e=None):
# Read model information (name and type)
  model= newModel.ModelInfo(root)
# Create model file
  if model.status:
    modelParam = newModel.ModelParam(root,model.modelName,model.modelType)

# Open an existing model
def openEditor(e=None):
  model= openModel.ExistingModelInfo(root)
# Open model file
  if model.status:
    modelParam = openModel.ExistingModelParam(root,model.modelName)

# Import an existing model from library
def importEditor(e=None):
  model=importModel.ImportModel(root)
  temp_model_name=model.modelName
  if temp_model_name.startswith('NMOS',0,4):
    if os.system("cp "+OSCAD_HOME+"/modelLibrary/"+model.modelName+" mos_n.lib"):
      tkMessageBox.showerror("Import Failed","Unable to import model file "+model.modelName)
    else:
      tkMessageBox.showinfo("Successfully imported","Model file "+model.modelName+" is successfully imported to the project.") 
  elif temp_model_name.startswith('PMOS',0,4):
    if os.system("cp "+OSCAD_HOME+"/modelLibrary/"+model.modelName+" mos_p.lib"):
      tkMessageBox.showerror("Import Failed","Unable to import model file "+model.modelName)
    else:
      tkMessageBox.showinfo("Successfully imported","Model file "+model.modelName+" is successfully imported to the project.")
  elif temp_model_name.startswith('D',0,1):
    if os.system("cp "+OSCAD_HOME+"/modelLibrary/"+model.modelName+" 1n4007.lib"):
      tkMessageBox.showerror("Import Failed","Unable to import model file "+model.modelName)
    else:
      tkMessageBox.showinfo("Successfully imported","Model file "+model.modelName+" is successfully imported to the project.") 
  else:
    if os.system("cp "+OSCAD_HOME+"/modelLibrary/"+model.modelName+" ."):
      tkMessageBox.showerror("Import Failed","Unable to import model file "+model.modelName)
    else:
      tkMessageBox.showinfo("Successfully imported","Model file "+model.modelName+" is successfully imported to the project.") 


# Export an existing model to library
def exportEditor(e=None):
  model=exportModel.ExportModel(root)
  if os.system("cp "+model.modelName+" "+OSCAD_HOME+"/modelLibrary/"):
    tkMessageBox.showerror("Export Failed","Unable to export model file "+model.modelName)
  else:
    tkMessageBox.showinfo("Successfully exported","Model file "+model.modelName+" is successfully exported to the model library") 

# Exit an model editor
def exitEditor(e=None):
  if tkMessageBox.askokcancel("QUIT","Do you really wish to quit?"):
    root.destroy()

# Display help content
def helpEditor(e=None):
  pass

# Display help content
def aboutEditor():
  tkMessageBox.showinfo("About Editor","Created by Yogesh Dilip Save and Shalini Shrivastava")

##Function to open select model from the list to modify it
def openSelectModel(e=None):
	filename=sys.argv[1]
	#Getting lenght of Model List and clicked result
	lenght_modlist,result=callModel(root,filename)
	response=result
	if result=="OK":
	    for item in range(lenght_modlist-1):
	        if response=="OK":	
	           temp_lenght,temp_result=callModel(root,filename)
		   response=temp_result
	        else:
		   break
	    
	else:
	    pass
	
def callModel(root,filename):
    model=selectModel.ModelNameList(root, filename)
    if model.status:
     # Open the circuit file
       modelFile=model.modelName+".lib"
     # Check model file already exists
       if os.path.exists(modelFile):
          if tkMessageBox.askokcancel("Model already exists","Do you want to edit?"):
            modelParam = openModel.ExistingModelParam(root,model.modelName)
       else:
	    modelParam = newModel.ModelParam(root,model.modelName,model.modelType)
    return len(model.modelList),model.click_result
	

root = Tk()
root.title("Ngspice Model Editor")
root.geometry("600x400+300+125")

# Create and configure a menu
menu = Menu(root)
root.config(menu=menu)

# Create File menu
filemenu= Menu(menu)
menu.add_cascade(label="File", menu=filemenu)
filemenu.add_command(label="New   F2", command=newEditor)
#filemenu.add_command(label="Open  F3", command=openEditor)
filemenu.add_command(label="Edit  F7",command=openSelectModel)
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

"""model=selectModel.ModelNameList(root, filename)
print "Model",model.modelList
	

if model.status:
 # Open the circuit file
  modelFile=model.modelName+".lib"
 # Check model file already exists
  if os.path.exists(modelFile):
    if tkMessageBox.askokcancel("Model already exists","Do you want to edit?"):
      modelParam = openModel.ExistingModelParam(root,model.modelName)
  else:
    modelParam = newModel.ModelParam(root,model.modelName,model.modelType)
"""
# Protocol for deletion of main window
root.protocol("WM_DELETE_WINDOW",exitEditor)

# Create shortcut keys
root.bind("<F2>", newEditor)
#root.bind("<F3>", openEditor)
root.bind("<F4>", importEditor)
root.bind("<F5>", exportEditor)
root.bind("<F6>", exitEditor)
root.bind("<F1>", helpEditor)
root.bind("<F7>", openSelectModel)

mainloop()
