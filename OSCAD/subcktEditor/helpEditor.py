#!/usr/bin/python
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

