#!/usr/bin/python
from setPath import OSCAD_HOME
from Tkinter import *
import template
import tkMessageBox
import os.path
import os
import Pmw
from string import maketrans

class SubcktNameList():
  """Class for specifying parameter of the subckt"""
  def __init__(self,parent,filename):
    self.parent=parent
    self.subcktName=""
  # Collect subckt information from the circuit file
    try:
      self.OSCAD_HOME=OSCAD_HOME
    except NameError:
      try:
        self.OSCAD_HOME=os.environ["OSCAD_HOME"]
      except KeyError:
        tkMessageBox.showerror("Error OSCAD_HOME is not set","Please set OSCAD_HOME variable in .bashrc\n\nStep to set  OSCAD_HOME variable:\n  1) Open ~/.bashrc using text editor (vi ~/.bash).\n   2) Add the line \"Export OSCAD_HOME=<path_of_oscad>\" to it.\n  3) source ~/.bashrc")
      exit(0) 

    HOME=self.OSCAD_HOME+"/subcktEditor/"
  # Open the circuit file 
    self.fileName=filename
  # Open parameter file
    if os.path.exists(self.fileName):
      try:
        f = open(self.fileName)
      except :
        tkMessageBox.showwarning("Bad input","Circuit netlist does not exit, please try again")
        return
    else:
        tkMessageBox.showwarning("Bad input","Circuit netlist does not exit, please try again")
        return

  # Read the data from file
    data=f.read()
  
  # Close the file
    f.close()
    netlist=data.splitlines()
  # Find the various subckt library required
    subcktList=[]
    for eachline in netlist:
      eachline=eachline.strip()
      if len(eachline)>1:
        eachline=eachline.lower()
        words=eachline.split()
        if eachline[0]=='x':
          subcktName=words[len(words)-1]
        else:
          continue
        if subcktName in subcktList:
          continue
        subcktList.append(subcktName)

  # Create the dialog.
    self.dialog = Pmw.SelectionDialog(parent,
      title = 'Subckt Selector',
      buttons = ('OK', 'Cancel'),
      defaultbutton = 'OK',
      scrolledlist_labelpos = 'n',
      label_text = 'Please select the subckt',
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
        self.subcktName=sels[0]
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
  subckt= SubcktNameList(root,"xxx")
  mainloop()

