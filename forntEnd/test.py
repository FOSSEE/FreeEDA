##-------------------------------
# file: test.py
# simple demonstration of the Tkinter notebook

from Tkinter import *
from notebook import *

a = Tk()
n = notebook(a, LEFT)

# uses the notebook's frame
f1 = Frame(n())
b1 = Button(f1, text="Button 1")
e1 = Entry(f1)
# pack your widgets before adding the frame 
# to the notebook (but not the frame itself)!
b1.pack(fill=BOTH, expand=1)
e1.pack(fill=BOTH, expand=1)

f2 = Frame(n())
# this button destroys the 1st screen radiobutton
b2 = Button(f2, text='Button 2', command=lambda:x1.destroy())
b3 = Button(f2, text='Beep 2', command=lambda:Tk.bell(a))
b2.pack(fill=BOTH, expand=1)
b3.pack(fill=BOTH, expand=1)

f3 = Frame(n())

# keeps the reference to the radiobutton (optional)
x1 = n.add_screen(f1, "Screen 1")
n.add_screen(f2, "Screen 2")
n.add_screen(f3, "dummy")

if __name__ == "__main__":
        a.mainloop()
