#!/usr/bin/python
# oscad.py is a python script to create fornt end for OSCAD software. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
# Copyright (C) 2012 Yogesh Dilip Save, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

from setPath import OSCAD_HOME
from Tkinter import *
import ttk
import tkMessageBox
import tkFileDialog
import newProject
import openProject
import os
import Image
import ImageTk
import os
import sys
#  T=os.popen("ls -l").read()
#  text.insert(END, T)

# Create a new model
def new_Project(e=None):
  #text.insert(END,"Select the directory to save the project\n")
  directory=tkFileDialog.askdirectory()
  if directory: 
    try:
      os.chdir(directory)
      text.insert(END, "Changing directory to "+directory+"\n\n")
      text.yview(END)
      project= newProject.ProjectInfo(root,text)
    except msg:
      tkMessageBox.showerror("Change Directory Failed",msg)
  else:
    tkMessageBox.showwarning("Bad input","Directory is not specified, please try again")
# Create project files
  try:
    if project.status:
        projectParam = newProject.ProjectParam(root,text,project.projectName)
  except:
      pass

# Open an existing model
def open_Project(e=None):
# Read project information (name)
  text.insert(END, "Please enter the project Name\n")
  text.yview(END)
  project= openProject.ProjectInfo(root,text)
# Open model file
  if project.status:
    projectParam = newProject.ProjectParam(root,text,project.projectName)
  #text.insert(END, "In Main window:\n")
  #text.insert(END, "Please select the proper option from File Menu\n")

# Change the current directory to new directory
def changeDirectory(event=None): 
  folderName=tkFileDialog.askdirectory()
  if folderName: 
    try:
      os.chdir(folderName)
      text.insert(END, "Changing directory to "+folderName+"\n\n")
      text.yview(END)
      open_Project()
    except OSError, msg:
      tkMessageBox.showerror("Change Directory Failed",msg)
  else:
    tkMessageBox.showwarning("Bad input","Directory is not specified, please try again")

# Exit an model editor
def exit_Project(e=None):
  if tkMessageBox.askokcancel("QUIT","Do you really wish to quit, this will close all OSCAD projects that are running ?"):
    text.insert(END, "Good Bye !!\n")
    root.destroy()

# Display help content
def help_Project(e=None):
  pass

# Display help content
def about_Project():
  tkMessageBox.showinfo("About Oscad","Oscad is a free & open source CAD tool for\
  Electronics & Electrical Engineers.\n \
  \nDeveloped by putting together open source soft like:\neeschema(kicad), \nPCB layout editor (kicad), \nNGSpice, \nScilab.\n\
  \nDeveloped at IIT Bombay by FOSSEE team")

# Create and configure a graphical window
root = Tk()
root.title("Oscad")
"""img = PhotoImage(file="an.jpg")
root.tk.call('wm', 'iconphoto', root._w, img)"""

# make it cover the entire screen
w, h = root.winfo_screenwidth(), root.winfo_screenheight()
root.geometry("%dx%d" % (0.15*w, 0.25*h))
root.focus_set()
root.resizable(0,0)

"""mainWindow = Frame(root)

b1 = Button(mainWindow, text="New", width=18, command=new_Project)
b1.pack()
b2 = Button(mainWindow, text="Open", width=18, command=changeDirectory)
b2.pack()
b3 = Button(mainWindow, text="Exit", width=18, command=exit_Project)
b3.pack()

mainWindow.pack()"""

"""c = Canvas(root, bg='lightblue')
c.pack(side=LEFT)
c.place(relheight=0.99, relwidth=0.99, rely=0.0,relx=0.2)
im = Image.open(OSCAD_HOME+"/images/logo.png")                  
tkim = ImageTk.PhotoImage(im)                 
c.create_image(75, 75, image=tkim)"""

img = ImageTk.PhotoImage(Image.open(OSCAD_HOME+"/images/logo.png"))
panel = Label(root, image = img)
panel.place(relheight=0.8,relwidth=0.8,rely=0.0,relx=0.1)
panel.pack()

# Create and configure a menu
menu = Menu(root)
root.config(menu=menu)

# Create File menu
filemenu= Menu(menu)
menu.add_cascade(label="Project", menu=filemenu)
filemenu.add_command(label="New F2", command=new_Project)
filemenu.add_command(label="Open  F3", command=changeDirectory)
filemenu.add_separator()
filemenu.add_command(label="Exit  F4", command=exit_Project)

# Create help menu
helpmenu=Menu(menu)
menu.add_cascade(label="Help", menu=helpmenu)
helpmenu.add_command(label="Help  F1",command=help_Project)
helpmenu.add_command(label="About...",command=about_Project)

# Protocol for deletion of main window


# Create shortcut keys
root.bind("<F2>", new_Project)
root.bind("<F3>", changeDirectory)
root.bind("<F4>", exit_Project)
root.bind("<F1>", help_Project)

"""mainWindow = LabelFrame(root, bd=4, relief=SUNKEN,text="Main Window", bg='lightblue')
mainWindow.pack(side=TOP,fill="both", padx=5, pady=5,expand="Y")
mainWindow.place(relheight=0.85, relwidth=0.99, rely=0.0)

c = Canvas(mainWindow, bg='white',width=750, height=325)
c.pack()
im = Image.open(OSCAD_HOME+"/images/OSCADlogo.jpeg")                  
tkim = ImageTk.PhotoImage(im)                 
c.create_image(375, 150, image=tkim)"""

reportWindow = LabelFrame(root, bd=4, relief=SUNKEN,text="Report Window")
#reportWindow.pack(side=BOTTOM,fill="both", padx=5, pady=5,expand="Y")
#reportWindow.place(relheight=0.52, relwidth=0.98, rely=0.47)

text = Text(reportWindow)
"""text.insert(INSERT, "Welcome !!\n")
text.insert(END, "New: Create a New Project\n")
text.insert(END, "Open: Open an Exising Project\n")
text.focus_set()
text.pack()
text.place(relheight=0.99, relwidth=0.99)
text.config(borderwidth=5)
 
scrollY = Scrollbar(reportWindow,orient=VERTICAL,command=text.yview)
scrollY.pack(fill=Y)
scrollY.place(relheight=0.98,relwidth=0.01, rely=0.02, relx=0.99)
text.config(yscrollcommand=scrollY.set)
scrollY.set(0,0.5)"""

root.protocol("WM_DELETE_WINDOW",exit_Project)

def execute(event):
  print "yogesh"

#text.bind("<Return>",execute)
mainloop()
