# WinSCPSshKeySetup
Automaton Script to Configure Remote SSH Server to Accept SSH Key For Authentication

Common task provided on each new server system is to configure SSH access by SSH public/private keypair to increase security. This set of scripts automates the task. 
On Windows system the script uses WinSCP as a SSH client and a file transfer agent. 
Script doesn't work on Linux host yet. But Linux support will be provided soon.

##How to use the script:

1. Checkout the project to locla folder
2. Add your public key to the the **ssh_pub_key** file
3. run the ssh_key_upload.bat to congigure remote dystem automatically.

`ssh_key_upload [user[:password]@]<server>`

If you don't provide user name and password, script will ask you for that.

That's all. Enjoy the script
