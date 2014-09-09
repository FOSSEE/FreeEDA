// mos.sci is a scilab file to read MOSFET parameters. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

function [Vt,beta1]=getMosPara(parameter)
  W=parameter(2);
  L=parameter(3);
  Vt=parameter(4);
  Cox=parameter(5);
  if(parameter(1)=='P')
    u=0.4;
  else
    u=0.8;
  end
  beta1=W/L*Cox*u;
endfunction
