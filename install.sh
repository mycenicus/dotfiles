#!/bin/bash

set -e

# Make sure script is not run as sudo
if [ "$EUID" -eq 0 ]; then
   echo "Run as normal user, not with sudo."
   exit 1
fi

show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --misc      Install miscellaneous programs (firefox, mpv, image viewer etc.)"
    echo "  --battery   Enable low battery notification"
    echo "  --squat     Enable squat reminder"
    echo "  --all       Include --misc, --battery, --squat"
    echo "  --stow      Add stow support (doesn't copy dotfiles to ~)"
    echo "  -h, --help  Show this help message"
    exit 0
}

INSTALL_MISC=false
ENABLE_BATTERY=false
ENABLE_SQUAT=false
STOW=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --misc) INSTALL_MISC=true ;;
        --battery) ENABLE_BATTERY=true ;;
        --squat) ENABLE_SQUAT=true ;;
        --all)
            INSTALL_MISC=true
            ENABLE_BATTERY=true
            ENABLE_SQUAT=true
            ;;
        --stow) STOW=true ;;
        -h|--help) show_help ;;
        *)
            echo "Unknown option: $1"
            show_help
            ;;
    esac
    shift
done

# Progress bar
step() {
   echo -e "\n\033[1;34m==> $1...\033[0m"
}

# Update pacman mirrors and system
step "Updating system"
sudo pacman -Syyu --noconfirm

# Install essentials
# Install gvim if you want vim to support clipboard
step "Installing system packages"
sudo pacman -S --needed --noconfirm \
   adwaita-fonts \
   otf-font-awesome \
   ttf-cascadia-mono-nerd \
   ttf-jetbrains-mono-nerd \
   noto-fonts-emoji \
   papirus-icon-theme \
   materia-gtk-theme \
   wl-clipboard \
   libnotify \
   power-profiles-daemon \
   brightnessctl \
   pamixer \
   pavucontrol \
   playerctl \
   blueman \
   networkmanager \
   upower \
   hyprlock \
   hyprpolkitagent \
   hypridle \
   hyprpaper \
   swaync \
   waybar \
   rofi \
   nautilus \
   zsh \
   git \
   fzf

if [[ "$INSTALL_MISC" == true ]]; then
   sudo pacman -S --needed --noconfirm \
      firefox \
      file-roller \
      loupe \
      evince \
      mpv
fi

step "Installing yay (AUR helper)"
if ! command -v yay &>/dev/null; then
   sudo pacman -S --needed --noconfirm git base-devel 
   git clone https://aur.archlinux.org/yay.git 
   cd yay
   makepkg -si --noconfirm
   cd - && sudo rm -r ./yay/
fi

step "Installing yay packages"
yay -S --noconfirm --needed \
   matugen-bin \
   wlogout

# Remove dolphin with all the KDE dependencies and wofi (both installed via archinstall)
step "Removing KDE, Wofi packages"
sudo pacman -Rns --noconfirm dolphin wofi || true

step "Installing zgen"
if [ ! -d "${HOME}/.zgen" ]; then
  git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
else
  echo "${HOME}/.zgen already exists -- skipping"
fi

if [[ "${STOW}" == false ]]; then
   step "Copying dotfiles"
   mkdir -p "${HOME}/.config"
   cp -rf .vimrc "${HOME}/"
   cp -rf .zshrc "${HOME}/"
   cp -rf .config/* "${HOME}/.config/"
   cp -rf .icons/* "${HOME}"
else
   echo "Skipping dotfiles copy."
fi

step "Setting GTK theme"
echo "Setting Materia GTK theme"
gsettings set org.gnome.desktop.interface gtk-theme "Materia-light-compact"
echo "Setting Papirus icon theme"
gsettings set org.gnome.desktop.interface icon-theme "Papirus"
echo "Setting Umbrella cursor"
gsettings set org.gnome.desktop.interface cursor-theme "umbrella"
echo "Setting font antialiasing"
gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing "rgba"
gsettings set org.gnome.settings-daemon.plugins.xsettings hinting "slight"

step "Setting Zsh as default shell"
sudo chsh -s "$(which zsh)" "$USER"

if [[ "$ENABLE_BATTERY" == true || "$ENABLE_SQUAT" == true ]]; then
   step "Enabling timers"
   systemctl --user daemon-reload
      if [[ "$ENABLE_BATTERY" == true ]]; then
         echo "Enabling low battery notifier"
         systemctl --user enable --now .config/systemd/user/battery-notify.timer
      fi
      if [[ "$ENABLE_SQUAT" == true ]]; then
         echo "Enabling squat reminder"
         systemctl --user enable --now .config/systemd/user/squat-reminder.timer
      fi
fi

echo -e "\n✅ \033[1;32mInstallation complete!\e[0m"
echo -e "\e[1mNow install your wallpaper and then run:\e[0m"
echo -e "\n    \e[1;36m matugen image <PATH-TO-WALLPAPER>\e[0m"
echo -e "\nThis will generate and apply your theme based on the wallpaper."
echo -e "Set your wallpaper in hyprpaper \033[1;34m(~/.config/hypr/hyprpaper.conf)\033[0m"

if [[ "${STOW}" == true ]]; then
   echo -e "Run \e[1;36mstow -t ~ .\e[0m to create symlinks"
fi
