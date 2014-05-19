// genrateCallingLibF.sci is a scilab file to create library function for a new components. It is developed for a scilab based circuit simulator. It is written by Yogesh Dilip Save (yogessave@gmail.com).  
// Copyright (C) 2012 Yogesh Dilip Save
// This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
// You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.


function generateCallingLibF(f_name)
fid = mopen('getlib.sci', 'w');
if (fid == -1)
  error("cannot open file for reading");
end
libName=f_name+".sci"; 
mfprintf(fid,'function I=func(voltage,parameter)\n');
mfprintf(fid,"\texec("'%s"',-1);\n",libName);
mfprintf(fid,'\tI=%s_func(voltage,parameter);\n',f_name);
mfprintf(fid,'endfunction\n\n');

mfprintf(fid,'function Gj=jacobian(voltage,parameter)\n');
mfprintf(fid,"\texec("'%s"',-1);\n",libName);
mfprintf(fid,'\tGj=%s_Jacobian(voltage,parameter);\n',f_name);
mfprintf(fid,'endfunction');
mclose(fid)
endfunction
