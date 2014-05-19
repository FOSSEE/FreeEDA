#!/usr/bin/python
# checkPythonModule.py is a python script file to check python modules required for OSCAD software. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
# Copyright (C) 2012 Yogesh Dilip Save, FOSS Project, IIT Bombay.
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

import os
def checkPackage(package):
  packageName=package[0]
  libraryName=package[1]
  try:
    __import__(packageName)
  except ImportError:
    print "  Error: Python module " + packageName +" not found."
    print "  Trying to install " + packageName
    try: 
      os.system("./installModule.sh " + libraryName) 
    except:
      print "Unable to install "+ libraryName
    try:
      import time
      time.sleep(2)
    except ImportError:
      pass
    try:
      __import__(packageName)
    except ImportError:
      print "Unable to find "+packageName
      print "Please re-run the ./installOSCAD.sh If you are getting this error first time"
      print '\033[91m'+ "  Please Install Python Library: " + libraryName + " using package manager"+ '\033[0m' 
      exit(1)
  print "  Found python module: " +packageName

packageList=[["wx","python-wxgtk2.8 wx-common"],["re","re"],["Image","python-imaging"],["ImageTk","python-imaging-tk"],["string","string"],["Tkinter","python-tk"],["Pmw","python-pmw"]]
for package in packageList:
  checkPackage(package)
