#!/bin/zsh
alias sm="sshm"
SERVER_LIST="${JAP_FOLDER}plugins/packages/sshm/config/server.json"
sshm() {
    if [[ "$1" == "v" || "$1" == "-v" ]]; then
    echo -e "${BRED}SSH Manager${NC}"
    echo -e "${BOLD}v.0.1.1${NC}"
    echo -e "${YELLOW}JAP plugin${NC}"
    return 0
    elif [[ "$1" == "add" ]];then
        name="$2"
        user="$3"
        server="$4"
        line="${user}@${server}"
        jq --arg key "$name" --arg val "$line" '. += { ($key): $val }' $SERVER_LIST > temp && mv temp $SERVER_LIST
        if [[ $? == 0 ]]; then
            echo -e "${BGREEN}${name}${NC}${GREEN} '${line}' add in your server list${NC}"
        else
            echo -e "${BRED}ERROR${NC}"
        fi
    elif [[ "$1" == "l" || "$1" == "list" ]];then
        jq -r '. | to_entries[] | "\(.key) \(.value)"' $SERVER_LIST | while IFS= read -r entry; do
            echo $entry
        done
    elif [[ "$1" == "r" || "$1" == "remove" ]];then 
        jq "del(.$2)" $SERVER_LIST > temp.json && mv temp.json $SERVER_LIST
        if [[ $? == 0 ]]; then
            echo -e "🗑️  The SSH connection '$2' was deleted from the server list"
        else
            echo -e "${BRED}An error occurred while deleting from the SSH connection${NC}"
        fi
    else
        if [[ ! "$1" == "" ]];then
            line=$(jq ".$1" $SERVER_LIST | tr -d '"')
            if [[ ! $line == null ]]; then
                echo -e "🔌 ${BBLUE}SSHM connect to the server '$line'${NC}"
                ssh $line
                if [[ ! $? == 0 ]]; then
                    echo -e "🔌 ${BRED}An error occurred while connecting to '$line'${NC}"
                fi
            else
                echo -e "${BRED}'$1' is not on the server list ${NC}";
            fi
        fi
    fi
}