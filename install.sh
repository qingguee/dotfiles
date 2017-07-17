#Install shell 

#This script will setup envirment on Ubuntu16.04
#Several SW will be installed, list as below:
#VIM,Spacevim,Git,Tmux

echo "Below SW pakcage is going to be installed:"
echo "  Build VIM8 form source code."
echo "  Spacevim"
echo "  GIT"
echo "  Tmux"

echo "Do you agree to proceed? (yes/no)"

read line
if [ "$line" != "yes" ];then
     exit 2
fi
echo "Install VIM8 dependence packages"
sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
    libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev \
    libx11-dev libxpm-dev libxt-dev python-dev python3-dev \
    ruby-dev lua5.1 lua5.1- dev libperl-dev git curl

echo "Clone VIM8 source code to ~/vim8"
mkdir -p ~/github
git clone https://github.com/vim/vim.git  ~/github/vim8  
cd ~/github/vim8/src

echo "Configure with +Python3"
./configure --with-features=huge \
         --enable-multibyte \
         --enable-rubyinterp=yes \
         --enable-python3interp=yes \
         --with-python-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
         --enable-perlinterp=yes \
         --enable-luainterp=yes \
         --enable-cscope --prefix=/usr \
         --enable-fail-if-missing
sudo make install
vim --version|grep python3
if [ "vim --version|grep python3|wc -l" != "1" ];then
	echo "build VIM8 with python3 failed."
	exit 2
fi


echo "Install Spacevim"
curl -sLf https://spacevim.org/install.sh | bash

echo "Install Powerline font"
cd ~/github
# clone
git clone https://github.com/powerline/fonts.git
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
echo "Please open your terminal and set Powerline as your custom font."


