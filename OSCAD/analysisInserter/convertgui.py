#!/usr/bin/python
# convertgui.py is a python script to create analysis option for ngspice. It is developed for OSCAD software. It is written by Saket Choudhary (saketkc@gmail.com).  
# Copyright (C) 2012 Yogesh Dilip Save, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
# It is modified by Yogesh Dilip Save on 9th October 2012.

import wx
import os,re
ID_ABOUT=101
ID_OPEN=102
ID_SAVE=103
ID_BUTTON1=300
ID_EXIT=200

# Some classes to use for the notebook pages.  Obviously you would
# want to use something more meaningful for your application, these
# are just for illustration.

def convertintoScientificForm(str):
  if str[0]=='p': 
    return "e-12"
  elif str[0]=='n' : 
    return "e-09"
  elif str[0]=='u' : 
    return "e-06"
  elif str[0]=='m' : 
    return "e-03"
  else:
    return "e-00"

class PageOne(wx.Panel):
  def __init__(self, parent):
    wx.Panel.__init__(self, parent)
    
    grid1 = wx.GridSizer(5, 2)	
    grid1.Add(wx.StaticText(self,-1,'Enter Source Name:'),1)
    hbox = wx.BoxSizer(wx.HORIZONTAL)
    self.source = wx.TextCtrl(self, -1, '',  (150, 75), (120, -1))
    hbox.Add(self.source)
    grid1.Add(hbox)

    grid1.Add(wx.StaticText(self,-1,'Start'),1)
    hbox = wx.BoxSizer(wx.HORIZONTAL)
    self.start = wx.SpinCtrl(self, -1, '',  (150, 75), (60, -1))
    hbox.Add(self.start)
    self.startscale = wx.ComboBox(self, -1, value = 'Volts or Amperes',  choices=['mV or mA', 'uV or uA', 'nV or nA', 'pV or pA'], size=(160, -1), style=wx.CB_DROPDOWN)
    hbox.Add(self.startscale)
    grid1.Add(hbox)

    grid1.Add(wx.StaticText(self,-1,'Increment'),1)
    hbox = wx.BoxSizer(wx.HORIZONTAL)
    self.step = wx.SpinCtrl(self, -1, '',  (150, 75), (60, -1))
    hbox.Add(self.step)
    self.stepscale = wx.ComboBox(self, -1, value = 'Volts or Amperes',  choices=['mV or mA', 'uV or uA', 'nV or nA', 'pV or pA'], size=(160, -1), style=wx.CB_DROPDOWN)
    hbox.Add(self.stepscale)
    grid1.Add(hbox)

    grid1.Add(wx.StaticText(self,-1,'Stop'),1)
    hbox = wx.BoxSizer(wx.HORIZONTAL)
    self.stop = wx.SpinCtrl(self, -1, '',  (150, 75), (60, -1))
    hbox.Add(self.stop)
    self.stopscale = wx.ComboBox(self, -1, value = 'Volts or Amperes',  choices=['mV or mA', 'uV or uA', 'nV or nA', 'pV or pA'], size=(160, -1), style=wx.CB_DROPDOWN)
    hbox.Add(self.stopscale)
    grid1.Add(hbox)
    
    hbox = wx.BoxSizer(wx.HORIZONTAL)
    self.cb = wx.CheckBox(self, -1, 'Operating Point analysis', (10, 10))
    hbox.Add(self.cb)
    grid1.Add(wx.StaticText(self,-1,''),1)
    grid1.Add(hbox)
    
    hbox = wx.BoxSizer(wx.HORIZONTAL)
    self.button = wx.Button(self,901,"Add Simulation Data")
    hbox.Add(self.button)
    self.button.Bind(wx.EVT_BUTTON, self.enter_simulation)
    grid1.Add(wx.StaticText(self,-1,''),1)
    grid1.Add(hbox)
    self.SetSizer(grid1)
    self.Centre()
    self.Show(True)
  
  def enter_simulation(self,e):
    txtctrl = self.GetParent().GetParent().control
    previous_data = txtctrl.GetValue()
    start = str(self.start.GetValue()) +convertintoScientificForm(str(self.startscale.GetValue()))
    stop  =  str(self.stop.GetValue())  +convertintoScientificForm(str(self.stopscale.GetValue()))
    step  =  str(self.step.GetValue())  +convertintoScientificForm(str(self.stepscale.GetValue()))
    source  =  str(self.source.GetValue())
    if self.cb.GetValue():
      appendline = ".op"
    else:
      appendline = ".dc "  + " " + str(source)+" "+ str(start) + " " + str(stop)  + " " + str(step) + "\n" 
    txtctrl.AppendText(appendline)

class PageTwo(wx.Panel):
    def __init__(self, parent):
        wx.Panel.__init__(self, parent)
        sizer = wx.StaticBoxSizer(wx.StaticBox(self, -1, 'Scale'), orient=wx.HORIZONTAL)
	self.lin = wx.RadioButton(self, -1, 'Lin')
	self.dec = wx.RadioButton(self, -1, 'Dec')
	self.octal = wx.RadioButton(self, -1, 'Oct')
	sizer.Add(self.lin)
	sizer.Add(self.dec)
	sizer.Add(self.octal)
	grid1 = wx.GridSizer(5, 2)
	grid1.Add(sizer,1)
	grid1.Add(wx.StaticText(self,-1,''))
	grid1.Add(wx.StaticText(self,-1,'Start Frequency'),1)
	hbox = wx.BoxSizer(wx.HORIZONTAL)
	self.start = wx.SpinCtrl(self, -1, '',  (150, 75), (60, -1))
	hbox.Add(self.start)
	self.startscale = wx.ComboBox(self, -1, value = 'Hz',  choices=['THz', 'GHz', 'Meg', 'KHz', 'Hz'], size=(60, -1), style=wx.CB_DROPDOWN)
	hbox.Add(self.startscale)
	grid1.Add(hbox)
	grid1.Add(wx.StaticText(self,-1,'Stop Frequency'),1)
	hbox = wx.BoxSizer(wx.HORIZONTAL)
	self.stop = wx.SpinCtrl(self, -1, '',  (150, 75), (60, -1))
	hbox.Add(self.stop)
	self.stopscale = wx.ComboBox(self, -1, value = 'Hz',  choices=['THz', 'GHz', 'Meg', 'KHz', 'Hz'], size=(60, -1), style=wx.CB_DROPDOWN)
	hbox.Add(self.stopscale)
	grid1.Add(hbox)
	
	grid1.Add(wx.StaticText(self,-1,'Number of points'),1)
	hbox = wx.BoxSizer(wx.HORIZONTAL)
	self.datapoints = wx.SpinCtrl(self, -1, '',  (150, 75), (60, -1))
	hbox.Add(self.datapoints)
	grid1.Add(hbox)
	hbox = wx.BoxSizer(wx.HORIZONTAL)
	self.button = wx.Button(self,901,"Add Simulation Data")
	hbox.Add(self.button)
	self.button.Bind(wx.EVT_BUTTON, self.enter_simulation)
	grid1.Add(wx.StaticText(self,-1,''),1)
	grid1.Add(hbox)
	self.SetSizer(grid1)
	self.Centre()
	self.Show(True)
    def OnButton(self,e):
	print self.lin.GetValue()
	print self.GetParent().GetParent().control.GetValue()
    def enter_simulation(self,e):
	txtctrl = self.GetParent().GetParent().control
	if self.lin.GetValue():
	    ac_scale="lin"
	elif self.dec.GetValue():
	    ac_scale="dec"
	elif self.octal.GetValue():
	    ac_scale = "octal"
	previous_data = txtctrl.GetValue()
	#print previous_data
	data_real = re.sub(r'.end.*',"",previous_data)
	txtctrl.SetValue(data_real)
	number_of_data_points = str(self.datapoints.GetValue())
	start_frequency = str(self.start.GetValue())+ str(self.startscale.GetValue())
	stop_frequency = str(self.stop.GetValue())+ str(self.stopscale.GetValue())
	appendline_ac = ".ac " + str(ac_scale) + " " + str(number_of_data_points)+" " + str(start_frequency) + " " + str(stop_frequency) + "\n" 
	#appendline_end = ".end\n"
	#appendline_control=".control\n" + "run\n" + ".endc\n"
	#with open(filename,"a") as myfile:
	txtctrl.AppendText("\n")
	txtctrl.AppendText(appendline_ac)
	#txtctrl.AppendText("\n\n")
	#txtctrl.AppendText(appendline_end)
	#txtctrl.AppendText(appendline_control)


class PageThree(wx.Panel):
    def __init__(self, parent):
        wx.Panel.__init__(self, parent)
        
        grid1 = wx.GridSizer(5, 2)	
	grid1.Add(wx.StaticText(self,-1,'Start Time'),1)
	hbox = wx.BoxSizer(wx.HORIZONTAL)
	self.start = wx.SpinCtrl(self, -1, '',  (150, 75), (60, -1))
	hbox.Add(self.start)
	self.startscale = wx.ComboBox(self, -1, value = 'Sec',  choices=['ms', 'us', 'ns', 'ps'], size=(60, -1), style=wx.CB_DROPDOWN)
	hbox.Add(self.startscale)

	grid1.Add(hbox)
	grid1.Add(wx.StaticText(self,-1,'Step Time'),1)
	hbox = wx.BoxSizer(wx.HORIZONTAL)
	self.step = wx.SpinCtrl(self, -1, '',  (150, 75), (60, -1))
	hbox.Add(self.step)
	self.stepscale = wx.ComboBox(self, -1, value = 'sec',  choices=['ms', 'us', 'ns', 'ps'], size=(60, -1), style=wx.CB_DROPDOWN)
	hbox.Add(self.stepscale)

	grid1.Add(hbox)
	grid1.Add(wx.StaticText(self,-1,'Stop Time'),1)
	hbox = wx.BoxSizer(wx.HORIZONTAL)
	self.stop = wx.SpinCtrl(self, -1, '',  (150, 75), (60, -1))
	hbox.Add(self.stop)
	self.stopscale = wx.ComboBox(self, -1, value = 'sec',  choices=['ms', 'us', 'ns', 'ps'], size=(60, -1), style=wx.CB_DROPDOWN)
	hbox.Add(self.stopscale)
	grid1.Add(hbox)
	
	hbox = wx.BoxSizer(wx.HORIZONTAL)
	self.button = wx.Button(self,901,"Add Simulation Data")
	hbox.Add(self.button)
	self.button.Bind(wx.EVT_BUTTON, self.enter_simulation)
	grid1.Add(wx.StaticText(self,-1,''),1)
	grid1.Add(hbox)
	self.SetSizer(grid1)
	self.Centre()
	self.Show(True)
    
    def enter_simulation(self,e):
	txtctrl = self.GetParent().GetParent().control
	
	previous_data = txtctrl.GetValue()
	#print previous_data
#	data_real = re.sub(r'.end.*',"",previous_data)
#	txtctrl.SetValue(data_real)	
	start_time = str(self.start.GetValue()) +convertintoScientificForm(str(self.startscale.GetValue()))
	stop_time =  str(self.stop.GetValue())  +convertintoScientificForm(str(self.stopscale.GetValue()))
	step_time =  str(self.step.GetValue())  +convertintoScientificForm(str(self.stepscale.GetValue()))
	appendline_trans = ".tran "  + " "  + str(step_time) + " " + str(stop_time)  + " " + str(start_time) + "\n" 
#	appendline_end = ".end\n"
#	appendline_control=".control\n" + "run\n" + ".endc\n"
	#with open(filename,"a") as myfile:
#	txtctrl.AppendText("\n")
	txtctrl.AppendText(appendline_trans)
#	txtctrl.AppendText("\n\n")
#	txtctrl.AppendText(appendline_end)
#	txtctrl.AppendText(appendline_control)


class PageFour(wx.Panel):
    def __init__(self, parent):
        wx.Panel.__init__(self, parent)
        t = wx.StaticText(self, -1, "Fourier", (60,60))


class PageFive(wx.Panel):
    def __init__(self, parent):
        wx.Panel.__init__(self, parent)
        t = wx.StaticText(self, -1, "Pole Zero", (60,60))


class PageSix(wx.Panel):
    def __init__(self, parent):
        wx.Panel.__init__(self, parent)
        t = wx.StaticText(self, -1, "Transfer Function", (60,60))
class MainFrame(wx.Frame):
    def __init__(self):#self,parent,wx.ID_ANY, title
        wx.Frame.__init__(self,None, wx.ID_ANY, title="kicad ngspice")
	self.CreateStatusBar(style=0)
	self.control = wx.TextCtrl(self, 1, style=wx.TE_MULTILINE)
	filemenu= wx.Menu()
        # use ID_ for future easy reference - much better that "48", "404" etc
        # The & character indicates the short cut key
        filemenu.Append(ID_OPEN, "&Open"," Open a file to edit")
        filemenu.AppendSeparator()
        filemenu.Append(ID_SAVE, "&Save"," Save file")
        filemenu.AppendSeparator()
        filemenu.Append(ID_ABOUT, "&About"," Information about this program")
        filemenu.AppendSeparator()
        filemenu.Append(ID_EXIT,"E&xit"," Terminate the program")

        # Creating the menubar.
        menuBar = wx.MenuBar()
        menuBar.Append(filemenu,"&File") # Adding the "filemenu" to the MenuBar
        self.SetMenuBar(menuBar)  # Adding the MenuBar to the Frame content.
        # Note - previous line stores the whole of the menu into the current object

        # Define the code to be run when a menu option is selected
        wx.EVT_MENU(self, ID_ABOUT, self.OnAbout)
        wx.EVT_MENU(self, ID_EXIT, self.OnExit)
        wx.EVT_MENU(self, ID_OPEN, self.OnOpen)
        wx.EVT_MENU(self, ID_SAVE, self.OnSave); # just "pass" in our demo

	self.aboutme = wx.MessageDialog( self, " Converter for kicad \n"
                            " in wxPython","Beta mode", wx.OK)
        self.doiexit = wx.MessageDialog( self, " Exit - R U Sure? \n",
                        "GOING away ...", wx.YES_NO)

        # dirname is an APPLICATION variable that we're choosing to store
        # in with the frame - it's the parent directory for any file we
        # choose to edit in this frame
        self.dirname = os.getcwd()

	#self.sizer2 = wx.BoxSizer(wx.HORIZONTAL)
	#self.sizer=wx.BoxSizer(wx.VERTICAL)
        #self.sizer.Add(self.control,1,wx.EXPAND)
        #self.sizer.Add(self.sizer2,0,wx.EXPAND)
	#self.SetSizer(self.sizer)

        # Here we create a panel and a notebook on the panel
        p = wx.Panel(self)
        nb = wx.Notebook(self)

        # create the page windows as children of the notebook
        page1 = PageOne(nb)
        page2 = PageTwo(nb)
        page3 = PageThree(nb)
        page4 = PageFour(nb)
        page5 = PageFive(nb)
        page6 = PageSix(nb)

        # add the pages to the notebook with the label to show on the tab
        nb.AddPage(page1, "DC")
        nb.AddPage(page2, "AC")
        nb.AddPage(page3, "Transient")
        nb.AddPage(page4, "Fourier")
        nb.AddPage(page5, "Pole Zero")
        nb.AddPage(page6, "Transfer Function")

        # finally, put the notebook in a sizer for the panel to manage
        # the layout
        sizer = wx.BoxSizer(wx.VERTICAL)
        sizer.Add(nb, 1, wx.EXPAND)
	sizer.Add(self.control,1,wx.EXPAND)
        self.SetSizer(sizer)

	 #wx.Frame.__init__(self,parent,wx.ID_ANY, title)

        # Add a text editor and a status bar
        # Each of these is within the current instance
        # so that we can refer to them later.
	#self.SetAutoLayout(1)
        #self.sizer.Fit(self)

        # Show it !!!
        #self.Show(1)
	self.Maximize()


    def OnAbout(self,e):
        # A modal show will lock out the other windows until it has
        # been dealt with. Very useful in some programming tasks to
        # ensure that things happen in an order that  the programmer
        # expects, but can be very frustrating to the user if it is
        # used to excess!
        self.aboutme.ShowModal() # Shows it
    def OnExit(self,e):
        # A modal with an "are you sure" check - we don't want to exit
        # unless the user confirms the selection in this case ;-)
        igot = self.doiexit.ShowModal() # Shows it
        if igot == wx.ID_YES:
            self.Close(True)  # Closes out this simple application

    def OnOpen(self,e):
        # In this case, the dialog is created within the method because
        # the directory name, etc, may be changed during the running of the
        # application. In theory, you could create one earlier, store it in
        # your frame object and change it when it was called to reflect
        # current parameters / values
        dlg = wx.FileDialog(self, "Choose a file", self.dirname, "", "*.*", wx.OPEN)
        if dlg.ShowModal() == wx.ID_OK:
            self.filename=dlg.GetFilename()
            self.dirname=dlg.GetDirectory()

            # Open the file, read the contents and set them into
            # the text edit window
            filehandle=open(os.path.join(self.dirname, self.filename),'r')
            self.control.SetValue(filehandle.read())
            filehandle.close()

            # Report on name of latest file read
            self.SetTitle("Editing ... "+self.filename)
            # Later - could be enhanced to include a "changed" flag whenever
            # the text is actually changed, could also be altered on "save" ...
        dlg.Destroy()

    def OnSave(self,e):
        # Save away the edited text
        # Open the file, do an RU sure check for an overwrite!
        dlg = wx.FileDialog(self, "Choose a file", self.dirname, "analysis", "*.*", \
                wx.SAVE | wx.OVERWRITE_PROMPT)
        if dlg.ShowModal() == wx.ID_OK:
            # Grab the content to be saved
            itcontains = self.control.GetValue()

            # Open the file for write, write, close
            self.filename=dlg.GetFilename()
            self.dirname=dlg.GetDirectory()
            filehandle=open(os.path.join(self.dirname, self.filename),'w')
            filehandle.write(itcontains)
            filehandle.close()
        # Get rid of the dialog to keep things tidy
        dlg.Destroy()

        


if __name__ == "__main__":
    app = wx.App()
    
    MainFrame().Show(1)
    #MainFrame().Maximize()
    #MainFrame().Layout()
    app.MainLoop()
