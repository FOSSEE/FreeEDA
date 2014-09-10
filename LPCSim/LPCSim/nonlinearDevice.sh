#!/bin/bash
# nonlinearDevice.sh is a bash script to create linearized model figures. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
# Copyright (C) 2012 Yogesh Dilip Save
# This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

cp diode_Dref.pstex diode_D$1.pstex
cp diode_Dref.pstex_t diode_D$1.pstex_t
sed -i 's/ref/'${1}'/g;s/dnumber/'${1}'/g' diode_D$1.pstex_t 
#sed -i 's/dnumber/'${1}'/g' diode_$1.pstex_t
./latfont diode_D$1 
