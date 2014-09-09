function Index=findIndex(Index,searchList)
  for i=1:1:length(searchList)
    if(searchList(i)==Index)
       Index=i;  
       return;
    end 		    	
  end
  Index=0;
endfunction
