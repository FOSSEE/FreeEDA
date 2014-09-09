// waveform.sci is a scilab file to read source parameters. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

function value=sine(param,t)
   pi=3.14;
   value=param(3)*sin(2*pi*param(4)*t);
endfunction

function value=pulse(param,t)
   v1=param(2);  // Initial value
   v2=param(3);  // Pulsed value
   td=param(4);  // Delay time
   tr=param(5);  // Rise time
   tf=param(6);  // Fall time
   pw=param(7);  // Pulse width
   per=param(8); // Pulse period
   while(t>per)
     t=t-per;
   end
   if(v1>v2)
     tr_back=tr;
     tr=tf;
     tf=tr_back;
   end
   if(t<td)
     value=v1;
   elseif(t<td+tr)
     va=v1;   ta=td;   
     vb=v2;   tb=td+tr;
     value=(vb-va)/(tb-ta)*(t-ta)+va;
   elseif(t<td+tr+pw)
     value=v2;      
   elseif(t<td+tr+pw+tf)
     va=v2;   ta=td+tr+pw;   
     vb=v1;   tb=td+tr+pw+tf;
     value=(vb-va)/(tb-ta)*(t-ta)+va;
   else 
     value=v1;
   end
endfunction
