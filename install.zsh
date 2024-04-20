source ~/.zshrc
name="sshm"
folder="${JAP_FOLDER}plugins/packages/${name}/"
folder_config="${folder}config/"
fetch2 $folder https://raw.githubusercontent.com/philipstuessel/sshm/main/sshm.zsh
fetch2 $folder_config https://raw.githubusercontent.com/philipstuessel/sshm/main/config/server.json
echo "--SSHM is installed--"