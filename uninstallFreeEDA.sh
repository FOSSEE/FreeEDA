#!/bin/bash  


#This script will uninstall all the module required for FreeEDA.

while read line
do
    echo "FreeEDA was installed at $line"
    # Removing FreeEDA directory
    echo "Removing FreeEDA directory from $line"
    rm -rf $line/FreeEDA

    if [ "$?" == 0 ];then
        echo "FreeEDA directory removed sucessfully"
    else
        echo "There is come problem in removing FreeEDA directory"
        echo "Please try to remove it manually from location $line"
    fi

done < installed_location



#Removing ngspice and kicad from synaptic

echo -n "This will uninstall ngspice and kicad. Are you sure to uninstall it (y/n): "
read answer

if [ $answer == "y" -o $answer == "Y" ];then
       sudo  apt-get purge kicad ngspice
else
    echo "Uninstallation script completed without uninstalling kicad and ngspice" 
    exit 0;
fi

echo "Uninstallation script completed sucessfully"

