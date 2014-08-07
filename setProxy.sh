#!/bin/bash

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

