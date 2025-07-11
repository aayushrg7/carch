#!/usr/bin/env bash

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

print_message() {
    local color="$1"
    shift
    echo -e "${color}$*${NC}"
}

clear

if ! command -v fzf &> /dev/null; then
    echo -e "${RED}${BOLD}Error: fzf is not installed${NC}"
    echo -e "${YELLOW}Please install fzf before running this script:${NC}"
    echo -e "${CYAN}  • Fedora: ${NC}sudo dnf install fzf"
    echo -e "${CYAN}  • Arch Linux: ${NC}sudo pacman -S fzf"
    exit 1
fi

if ! command -v dunst &> /dev/null; then
    print_message "${TEAL}" "Dunst not found. Installing..."
    if command -v pacman &> /dev/null; then
        sudo pacman -Sy --noconfirm dunst || {
                                               print_message "$RED" "Failed to install Dunst. Exiting..."
                                                                                                           exit 1
        }
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y dunst || {
                                       print_message "$RED" "Failed to install Dunst. Exiting..."
                                                                                                   exit 1
        }
    else
        print_message "$RED" "Unsupported package manager. Install Dunst manually."
        exit 1
    fi
else
    print_message "$GREEN" "Dunst is already installed."
fi

print_message "${TEAL}" "Installing papirus-icon-theme..."
if command -v pacman &> /dev/null; then
    pacman -Qi papirus-icon-theme &> /dev/null || sudo pacman -Sy --noconfirm papirus-icon-theme
elif command -v dnf &> /dev/null; then
    rpm -q papirus-icon-theme &> /dev/null || sudo dnf install -y papirus-icon-theme
fi

DUNST_DIR="$HOME/.config/dunst"
DUNST_FILE="$DUNST_DIR/dunstrc"

if [[ -d "$DUNST_DIR" ]]; then
    print_message "${TEAL}" "Backing up existing Dunst directory..."
    mv "$DUNST_DIR" "${DUNST_DIR}.bak" || {
                                            print_message "$RED" "Failed to backup Dunst directory."
                                                                                                      exit 1
    }
    print_message "$GREEN" "Backup created: ${DUNST_DIR}.bak"
fi

mkdir -p "$DUNST_DIR" || {
                           print_message "$RED" "Failed to create ~/.config/dunst directory."
                                                                                               exit 1
}
print_message "$GREEN" "Created ~/.config/dunst directory."

DUNST_URL="https://raw.githubusercontent.com/harilvfs/dwm/refs/heads/main/config/dunst/dunstrc"
DUNST_PATH="$DUNST_FILE"

print_message "${TEAL}" "Downloading Dunstrc..."

spin='-\|/'
i=0

( while true; do
    printf "\r[%c] Downloading..." "${spin:i++%${#spin}}"
    sleep 0.1
done ) &
SPIN_PID=$!

if curl -fsSL "$DUNST_URL" -o "$DUNST_PATH"; then
    kill $SPIN_PID
    printf "\r[✔] Download complete!      \n"
    print_message "$GREEN" "Dunstrc successfully downloaded to $DUNST_PATH"
else
    kill $SPIN_PID
    printf "\r[✖] Download failed!      \n"
    print_message "$RED" "Failed to download Dunstrc. Exiting..."
    exit 1
fi

print_message "$GREEN" "Dunst setup completed successfully!"
