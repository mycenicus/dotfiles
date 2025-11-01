#!/bin/bash

set -e

# Make sure script is not run as sudo
if [ "$EUID" -eq 0]; then
   echo "Run as normal user, not with sudo."
   exit 1
fi

# Progress bar
step() {
   echo -e "\n\033[1;34m==> $1...\033[0m"
}

# Update pacman mirrors and system
step "Updating system"
sudo pacman -Syyu --noconfirm

# Install essentials. Doesn't include firefox
# Install gvim if you want vim to support clipboard
step "Installing system packages"
sudo pacman -S --needed --noconfirm \
   adwaita-fonts \
   ttf-cascadia-mono-nerd \
   ttf-jetbrains-mono-nerd \
   noto-fonts-emoji \
   wl-clipboard \
   libnotify \
   power-profiles-daemon \
   brightnessctl \
   pamixer \
   playerctl \
   blueman \
   networkmanager \
   upower \
   hyprlock \
   hyprpolkitagent \
   hypridle \
   swaync \
   waybar \
   rofi \
   nautilus \
   zsh \
   git \
   fzf

step "Installing yay (AUR helper)"
if ! command -v yay &>/dev/null; then
   sudo pacman -S --needed --noconfirm git base-devel 
   git clone https://aur.archlinux.org/yay.git 
   cd yay
   makepkg -si --noconfirm
   cd - && sudo rm -r ./yay/
fi

step "Installing yay (AUR helper)"
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

step "Copying dotfiles"
mkdir -p "${HOME}/.config"
cp -rf .vimrc "${HOME}/"
cp -rf .zshrc "${HOME}/"
cp -rf .config/* "${HOME}/.config/"

step "Setting Zsh as default shell"
sudo chsh -s "$(which zsh)" "$USER"

step "Enabling timers"
systemctl --user daemon-reload
systemctl --user enable --now .config/systemd/user/battery-notify.timer
systemctl --user enable --now .config/systemd/user/squat-reminder.timer

echo -e "\n✅ \033[1;32mInstallation complete!\033[0m"
echo -e "\e[1mNow install your wallpaper and then run:\e[0m"
echo -e "\n    \e[1;36mmatugen image <PATH-TO-WALLPAPER>\e[0m"
echo -e "\nThis will generate and apply your theme based on the wallpaper."
