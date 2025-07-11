#!/usr/bin/env bash

clear

source "$(dirname "$0")/../colors.sh" > /dev/null 2>&1

FZF_COMMON="--layout=reverse \
            --border=bold \
            --border=rounded \
            --margin=5% \
            --color=dark \
            --info=inline \
            --header-first \
            --bind change:top"

fzf_confirm() {
    local prompt="$1"
    local options=("Yes" "No")
    local selected=$(printf "%s\n" "${options[@]}" | fzf ${FZF_COMMON} \
                                                     --height=40% \
                                                     --prompt="$prompt " \
                                                     --header="Confirm" \
                                                     --pointer="➤" \
                                                     --color='fg:white,fg+:green,bg+:black,pointer:green')

    if [[ "$selected" == "Yes" ]]; then
        return 0
    else
        return 1
    fi
}

if ! command -v fzf &> /dev/null || ! command -v git &> /dev/null || ! command -v curl &> /dev/null || ! command -v wget &> /dev/null; then

    echo -e "${RED}${BOLD}Error: Required command(s) not found${NC}"

    if ! command -v fzf &> /dev/null; then
        echo -e "${YELLOW} fzf is not installed.${NC}"
        echo -e "${CYAN} • Fedora: ${NC}sudo dnf install fzf"
        echo -e "${CYAN} • Arch Linux: ${NC}sudo pacman -S fzf"
    fi

    if ! command -v git &> /dev/null; then
        echo -e "${YELLOW} git is not installed.${NC}"
        echo -e "${CYAN} • Fedora: ${NC}sudo dnf install git"
        echo -e "${CYAN} • Arch Linux: ${NC}sudo pacman -S git"
    fi

    if ! command -v curl &> /dev/null; then
        echo -e "${YELLOW} curl is not installed.${NC}"
        echo -e "${CYAN} • Fedora: ${NC}sudo dnf install curl"
        echo -e "${CYAN} • Arch Linux: ${NC}sudo pacman -S curl"
    fi

    if ! command -v wget &> /dev/null; then
        echo -e "${YELLOW} wget is not installed.${NC}"
        echo -e "${CYAN} • Fedora: ${NC}sudo dnf install wget"
        echo -e "${CYAN} • Arch Linux: ${NC}sudo pacman -S wget"
    fi

    exit 1
fi

clear

if ! command -v tmux &> /dev/null; then
    echo -e "${YELLOW}Tmux is not installed. Installing...${NC}"

    if command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm tmux
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y tmux
    fi
fi

config_dir="$HOME/.config/tmux"
backup_dir="$HOME/.config/tmux.bak"

if [[ -d "$config_dir" ]]; then
    echo -e "${YELLOW}Existing tmux configuration detected.${NC}"
    if fzf_confirm "Do you want to backup the existing configuration?"; then
        if [[ -d "$backup_dir" ]]; then
            echo -e "${YELLOW}Backup already exists.${NC}"
            if fzf_confirm "Do you want to overwrite the backup?"; then
                rm -rf "$backup_dir"
            else
                echo -e "${RED}Exiting to prevent data loss.${NC}"
                exit 0
            fi
        fi
        mv "$config_dir" "$backup_dir"
    else
        echo -e "${RED}Exiting to avoid overwriting existing config.${NC}"
        exit 0
    fi
fi

tpm_dir="$HOME/.tmux/plugins/tpm"

if [[ -d "$tpm_dir" ]]; then
    echo -e "${YELLOW}TPM is already installed.${NC}"
    if fzf_confirm "Do you want to overwrite TPM?"; then
        rm -rf "$tpm_dir"
    else
        echo -e "${RED}Skipping TPM installation.${NC}"
    fi
fi

echo -e "${GREEN}Cloning TPM...${NC}"
git clone https://github.com/tmux-plugins/tpm "$tpm_dir"

mkdir -p "$config_dir"

config_url="https://raw.githubusercontent.com/harilvfs/dwm/refs/heads/main/config/tmux/tmux.conf"
echo -e "${GREEN}Downloading tmux configuration...${NC}"
wget -O "$config_dir/tmux.conf" "$config_url"

plugin_script_dir="$tpm_dir/scripts"

if [[ -d "$plugin_script_dir" ]]; then
    echo -e "${GREEN}Installing tmux plugins...${NC}"
    cd "$plugin_script_dir" || exit
    chmod +x install_plugins.sh
    ./install_plugins.sh

    echo -e "${GREEN}Updating tmux plugins...${NC}"
    chmod +x update_plugins.sh
    ./update_plugins.sh
else
    echo -e "${RED}TPM scripts not found. Skipping plugin installation.${NC}"
fi

echo -e "${GREEN}Tmux setup complete!${NC}"
