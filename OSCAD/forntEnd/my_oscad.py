from setPath import OSCAD_HOME
from Tkinter import *
import thread
import ttk
import template
import tkMessageBox
import os.path
import os
import toolTip
import selectOption
from string import maketrans
from PIL import Image, ImageTk
import tkFileDialog
import os
import Image
import ImageTk

def new_Project(e=None):
  text.insert(END,"Select the directory to save the project\n")
  directory=tkFileDialog.askdirectory()
  if directory: 
    try:
      os.chdir(directory)
      text.insert(END, "Changing directory to "+directory+"\n\n")
      text.yview(END)
    except OSError, msg:
      tkMessageBox.showerror("Change Directory Failed",msg)
  else:
    tkMessageBox.showwarning("Bad input","Directory is not specified, please try again")
  text.insert(END, "In Main window:\n")
  text.insert(END, "Please select the proper option from File Menu\n")
  text.yview(END)
  text.insert(END, "Please enter a project Name\n")
  text.yview(END)
# Read project information (name)
  project= newProject.ProjectInfo(root,text)
# Create project files
  if project.status:
    projectParam = newProject.ProjectParam(root,text,project.projectName)

# Open an existing model
def open_Project(e=None):
# Read project information (name)
  text.insert(END, "Please enter the project Name\n")
  text.yview(END)
  project= openProject.ProjectInfo(root,text)
# Open model file
  if project.status:
    projectParam = newProject.ProjectParam(root,text,project.projectName)
  text.insert(END, "In Main window:\n")
  text.insert(END, "Please select the proper option from File Menu\n")

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
  text.insert(END, "In Main window:\n")
  text.insert(END, "Please select the proper option from File Menu\n")
  text.yview(END)
  
def exit_Project(e=None):
  if tkMessageBox.askokcancel("QUIT","Do you really wish to quit?"):
    text.insert(END, "Bye Bye......\n")
    root.destroy()

# Display help content
def help_Project(e=None):
  pass

# Display help content
def about_Project():
  tkMessageBox.showinfo("About Editor","Created by Yogesh Dilip Save")
  
def createButtonForCommand(frameName,commandName,imagePath,textlabel):
  # Open images
    im = Image.open(imagePath)
    photo = ImageTk.PhotoImage(im)
  
  # Create button and set label for tools
    w = Button(frameName, image=photo, width=20, height=14, command=commandName, default=ACTIVE)
    w.image=photo
    w.pack(side=TOP, padx=1, pady=1)
    toolTip.createToolTip(w,textlabel)
    
def call_system(command):
    os.system(command)

def openSchematic(e=None):
    text.insert(END, "  Opening schematic editor .........\n")
    text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    #update_idletasks()
    command="eeschema "+self.projectName+".sch "
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    text.insert(END, "Select a tool from tool menu\n")
    text.yview(END)
 
def openFootprint(e=None):
    text.insert(END, "  Opening footprint editor .........\n")
    text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    update_idletasks()
    command="cvpcb "+self.projectName+".net "
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    text.insert(END, "Select a tool from tool menu\n")
    text.yview(END)
  
def openLayout(e=None):
    text.insert(END, "  Opening layout editor .........\n")
    text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    update_idletasks()
    command="pcbnew "+self.projectName+".net "
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    text.insert(END, "Select a tool from tool menu\n")
    text.yview(END)

def openNetConverter(e=None):
    text.insert(END, "  Running netlist converter .........\n")
    text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    update_idletasks()
    command="xterm -e \""+self.OSCAD_HOME+"/kicadtoNgspice/KicadtoNgspice.py "+self.projectName+".cir 1\""
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    text.insert(END, "Select a tool from tool menu\n")
    text.yview(END)

def openAnalysisInserter(e=None):
    text.insert(END, "  Opening analysis inserter .........\n")
    text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    update_idletasks()
    command=self.OSCAD_HOME+"/analysisInserter/convertgui.py"
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    text.insert(END, "Select a tool from tool menu\n")
    text.yview(END)

def openModelBuilder(e=None):
    text.insert(END, "  Opening model editor .........\n")
    text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    update_idletasks()
    command=self.OSCAD_HOME+"/modelEditor/modelEditor.py " +self.projectName+".cir "
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    text.insert(END, "Select a tool from tool menu\n")
    text.yview(END)

def openSubcircuitBuilder(e=None):
    text.insert(END, "  Opening Sub-circuit editor ................\n")
    text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    update_idletasks()
    command=self.OSCAD_HOME+"/subcktEditor/subcktEditor.py " +self.projectName+".cir "
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    text.insert(END, "Select a tool from tool menu\n")
    text.yview(END)

def openNgspice(e=None):
    text.insert(END, "  Running ngspice circuit simulator .........\n")
    text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    update_idletasks()
    command="xterm -e \"ngspice "+self.projectName+".cir.out \""
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    text.insert(END, "Select a tool from tool menu\n")
    text.yview(END)

def openSMCSim(e=None):
    text.insert(END, "  Running scilab based circuit simulator .........\n")
    text.yview(END)
  # Call all pending idle tasks, without processing any other events.
    update_idletasks()
    Option=selectOption.SelectOption(self,self.text,"LPCSim")
    command=self.OSCAD_HOME+"/bin/scilab54 -f " +self.OSCAD_HOME+"/LPCSim/LPCSim/Main.sci -args "+self.projectName+".cir.ckt "
    try:
        thread.start_new_thread(self.call_system,(command,))
    except Exception,err:
        print err
    text.insert(END, "Select a tool from tool menu\n")
    text.yview(END)


# Create and configure a graphical window
root = Tk()
root.title("OSCAD for Electronics and Electrical Engineers")

# make it cover the entire screen
w, h = root.winfo_screenwidth(), root.winfo_screenheight()
root.geometry("%dx%d" % (0.65*w, 0.65*h))
root.focus_set()

# Create and configure a menu
menu = Menu(root)
root.config(menu=menu)

# Create File menu
filemenu= Menu(menu)
menu.add_cascade(label="File", menu=filemenu)
filemenu.add_command(label="New   F2", command=new_Project)
filemenu.add_command(label="Open  F3", command=changeDirectory)
filemenu.add_separator()
filemenu.add_command(label="Exit  F4", command=exit_Project)

# Create help menu
helpmenu=Menu(menu)
menu.add_cascade(label="Help", menu=helpmenu)
helpmenu.add_command(label="Help  F1",command=help_Project)
helpmenu.add_command(label="About...",command=about_Project)

# Protocol for deletion of main window
root.protocol("WM_DELETE_WINDOW",exit_Project)

# Create shortcut keys
root.bind("<F2>", new_Project)
root.bind("<F3>", open_Project)
root.bind("<F4>", exit_Project)
root.bind("<F1>", help_Project)
root.bind("<F5>", changeDirectory)

mainWindow = LabelFrame(root, bd=4, relief=SUNKEN,text="Main Window", bg='lightblue')
mainWindow.pack(side=TOP,fill="both", padx=5, pady=5,expand="Y")
mainWindow.place(relheight=0.85, relwidth=0.99, rely=0.0)

c = Canvas(mainWindow, bg='white',width=745, height=320)
c.pack()
im = Image.open(OSCAD_HOME+"/images/OSCADlogo.jpeg")                  
tkim = ImageTk.PhotoImage(im)                 
c.create_image(375, 150, image=tkim) 

buttonWindow = Frame(root, bd=4, relief=SUNKEN)
buttonWindow.pack(side=RIGHT,fill="both", padx=2, pady=2,expand="Y")
buttonWindow.place(relheight=0.6, relwidth=0.06, rely=0.04, relx=0.01)

createButtonForCommand(buttonWindow,openSchematic,OSCAD_HOME+"/images/seLogo.jpg","Schematic Editor")
createButtonForCommand(buttonWindow,openFootprint,OSCAD_HOME+"/images/feLogo.jpg","Footprint Editor")
createButtonForCommand(buttonWindow,openLayout,OSCAD_HOME+"/images/leLogo.jpg","Layout Editor")
createButtonForCommand(buttonWindow,openAnalysisInserter,OSCAD_HOME+"/images/anLogo.jpg","Analysis Insertor")
createButtonForCommand(buttonWindow,openModelBuilder,OSCAD_HOME+"/images/mbLogo.jpg","Model builder")
createButtonForCommand(buttonWindow,openSubcircuitBuilder,OSCAD_HOME+"/images/sbLogo.jpg","Subcircuit builder")
createButtonForCommand(buttonWindow,openNetConverter,OSCAD_HOME+"/images/knLogo.jpg","NetList Converter")
createButtonForCommand(buttonWindow,openNgspice,OSCAD_HOME+"/images/ngLogo.jpg","Ngspice")
createButtonForCommand(buttonWindow,openSMCSim,OSCAD_HOME+"/images/slLogo.jpg","SMCSim")

reportWindow = LabelFrame(root, bd=4, relief=SUNKEN,text="Report Window")
reportWindow.pack(side=BOTTOM,fill="both", padx=5, pady=5,expand="Y")
reportWindow.place(relheight=0.35, relwidth=0.99, rely=0.65)

text = Text(reportWindow)
text.insert(INSERT, "Welcome.....\n")
text.insert(END, "First select project working directory using File Menu\n")
text.insert(END, "Then select the proper option in File Menu\n")
text.focus_set()
text.pack()
text.place(relheight=0.98, relwidth=0.99, rely=0.02)
text.config(borderwidth=5)
 
scrollY = Scrollbar(reportWindow,orient=VERTICAL,command=text.yview)
scrollY.pack(fill=Y)
scrollY.place(relheight=0.98,relwidth=0.01, rely=0.02, relx=0.99)
text.config(yscrollcommand=scrollY.set)
scrollY.set(0,0.5)

    
def execute(event):
  print "yogesh"

text.bind("<Return>",execute)
mainloop()
