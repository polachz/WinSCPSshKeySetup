@echo off


REM Script to upload SSH key on the server
REM To allow SSH key based authentication 

if "%1" == "" goto usage

set WINSP_SSH_PARMS=%1

winscp.com /script=winscp_key_update.txt
goto end

:usage
echo "Usage of the script:"
echo "   ssh_key_upload [user[:password]@]<server>"

:end