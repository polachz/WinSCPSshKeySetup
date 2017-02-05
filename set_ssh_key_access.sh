#!/bin/sh

SSH_KEY='ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGls9i+zbftGBW7KcNQyVYHmnwhkPT0H57vRjs6ewJhS 57:77:f3:ca:b8:8d:5a:3c:ad:c4:a7:48:0d:aa:08:e5 just-upload-key'

MY_USER=$(whoami)

SSH_KEYFILE_DIR="/home/$MY_USER/.ssh"
SSH_KEYFILE_PATH="$SSH_KEYFILE_DIR/authorized_keys"

echo "$SSH_KEYFILE_DIR"
echo "$SSH_KEYFILE_PATH"

# check if we have .ssh dir
if [ ! -d "$SSH_KEYFILE_DIR" ]; then
   mkdir "$SSH_KEYFILE_DIR"
fi
#check if file exist
if [ ! -f "$SSH_KEYFILE_PATH" ]; then
   #new file - just create and copy the key here
   echo "$SSH_KEY" > "$SSH_KEYFILE_PATH"
else
   #check if the key is not in the file
   if grep  -q "$SSH_KEY" $SSH_KEYFILE_PATH 2> /dev/null; then
      echo 'Key already exists in authorized_keys'
   else
      #append the key to the file
      echo "$SSH_KEY" >> "$SSH_KEYFILE_PATH"
   fi
fi
# and finally restrict rights to the file and dir
chown "$MY_USER:$MY_USER" $SSH_KEYFILE_DIR
chown "$MY_USER:$MY_USER" $SSH_KEYFILE_PATH
chmod 700 $SSH_KEYFILE_DIR 
chmod 600 $SSH_KEYFILE_PATH

