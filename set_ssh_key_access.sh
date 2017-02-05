#!/bin/sh

#title           :set_ssh_key_access.sh
#description     :created ssh authorized_keys file  
#author          :zdenek polach ( https://github.com/polachz )
#date            :05.02.2017
#version         :0.1
#usage           :invoke it remotely or locally
#notes           :You have to create ssh_pub_key file with the key
#                :or you have to define the SSH_KEY variable here
#==============================================================================
#
# MIT License
#
# Copyright (c) 2017 Zdenek Polach

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#==============================================================================

# Uncomment the line with SSH_KEY vvariable and set to the variable the public  
# part of your SSH key if you don't want to use the ssh_pub_key file.  
# !!But remember that oo use the ssh_pub_key file is preferred way !!
# This variable is used only if the ssh_pub_key file doesn't exist

#SSH_KEY='<set a key string here>'

MY_USER=$(whoami)

SSH_KEYFILE_DIR="/home/$MY_USER/.ssh"
SSH_KEYFILE_PATH="$SSH_KEYFILE_DIR/authorized_keys"
SSH_KEY_SOURCE_FILE="/home/$MY_USER/ssh_pub_key"

if [ -f "$SSH_KEY_SOURCE_FILE" ]; then
   SSH_KEY_FINAL=$(grep -o '^[^#]*' "$SSH_KEY_SOURCE_FILE" 2>&1)
else
   if [ ! -z "$SSH_KEY" ]; then
      SSH_KEY_FINAL=$SSH_KEY
   fi
fi

if [  -z "$SSH_KEY_FINAL" ]; then
      echo
      echo "!!!FATAL ERROR !!!"
      echo "No Key is specified, cannot continue!!"
      echo "Please create ssh_pub_key file or set the SSH_KEY variable"
      echo
      exit 1
fi
# check if we have .ssh dir
if [ ! -d "$SSH_KEYFILE_DIR" ]; then
   mkdir "$SSH_KEYFILE_DIR"
fi
#check if file exist
if [ ! -f "$SSH_KEYFILE_PATH" ]; then
   #new file - just create and copy the key here
   echo "$SSH_KEY_FINAL" > "$SSH_KEYFILE_PATH"
else
   #check if the key is not in the file
   if grep  -q "$SSH_KEY" $SSH_KEYFILE_PATH 2> /dev/null; then
      echo 'Key already exists in authorized_keys'
   else
      #append the key to the file
      echo "$SSH_KEY_FINAL" >> "$SSH_KEYFILE_PATH"
   fi
fi
# and finally restrict rights to the file and dir
chown "$MY_USER:$MY_USER" $SSH_KEYFILE_DIR
chown "$MY_USER:$MY_USER" $SSH_KEYFILE_PATH
chmod 700 $SSH_KEYFILE_DIR 
chmod 600 $SSH_KEYFILE_PATH

