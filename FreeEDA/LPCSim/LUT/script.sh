g++ -c -m32 -fPIC ids.cpp -o ids.o
g++ -m32 -shared -o libids.so  ids.o
scilab32 -f ids.sce


