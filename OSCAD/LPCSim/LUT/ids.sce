// Wrapper function for calling C language routine ids_c from SciLab
function Id = ids(Vds, Vgs, Vbs)
l=link("/NFS1/yogesh/project/MNA/LUT/libids.so", "ids_c", "c")
Id=0.0;
sizeId=size(Id);
Id=fort("ids_c",Vds, 1,"d",Vgs, 2, "d", Vbs, 3, "d", Id, 4, "d", "out",sizeId, 4, "d");
ulink(l);
endfunction
