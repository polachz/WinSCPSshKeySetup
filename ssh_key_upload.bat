@echo off

REM title           :ssh_key_upload.bat
REM description     :configures SSH key access on the remote system  
REM author          :zdenek polach ( https://github.com/polachz )
REM date            :05.02.2017
REM version         :0.1
REM usage           :ssh_key_upload [user[:password]@]<server>"

Rem -------------------------------------------------------------------------

REM MIT license - see the set_ssh_key_access.sh file

REM -------------------------------------------------------------------------

REM Script to automate upload of the SSH key on the server
REM The key must be defined in the ssh_pub_key file
REM Alternative (but not preferred) way to specify the key
REM is to set the SSH_KEY variable in the set_ssh_key_access.sh file

REM This script uses WinSCP to upload appropriate files to the remote
Rem And invoke configuration scripts 

if "%1" == "" goto usage

set WINSP_SSH_PARMS=%1

winscp.com /script=winscp_key_update.txt
goto end

:usage
echo "Usage of the script:"
echo "   ssh_key_upload [user[:password]@]<server>"

:end