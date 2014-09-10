#!/usr/bin/python
# newProject.py is a python script to create a new project. It is developed for FreeEDA software. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
# Copyright (C) 2012 Yogesh Dilip Save, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.


from setPath import FreeEDA_HOME
from Tkinter import *
import thread
import ttk
import sys
import subprocess, time
import template
import tkMessageBox
import os.path
import os
import toolTip
import selectOption
from string import maketrans
from PIL import Image, ImageTk

class ProjectInfo(template.MyTemplate):
  """ Class for accept model information from  user """
  def body(self, master):
  # Ask for project name  
    try:
        Label(master, text="Enter Project name:").grid(row=0)
        self.e1 = Entry(master)
        self.e1.grid(row=0, column=1,pady=10,columnspan=2)
    except:
        print "error"
# Collect project information
  def apply(self):
    """ a method for writing project information to the file"""
    self.text.insert(END, "Creating new project " + self.projectName+" ...... \n")
    self.text.yview(END)
  # Cerate directory for the project
    try:
        os.mkdir(self.projectName)
    except:
        tkMessageBox.showwarning("Error","Directory already exists")
    self.text.insert(END, "   The project directory "+self.projectName+"has been created.\n")
    self.text.yview(END)
    os.chdir(self.projectName)
    self.text.insert(END, "   Entered into the project directory "+self.projectName+"\n")
    self.text.yview(END)
  # Create model file for writing
    try:
      f = open(self.projectName+".proj","w")
    except :
      tkMessageBox.showwarning("Error","Project information file can not be wriiten. please check the file system permission")
      return 0 
    f.write("schematicFile " + self.projectName+".sch\n")
    f.close()
    self.text.insert(END, "Successfully Created new project " + self.projectName+". \n")
    self.text.yview(END)
    return 1

# Validate the model information
  def validate(self):
  # Remove trailing and leading spaces from modelName
    self.projectName=self.e1.get().strip()
    if len(self.projectName):
      if os.path.exists(self.projectName+".proj"):
        tkMessageBox.showwarning("Bad input","Project already exists, please try again")
        return 0
      return 1
    else:
      tkMessageBox.showwarning("Bad input","Project Name is not specified, please try again")
      return 0

class ProjectParam(template.MyTemplate):
  """Class for specifying parameter of the model"""
  def __init__(self,parent,text,name):
  # Collect model information
    self.projectName=name
    try:
      self.FreeEDA_HOME=FreeEDA_HOME
    except NameError:
      try:
        self.FreeEDA_HOME=os.environ["FreeEDA_HOME"]
      except KeyError:
        tkMessageBox.showerror("Error FreeEDA_HOME is not set","Please set FreeEDA_HOME variable in .bashrc\n\nStep to set  FreeEDA_HOME variable:\n  1) Open ~/.bashrc using text editor (vi ~/.bash).\n   2) Add the line \"Export FreeEDA_HOME=<path_of_freeeda>\" to it.\n  3) source ~/.bashrc")
        exit(0) 

  # Call base class MyTemplate
    template.MyTemplate.__init__(self,parent,text,name, buttonbox=False)

  def body(self, master):
    w, h = master.winfo_screenwidth(), master.winfo_screenheight()
    self.geometry("%dx%d" % (100,345))
    self.resizable(0,0)
    self.attributes("-topmost",True)

  # Create and configure a menu
    """menu = Menu(self)
    self.config(menu=menu)
 
  # Create File menu
    toolmenu= Menu(menu)
    menu.add_cascade(label="Tool", menu=toolmenu)
    toolmenu.add_command(label="Schematic Editor  F2", command=self.openSchematic)
    toolmenu.add_separator()
    toolmenu.add_command(label="Footprint Editor  F3", command=self.openFootprint)
    toolmenu.add_command(label="Layout Editor  F4", command=self.openLayout)
    toolmenu.add_separator()
    toolmenu.add_command(label="Analysis Insertor  F5", command=self.openAnalysisInserter)
    toolmenu.add_command(label="Model builder  F6", command=self.openModelBuilder)
    toolmenu.add_command(label="Subcircuit builder  F7", command=self.openSubcircuitBuilder)
    toolmenu.add_separator()
    toolmenu.add_command(label="NetList Converter  F8", command=self.openNetConverter)
    toolmenu.add_separator()
    toolmenu.add_command(label="Ngspice  F9", command=self.openNgspice)
    toolmenu.add_command(label="SMCSim  F10", command=self.openSMCSim)
    toolmenu.add_separator()
    toolmenu.add_command(label="Exit  F11", command=self.exitProject)
    
  # Create help menu
    helpmenu=Menu(menu)
    menu.add_cascade(label="Help", menu=helpmenu)
    helpmenu.add_command(label="Help  F1",command=self.helpProject)
    helpmenu.add_command(label="About...",command=self.aboutProjectManager)

   

    self.mainWindow = LabelFrame(self, bd=4, relief=SUNKEN,text="Tool Window",bg="lightblue")
    self.mainWindow.pack(side=TOP,fill="both", padx=5, pady=5, expand="Y")
    self.mainWindow.place(relheight=0.85, relwidth=0.99)"""
    
    # Set frame for command buttons
    buttonWindow = Frame(self, bd=4, relief=SUNKEN)
    buttonWindow.pack(side=LEFT,fill="both", padx=2, pady=2,expand="Y")
    buttonWindow.place(relheight=0.96, relwidth=0.87, rely=0.02, relx=0.07)
    
    self.createButtonForCommand(buttonWindow,self.openSchematic,self.FreeEDA_HOME+"/images/se.png","Schematic Editor")
    self.createButtonForCommand(buttonWindow,self.openAnalysisInserter,self.FreeEDA_HOME+"/images/an.png","Analysis Insertor")
    self.createButtonForCommand(buttonWindow,self.openNetConverter,self.FreeEDA_HOME+"/images/kn.png","NetList Converter")
    self.createButtonForCommand(buttonWindow,self.openNgspice,self.FreeEDA_HOME+"/images/ng.png","Ngspice")
    self.createButtonForCommand(buttonWindow,self.openFootprint,self.FreeEDA_HOME+"/images/fp.png","Footprint Editor")
    self.createButtonForCommand(buttonWindow,self.openLayout,self.FreeEDA_HOME+"/images/lout.png","Layout Editor")
    #self.createButtonForCommand(buttonWindow,self.openSMCSim,self.FreeEDA_HOME+"/images/sci.png","SMCSim")
    self.createButtonForCommand(buttonWindow,self.openModelBuilder,self.FreeEDA_HOME+"/images/mb.png","Model builder")
    self.createButtonForCommand(buttonWindow,self.openSubcircuitBuilder,self.FreeEDA_HOME+"/images/sub.png","Subcircuit builder")

    
  # Protocol for deletion of main window
    self.protocol("WM_DELETE_WINDOW",self.exitProject)
    
  # Create shortcut keys
  """self.bind("<F2>", self.openSchematic)
    self.bind("<F3>", self.openFootprint)
    self.bind("<F4>", self.openLayout)
    self.bind("<F5>", self.openAnalysisInserter)
    self.bind("<F6>", self.openModelBuilder)
    self.bind("<F7>", self.openSubcircuitBuilder)
    self.bind("<F8>", self.openNetConverter)
    self.bind("<F9>", self.openNgspice)
    self.bind("<F10>",self.openSMCSim)
    self.bind("<F11>",self.exitProject)
    self.bind("<F1>", self.helpProject)
    self.focus_set()"""

  def createButtonForCommand(self,frameName,commandName,imagePath,textlabel):
  # Open images
    im = Image.open(imagePath)
    photo = ImageTk.PhotoImage(im)
  
  # Create button and set label for tools
    w = Button(frameName, image=photo, width=45, height=30, command=commandName, default=ACTIVE)
    w.image=photo
    w.pack(side=TOP, padx=1.8, pady=1.8)
    toolTip.createToolTip(w,textlabel)
    
  def call_system(self,command):
      os.system(command)

  def openSchematic(self,e=None):
    self.text.insert(END, "  Opening schematic editor .........\n")
    self.text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    self.update_idletasks()
    command="eeschema "+self.projectName+".sch "
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    self.text.insert(END, "Select a tool from tool menu\n")
    self.text.yview(END)
 
  def openFootprint(self,e=None):
    self.text.insert(END, "  Opening footprint editor .........\n")
    self.text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    self.update_idletasks()
    command="cvpcb "+self.projectName+".net "
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    self.text.insert(END, "Select a tool from tool menu\n")
    self.text.yview(END)
  
  def openLayout(self,e=None):
    self.text.insert(END, "  Opening layout editor .........\n")
    self.text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    self.update_idletasks()
    command="pcbnew "+self.projectName+".net "
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    self.text.insert(END, "Select a tool from tool menu\n")
    self.text.yview(END)

  def openNetConverter(self,e=None):
    self.text.insert(END, "  Running netlist converter .........\n")
    self.text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    self.update_idletasks()
   # command="cmd -e \""+self.FreeEDA_HOME+"/kicadtoNgspice/KicadtoNgspice.py "+self.projectName+".cir 1\""
    command="python "+self.FreeEDA_HOME+"/kicadtoNgspice/KicadtoNgspice.py "+self.projectName+".cir 1"
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    self.text.insert(END, "Select a tool from tool menu\n")
    self.text.yview(END)

  def openAnalysisInserter(self,e=None):
    self.text.insert(END, "  Opening analysis inserter .........\n")
    self.text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    self.update_idletasks()
    command="python "+self.FreeEDA_HOME+"/analysisInserter/convertgui.py"
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    self.text.insert(END, "Select a tool from tool menu\n")
    self.text.yview(END)

  def openModelBuilder(self,e=None):
    self.text.insert(END, "  Opening model editor .........\n")
    self.text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    self.update_idletasks()
    command="python "+self.FreeEDA_HOME+"/modelEditor/modelEditor.py " +self.projectName+".cir 1"
	
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    self.text.insert(END, "Select a tool from tool menu\n")
    self.text.yview(END)

  def openSubcircuitBuilder(self,e=None):
    self.text.insert(END, "  Opening Sub-circuit editor ................\n")
    self.text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    self.update_idletasks()
    command="python "+self.FreeEDA_HOME+"/subcktEditor/subcktEditor.py " +self.projectName+".cir "
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    self.text.insert(END, "Select a tool from tool menu\n")
    self.text.yview(END)

  def openNgspice(self,e=None):
    self.text.insert(END, "  Running ngspice circuit simulator .........\n")
    self.text.yview(END)
    # Call all pending idle tasks, without processing any other events.
    self.update_idletasks()
    command="ngspice "+self.projectName+".cir.out "
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    self.text.insert(END, "Select a tool from tool menu\n")
    self.text.yview(END)

    # opening pythonplotting:
    command ="python " + self.FreeEDA_HOME+"/forntEnd/pythonPlotting.py "+os.getcwd()+" "+self.projectName

    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err

  """def openSMCSim(self,e=None):
    self.text.insert(END, "  Running scilab based circuit simulator .........\n")
    self.text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    self.update_idletasks()
    Option=selectOption.SelectOption(self,self.text,"LPCSim")
    command="wscilex -f " +self.FreeEDA_HOME+"/LPCSim/LPCSim/Main.sci -args "+self.projectName+".cir.ckt "
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    self.text.insert(END, "Select a tool from tool menu\n")
    self.text.yview(END)"""

  def helpProject(self,e=None):
    pass

# Display help content
  def aboutProjectManager(self,e=None):
    tkMessageBox.showinfo("About Project Manager","Created by Yogesh Dilip Save")

# Exit an Project Manager
  def exitProject(self):
    if tkMessageBox.askokcancel("QUIT","Do you really wish to quit?"):
      self.destroy()

  def apply(self):
    pass

if __name__=='__main__':
  root = Tk()
  project= ProjectInfo(root)
  projectParam = ProjectParam(root,project.modelName,project.modelType)
  mainloop()
