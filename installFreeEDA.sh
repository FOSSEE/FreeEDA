#!/bin/bash
#
# installFreeEDA.sh is a part of FreeEDA.
# Original Author: Yogesh Dilip Save (yogessave@gmail.com)
# Copyright (C) 2012 Yogesh Dilip Save, FOSS Project, IIT Bombay.

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.  This program is
# distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
# for more details.  You should have received a copy of the GNU
# General Public License along with this program; if not, write to the
# Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
# MA 02111-1307, USA.

echo -n "Is your internet connection behind proxy? (y/n): "
read getProxy

if [ $getProxy == "y" -o $getProxy == "Y" ]
then
    echo -n 'Proxy Hostname :'
read proxyHostname

echo -n 'Proxy Port :'
read proxyPort

echo -n username@$proxyHostname:$proxyPort :
read username

echo -n 'Password :'
read -s passwd

unset http_proxy
unset https_proxy
unset HTTP_PROXY
unset HTTPS_PROXY
unset ftp_proxy
unset FTP_PROXY

export http_proxy=http://$username:$passwd@$proxyHostname:$proxyPort
export https_proxy=http://$username:$passwd@$proxyHostname:$proxyPort
export https_proxy=http://$username:$passwd@$proxyHostname:$proxyPort
export HTTP_PROXY=http://$username:$passwd@$proxyHostname:$proxyPort
export HTTPS_PROXY=http://$username:$passwd@$proxyHostname:$proxyPort
export ftp_proxy=http://$username:$passwd@$proxyHostname:$proxyPort
export FTP_PROXY=http://$username:$passwd@$proxyHostname:$proxyPort
"$@"
echo
	sudo apt-get install kicad ngspice python
elif [ $getProxy == "n" -o $getProxy == "N" ]
then
	sudo apt-get install kicad ngspice python
        if [ $? -ne 0 ] 
	then
        	echo -e "\n\n\nFreeEDA ERROR: Unable to install required packages. Please check your internet connection.\n\n"
                exit 0
	fi
else
     echo "Please select the right option"
     exit 0	
fi


function checkScilabVersion
{
  version=`$1 -version |grep scilab |cut -d '-' -f2`
  version=`echo $version | sed 's/\.//g'`
  if [ "$version" -ge "540" ]
  then
    echo "  scilab version 5.4 or above detected."
    return 0
  else
    return 1
  fi
}

function checkMetanet
{
  eval $1 -nw -f checkMetanet.sci
  RetVal=$?
  if [ $RetVal -ne 0 ]
  then
    echo "No Metanet graph library found"
    echo "Trying to install metanet library........" 
    #echo -n "Do you want to set proxy for internet connection(y/n): "
    #read setProxy

    #if [ $setProxy = 'y' -o $setProxy = 'Y' ]
    #then
    #  proxy
    #fi
    eval $1 -nw -f installMetanet.sci
    RetVal=$?
    if [ $RetVal -ne 0 ]
    then
        echo "  Unable to install Metanet "
        echo "  Please install metanet manually. "
        echo "  To install metanet use command atomInstall(\"metanet\")"
    fi 
  fi
}

echo "Checking python Modules......................"
sudo chmod 755 ./checkPythonModules.py
./checkPythonModules.py
RetVal=$?
[ $RetVal -eq 0 ] && echo "All python modules are available"
[ $RetVal -eq 1 ] && { echo "Some python modules are not available. Kindly install them and then re-run installFreeEDA.sh"; exit 1; }
[ $RetVal -ne 1 ] && [ $RetVal -ne 0 ] && { echo "Unable to check modules"; exit 1; } 
# added from here
echo -n "Do you have scilab 5.4 or above? (y/n) "
    read Answer
case $Answer in
y|Y)
echo "Checking scilab ......................"
command -v scilab >/dev/null 2>&1
RetVal=$?
if [ $RetVal -eq 0 ] 
then 
  		scilabPATH="/usr/bin/scilab"
  		echo "Found scilab."
  		echo  "Checking scilab version......................"
  		checkScilabVersion "$scilabPATH" 
  		RetVal=$?
 if [ $RetVal -eq 0 ]
 then
    		echo  "Checking Metanet ......................"
    		checkMetanet "$scilabPATH"
  else
    		echo -e " \e[1m Require scilab version 5.4 or above \e[0m"  
   		    		
      		echo -n "Please give path of scilab installation directory (e.g., $HOME/Downloads/scilab-5.4.0):"
      		read scilabInstallDir 
 if [ -z $scilabInstallDir ]
 then 
         	scilabInstallDir=$HOME/Downloads/scilab-5.4.0
 fi
      		echo "Checking scilab ......................"
      		command -v $scilabInstallDir/bin/scilab >/dev/null 2>&1
      		RetVal=$?
 if [ $RetVal -eq 0 ]
 then
       		 echo "Found scilab."
        	scilabPATH="$scilabInstallDir/bin/scilab"
        	echo  "Checking scilab version......................"
        	checkScilabVersion "$scilabInstallDir/bin/scilab" 
        	RetVal=$?
if [ $RetVal -eq 0 ]
then
     echo -e " FreeEDA installation proceeds with Scilab....\n"
          		echo  "Checking Metanet ......................"
          		checkMetanet "$scilabInstallDir/bin/scilab"
else
          echo -e " \e[1m Require scilab version 5.4 or above \e[0m"  
if [[ $linuxVersion == "x86_64" ]]
      then
        echo -e " \e[1m Please download scilab 5.4.0 for 64 bits (Linux) from http://www.scilab.org/products/scilab/download \e[0m"
      else
        echo -e " '\e[1m' Please download scilab 5.4.0 for 32 bits (Linux) from http://www.scilab.org/products/scilab/download '\e[0m'"
      fi
      echo " And re-run install_FreeEDA.sh "
      exit 1   
        fi
      else 
        echo -e " \e[1m Unable to find scilab5.4.0 or above in the specified location \e[0m"
        echo " Please re-run install_FreeEDA.sh and Give correct path"
        exit 1   
      fi
    fi
 else 
    echo -e " Scilab not found.."
    echo -n "Please give path of scilab installation directory (e.g., $HOME/Downloads/scilab5.4.0):"
    read scilabInstallDir 
    if [ -z $scilabInstallDir ]
    then 
       scilabInstallDir=$HOME/Downloads/scilab-5.4.0
    fi
    echo "Checking scilab ......................"
    command -v $scilabInstallDir/bin/scilab >/dev/null 2>&1
    RetVal=$?
    if [ $RetVal -eq 0 ]
    then
      echo "Found scilab."
      scilabPATH="$scilabInstallDir/bin/scilab"
      echo  "Checking scilab version......................"
      checkScilabVersion "$scilabInstallDir/bin/scilab" 
      RetVal=$?
      if [ $RetVal -eq 0 ]
      then
        echo -e " FreeEDA installation proceeds with Scilab....\n"
        echo  "Checking Metanet ......................"
        checkMetanet "$scilabInstallDir/bin/scilab"
      else
        echo -e " \e[1m Require scilab version 5.4 or above \e[0m" 
if [[ $linuxVersion == "x86_64" ]]
      then
        echo -e " \e[1m Please download scilab 5.4.0 for 64 bits (Linux) from http://www.scilab.org/products/scilab/download \e[0m"
      else
        echo -e " '\e[1m' Please download scilab 5.4.0 for 32 bits (Linux) from http://www.scilab.org/products/scilab/download '\e[0m'"
      fi
      echo " And re-run install_FreeEDA.sh "
      exit 1    
      fi
    else 
      echo -e " \e[1m Unable to find scilab5.4.0 or above in the specified location \e[0m"
      echo " Please re-run install_FreeEDA.sh and Give correct path"
      exit 1   
    fi
  fi


;;
n|N) echo "Installation proceeds without Scilab....."
;;
*) echo " Please select right option"
exit 1
;;
esac



echo -n "Please select installation directory (e.g., $HOME): "
read installDir 
if [ -z $installDir ]
then 
   installDir=$HOME
fi

if [ -d $installDir ]
then
  echo 'Directory found'
else
  echo 'Directory not found!'
  echo -n 'Do you want to create it?(y/n)'
  read response
  if [ $response = 'y' -o $response = 'Y' ]
  then
    if [ `mkdir -p $installDir` ]
    then 
      exit 1
    fi
  else
    echo 'Installation aborted'
    exit 1
  fi
fi
echo "Installation started..............."
backup_freeeda="$installDir/FreeEDA"
if [ -d "$backup_freeeda" ]
then
echo "Renaming your old FreeEDA folder to FreeEDA.backup"
mv -v $installDir/FreeEDA $installDir/FreeEDA.backup
fi
echo "Outof if loop"

#tar -zxvf FreeEDA.tar.gz -C $installDir
cp -rv FreeEDA $installDir

cp $installDir/FreeEDA/setPathInstall.py $installDir/FreeEDA/setPath.py 

echo "$installDir/FreeEDA/setPathInstall.py"
cat $installDir/FreeEDA/setPathInstall.py
echo "$installDir/FreeEDA/setPath.py"
cat $installDir/FreeEDA/setPath.py

cp $installDir/FreeEDA/setPathInstall.py $installDir/FreeEDA/forntEnd/setPath.py
sed -i 's@set_PATH_to_FreeEDA@"'$installDir'/FreeEDA"@g' $installDir/FreeEDA/setPath.py
sed -i 's@set_PATH_to_FreeEDA@"'$installDir'/FreeEDA"@g' $installDir/FreeEDA/modelEditor/setPath.py
cp $installDir/FreeEDA/setPath.py $installDir/FreeEDA/forntEnd/setPath.py 
cp $installDir/FreeEDA/setPath.py $installDir/FreeEDA/subcktEditor/setPath.py 
cp $installDir/FreeEDA/setPath.py $installDir/FreeEDA/modelEditor/setPath.py 
cp $installDir/FreeEDA/LPCSim/LPCSim/MainInstall.sci  $installDir/FreeEDA/LPCSim/LPCSim/Main.sci
sed -i 's@set_PATH_to_FreeEDA@"'$installDir'/FreeEDA"@g' $installDir/FreeEDA/LPCSim/LPCSim/Main.sci
chmod 755 $installDir/FreeEDA/analysisInserter/*.py
chmod 755 $installDir/FreeEDA/forntEnd/*.py
chmod 755 $installDir/FreeEDA/kicadtoNgspice/*.py
chmod 755 $installDir/FreeEDA/modelEditor/*.py
chmod 755 $installDir/FreeEDA/subcktEditor/*.py
ln -sf $scilabPATH $installDir/FreeEDA/bin/scilab54
sudo ln -sf $installDir/FreeEDA/forntEnd/freeeda.py /usr/bin/freeeda

sudo cp -v $installDir/FreeEDA/images/logo.png /usr/share/icons/freeeda.png

echo "Setting up desktop icon..."
cp -v freeeda.desktop $HOME/Desktop/

function import_kicad_lib() {                                                   
  # Copy FreeEDA libraries to kicad lib directory                               
  
  sudo cp -r FreeEDA/library/*.lib /usr/share/kicad/library/
  sudo cp -r FreeEDA/library/*.dcm /usr/share/kicad/library/
  
  # --------------------                                                      
  # Full path of 'kicad.pro file'[Verified for Ubuntu 12.04]                  
  KICAD_PRO="/usr/share/kicad/template/kicad.pro"
  KICAD_ORIGINAL="/usr/share/kicad/template/kicad.pro.original"                             
  # --------------------                                                      
  
  if [ -f "$KICAD_ORIGINAL" ]
  then 
    echo "kicad.pro original file found..."
    sudo cp -rv ${KICAD_ORIGINAL} ${KICAD_PRO}
  else 
    echo "Making copy of original file"
    sudo cp -rv ${KICAD_PRO}{,.original}                                             
  fi
  # Get number of libs in FreeEDA/Library directory                             
  kicadlibfiles_num=$(cat ${KICAD_PRO} | awk "/\[eeschema\/libraries\]/,/\[cvpcb\]/" | grep -i "LibName" | wc -l)
  
  # Remove string '.lib' as 'kicad.pro' does not store library name           
  # with '.lib' as a suffix                                                   
  libfiles=$(ls -1 FreeEDA/library | grep ".lib")      
  
  # Start the counter from number of libs already available                   
  COUNTER=${kicadlibfiles_num}                                                
  
  # Make a copy of original file by the extension .original                   
  #sudo cp -rv ${KICAD_PRO}{,.original}                                             
  
  #Make copy of Original file with write permission
  sudo cp -rv ${KICAD_PRO} $HOME/kicad_pro 
  sudo chmod 777 $HOME/kicad_pro 
  
  # Write lib in a loop                                                       
  for i in ${libfiles}                                                        
  do                                                                          
    COUNTER=$((COUNTER + 1))                                                      
    FILENAME=$(echo ${i} | sed -e "s/.lib//g" | sed -e "s/^/LibName${COUNTER}=/") 
    echo $FILENAME                                                               
    echo "LibName$((COUNTER - 1))"
    sed -i -e '/LibName'"$((COUNTER - 1))"'/a '"${FILENAME}"'' $HOME/kicad_pro  
           
  done 
  
  #Copying file again to its original location
  sudo cp -rv $HOME/kicad_pro ${KICAD_PRO} 
  sudo chmod 644 ${KICAD_PRO} 
  #Remove temp kicad_pro file from HOME.
  rm $HOME/kicad_pro 
}                                                                               

import_kicad_lib                 

echo "Installation completed"




