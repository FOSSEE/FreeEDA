#!/usr/bin/python
from Tkinter import *
import os

class MyTemplate(Toplevel):
  """Template to construct new window"""
# Define constructor 
  def __init__(self, parent, text=None, title=None, buttonbox=True):
  # Set new window properties same as parent
    Toplevel.__init__(self, parent)
  
  # Set report window  
    if text:
      self.text=text

  # Create a new window on top of the parent such that don't appear in taskbar   
    self.transient(parent)

  # Set the title
    if title:
      self.title("Tools")
  # Set Parent of active window
    self.parent =parent
 
  # Create a new frame
    body =Frame (self)
   # Call body method  
    self.initial_focus = self.body(body)
   # Display body 
    body.pack(padx=5, pady=5)
   # Create buttons
    if buttonbox:
        self.buttonbox()
   # Create status bar 
    self.statusBar()
   # Take control of all the events    
    self.grab_set()
  
  # Take control of all the keyboard events 
    if not self.initial_focus:
      self.initial_focus=self

  # Protocol when window is deleted.
    self.protocol("WM_DELETE_WINDOW",self.cancel)
  
  # Position the geometry respect to main window
    self.geometry("+%d+%d" % (parent.winfo_rootx()+10,parent.winfo_rooty()+22))
    self.initial_focus.focus_set()

  # Wait for widget to be destroyed
    self.wait_window(self)
 
# Construction of body of the window
  def body(self, master):
  # Create dialog body. This method should be overridden
    pass

# Add standard button box (OK, Cancel). Override if you don't want the standard buttons
  def buttonbox(self):
  # Construct a new frame
    box = Frame(self)
  # Create buttons  
    w = Button(box, text="OK", width=10, command=self.ok, default=ACTIVE)
    w.pack(side=LEFT, padx=5, pady=5)
    w = Button(box, text="Cancel", width=10, command=self.cancel)
    w.pack(side=LEFT, padx=5, pady=5)

  # Bind Return and escape keys
    self.bind("<Return>", self.ok)
    self.bind("<Escape>", self.cancel)
  # Create the frame "box"
    box.pack(side=BOTTOM)

# Add standard status bar. Override if you don't want the status bar
  def statusBar(self):
    pass
   # self.statusbar = Label(self, text="", bd=1, relief=SUNKEN, anchor=W)
   # self.statusbar.pack(side=BOTTOM, fill=X)

# Template for action taken when OK is pressed
  def ok(self, event=None):
  # If data is not valid then put the focus back
    if not self.validate():
      self.initial_focus.focus_set() 
      return
  # Remove the window from the screen (without destroying it)
    self.withdraw()
  # Call all pending idle tasks, without processing any other events.
    self.update_idletasks()
  # Perform required task (collection of result, inputs etc.)
    self.apply()
  # Take action when all task has finished  
    self.cancel(status=1)

# Template for action taken when cancel pressed
  def cancel(self, event=None, status=0):
  # Catch the status
    self.status=status
  # Put focus back to the parent window
    self.parent.focus_set()
  # Destroy child window
    self.destroy()

# Template for validation of data
  def validate(self):
    return 1

# Template for required action (Saving Data, results) 
  def apply(self):
    pass 

# Test case 
if __name__=='__main__':
  root=Tk()
  d =MyTemplate(root)
  mainloop()
  
