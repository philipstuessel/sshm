#!/bin/zsh
alias sm="sshm"

sshm() {
    if [[ "$1" == "v" || "$1" == "-v" ]]
    echo -e "${BRED}SSH Manager${NC}"
    echo -e "${BOLD}v.0.1.0${NC}"
    echo -e "${YELLOW}JAP plugin${NC}"
}