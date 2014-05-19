#!/bin/bash

# installOSCAD.sh is a part of OSCAD.
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
        	echo -e "\n\n\nOSCAD ERROR: Unable to install required packages. Please check your internet connection.\n\n"
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
[ $RetVal -eq 1 ] && { echo "Some python modules are not available. Kindly install them and then re-run installOSCAD.sh"; exit 1; }
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
     echo -e " Oscad installation proceeds with Scilab....\n"
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
      echo " And re-run install_OSCAD.sh "
      exit 1   
        fi
      else 
        echo -e " \e[1m Unable to find scilab5.4.0 or above in the specified location \e[0m"
        echo " Please re-run install_OSCAD.sh and Give correct path"
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
        echo -e " Oscad installation proceeds with Scilab....\n"
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
      echo " And re-run install_OSCAD.sh "
      exit 1    
      fi
    else 
      echo -e " \e[1m Unable to find scilab5.4.0 or above in the specified location \e[0m"
      echo " Please re-run install_OSCAD.sh and Give correct path"
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

#tar -zxvf OSCAD.tar.gz -C $installDir
cp -rv OSCAD $installDir

cp $installDir/OSCAD/setPathInstall.py $installDir/OSCAD/setPath.py 

echo "$installDir/OSCAD/setPathInstall.py"
cat $installDir/OSCAD/setPathInstall.py
echo "$installDir/OSCAD/setPath.py"
cat $installDir/OSCAD/setPath.py

cp $installDir/OSCAD/setPathInstall.py $installDir/OSCAD/forntEnd/setPath.py
sed -i 's@set_PATH_to_OSCAD@"'$installDir'/OSCAD"@g' $installDir/OSCAD/setPath.py
sed -i 's@set_PATH_to_OSCAD@"'$installDir'/OSCAD"@g' $installDir/OSCAD/modelEditor/setPath.py
cp $installDir/OSCAD/setPath.py $installDir/OSCAD/forntEnd/setPath.py 
cp $installDir/OSCAD/setPath.py $installDir/OSCAD/subcktEditor/setPath.py 
cp $installDir/OSCAD/setPath.py $installDir/OSCAD/modelEditor/setPath.py 
cp $installDir/OSCAD/LPCSim/LPCSim/MainInstall.sci  $installDir/OSCAD/LPCSim/LPCSim/Main.sci
sed -i 's@set_PATH_to_OSCAD@"'$installDir'/OSCAD"@g' $installDir/OSCAD/LPCSim/LPCSim/Main.sci
chmod 755 $installDir/OSCAD/analysisInserter/*.py
chmod 755 $installDir/OSCAD/forntEnd/*.py
chmod 755 $installDir/OSCAD/kicadtoNgspice/*.py
chmod 755 $installDir/OSCAD/modelEditor/*.py
chmod 755 $installDir/OSCAD/subcktEditor/*.py
ln -sf $scilabPATH $installDir/OSCAD/bin/scilab54
sudo ln -sf $installDir/OSCAD/forntEnd/oscad.py /usr/bin/oscad

sudo cp -v $installDir/OSCAD/images/logo.png /usr/share/icons/oscad.png

echo "Setting up desktop icon..."
cp -v oscad.desktop $HOME/Desktop/

echo "Installation completed"




