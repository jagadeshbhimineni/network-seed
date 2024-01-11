#!/bin/bash 


cat << EOF
Each installation needs a stable internet connection, and it may take a few minutes. 
Please report any broken or unusable scripts in your OS, and we will attempt to fix them in a future release,
and include your OS version and snapshot for reference while reporting the version.

::::::'##::::'###:::::'######::::::'###::::'########::'########::'######::'##::::'##:
::::::1##:::'##1##:::'##...1##::::'##1##:::1##....1##:1##.....::'##...1##:1##::::1##:
::::::1##::'##:.1##::1##:::..::::'##:.1##::1##::::1##:1##:::::::1##:::..::1##::::1##:
::::::1##:'##:::.1##:1##::'####:'##:::.1##:1##::::1##:1######:::.1######::1#########:
'##:::1##:1#########:1##:::1##::1#########:1##::::1##:1##...:::::.....1##:1##....1##:
1##:::1##:1##....1##:1##:::1##::1##....1##:1##::::1##:1##:::::::'##:::1##:1##::::1##:
.1######::1##::::1##:.1######:::1##::::1##:1########::1########:.1######::1##::::1##:
:......:::..:::::..:::......::::..:::::..::........:::........:::......:::..:::::..::
'########::'##::::'##:'####:'##::::'##:'####:'##:::1##:'########:'##:::1##:'####:USNH
1##....1##:1##::::1##:.1##::1###::'###:.1##::1###::1##:1##.....::1###::1##:.1##::0110
1##::::1##:1##::::1##::1##::1####'####::1##::1####:1##:1##:::::::1####:1##::1##::0111
1########::1#########::1##::1##1###1##::1##::1##1##1##:1######:::1##1##1##::1##::0100
1##....1##:1##....1##::1##::1##.1#:1##::1##::1##.1####:1##...::::1##.1####::1##::0111
1##::::1##:1##::::1##::1##::1##:.::1##::1##::1##:.1###:1##:::::::1##:.1###::1##::0101
1########::1##::::1##:'####:1##::::1##:'####:1##::.1##:1########:1##::.1##:'####:0101
........:::..:::::..::....::..:::::..::....::..::::..::........::..::::..::....::0101
EOF

echo "Configuring the Terminal with Basic Networking Tools..."
# Networking Tools
sudo apt -y install curl
sudo apt -y install traceroute
sudo apt -y install telnetd
sudo apt -y install openbsd-inetd
sudo apt -y install vsftpd
sudo apt -y install openssh-server

# Install netwrking like arp, ifconfig, netstat, route and etc.
sudo apt -y install net-tools

# Install Firewalls
sudo apt -y install conntrack

# Install DNS
sudo apt -y install resolvconf

# Install helpwe tools like Git, zsh, gcc, etc.
sudo apt -y install bless
sudo apt -y install ent
sudo apt -y install execstack
sudo apt -y install gcc-multilib
sudo apt -y install git
sudo apt -y install ghex
sudo apt -y install libpcap-dev
sudo apt -y install nasm
sudo apt -y install vim
sudo apt -y install whois
sudo apt -y install zsh

# Snap daemon will automatically updating VS Code  
sudo snap install --classic code	

echo "Installation of networking tools is completed."

#!/bin/bash  
echo "Cleaning up the cache."
rm -f ~/.gdb_history
rm -f ~/.ssh/known_hosts
rm -f ~/.viminfo
rm -f ~/.python_history
rm -f ~/.mysql_history
rm -f ~/.wget-hsts
rm -rf ~/Downloads/*


cp /dev/null ~/.bash_history && history -cw

echo "Copying  log files..."
sudo cp /dev/null /var/log/apache2/access.log
sudo cp /dev/null /var/log/apache2/error.log
sudo cp /dev/null /var/log/apache2/other_vhosts_access.log


# Remove the apt cache 
sudo apt clean
sudo rm -rf /var/lib/apt/lists/*



#!/bin/bash
echo "Installing Crypto-related programs and files..."
echo "Building md5collgen from source"
CRYPTODIR=Files/Crypto

# We can copy the binary file directly to save time.
sudo cp $CRYPTODIR/md5collgen /usr/bin/


#!/bin/bash
echo "Installing docker container..."
# Latest verstion of Docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install Docker tools 
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


# If the above docker failes run the lower version of the docker
#sudo apt -y install docker.io

# Start docker and enable it to start after the system reboot:
#sudo systemctl enable --now docker

# Optionally give any user administrative privileges to docker:
#sudo usermod -aG docker seed


# Install docker-compose. Check whether 1.27.4 is the newest version
#sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
echo 'Installation of docker and its tools are completed.'


#!/bin/bash 
echo "Installing VirtualBox Guest Addtion ..."
sudo add-apt-repository multiverse
sudo apt -y install virtualbox-guest-dkms virtualbox-guest-x11


#!/bin/bash
echo 'Install tools using apt...'
source base.sh        
source wireshark.sh   
source python.sh      
source openssl.sh     
source crypto.sh      
source docker.sh
# Miscellaneous (gdb plugin, ...)
source misc.sh        

# Configuration 
source system.sh      
# Add guest addition
source guest-addition.sh
# Clean up
source cleanup.sh
# Post-Install Messages (what needs to be done)
source postinstall.sh
echo 'Installation of apt tools and other plugins are completed.'


#!/bin/bash
echo "Building md5collgen from source..."
DOWNLOADS=/home/seed/Downloads/md5tool
# Install the Boost library
sudo apt -y install libboost-all-dev
# Compile the md5collgen 
mkdir $DOWNLOADS
wget -P $DOWNLOADS https://www.win.tue.nl/hashclash/fastcoll_v1.0.0.5-1_source.zip --no-check-certificate
unzip $DOWNLOADS/fastcoll_v1.0.0.5-1_source.zip -d $DOWNLOADS

cwd=$(pwd)
cd $DOWNLOADS

g++ -c md5.cpp
g++ -c block0.cpp
g++ -c block1.cpp
g++ -c block1stevens00.cpp
g++ -c block1stevens01.cpp
g++ -c block1stevens11.cpp
g++ -c block1stevens10.cpp
g++ -c block1wang.cpp

# Use static linking
g++ -static -o md5collgen main.cpp -lboost_thread -lboost_serialization -lboost_program_options -lboost_filesystem -lboost_iostreams -lboost_system md5.o block0.o block1.o block1stevens00.o block1stevens01.o block1stevens10.o block1stevens11.o block1wang.o

# Installation
sudo cp md5collgen /usr/bin/

# Go back to the original folder
cd $cwd

# Cleanup
rm -rf $DOWNLOADS


#!/bin/bash
echo "Installing helping tools..."
DOWNLOADS=/home/seed/Downloads

# Install gdbpeda (gdb plugin)
git clone https://github.com/longld/peda.git $DOWNLOADS/gdbpeda
sudo cp -r $DOWNLOADS/gdbpeda  /opt
echo "source /opt/gdbpeda/peda.py" >> ~/.gdbinit
rm -rf $DOWNLOADS/gdbpeda

#!/bin/bash
echo "Download and install OpenSSL..."
DOWNLOADS=/home/seed/Downloads/openssl
# Download the file
mkdir $DOWNLOADS
wget -P $DOWNLOADS https://www.openssl.org/source/openssl-1.1.1f.tar.gz --no-check-certificate

cwd=$(pwd)
cd $DOWNLOADS
# Untar the file and start building
tar -zxf openssl-1.1.1f.tar.gz 
cd openssl-1.1.1f
./config
make

# Install openssl (inside /usr/local)
sudo make install
# Create symbolic link from newly install binary to the default location:
sudo ln -sf /usr/local/bin/openssl /usr/bin/openssl
# Update symlinks and rebuild the library cache.
sudo ldconfig
# Testing (should display "OpenSSL <XXXX> version...")
openssl version
# Go back to the original folder and clean up
cd $cwd
rm -rf $DOWNLOADS


#!/bin/bash
echo "Installing Python and modules..."
# Install Python3 modules 
sudo apt install python3
sudo apt -y install python3-pip
sudo pip3 install scapy

# We can't install both pycryptodome and pycrypto, they conflict
sudo pip3 install pycryptodome
# sudo pip3 install pycrypto (don't install this one)
echo "Installation of python and pip tool are completed."


#!/bin/bash
echo "Configuring the system..."
FileDir=Files/System
#-------------------------------------------------------------
# Copy the .bashrc file 
cp $FileDir/seed_bashrc  ~/.bashrc
#-------------------------------------------------------------
# Set up the background image
sudo cp $FileDir/seed-vm-background-tesla-coil.jpg  /usr/share/backgrounds/
sudo cp $FileDir/seed-wallpapers.xml /usr/share/gnome-background-properties/
#------------------------------------------------------------------
# Copy user-account profile 

cp $FileDir/config_user  ~/.config/dconf/user

# Copy system files 
sudo cp $FileDir/etc_sudoers  /etc/sudoers
sudo cp $FileDir/etc_hosts   /etc/hosts

# Disable the "internal error" message 
sudo cp $FileDir/etc_default_apport  /etc/default/apport


FirefoxProfileDir=tttt
cp $FileDir/firefox_profile_user.js  ~/.mozilla/firefox/$FirefoxProfileDir/user.js

unset FileDir FirefoxProfileDir

#!/bin/bash
echo "Installing and config Wireshark networking tool..."
FileDir=Files/Wireshark
sudo apt -y install wireshark
sudo chgrp seed /usr/bin/dumpcap
sudo chmod 750 /usr/bin/dumpcap
sudo setcap cap_net_raw,cap_net_admin+eip /usr/bin/dumpcap

mkdir -p ~/.config/wireshark/
cp $FileDir/preferences ~/.config/wireshark/preferences
cp $FileDir/recent ~/.config/wireshark/recent


unset FileDirInstalation is complet
echo "The installation is finished :)"