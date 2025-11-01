# Dotfiles

My dotfiles for Zsh, Vim and Hyprland

## Install

Clone the repository

```bash
git clone --depth 1 https://github.com/mycenicus/dotfiles.git
cd dotfiles
```

A `install.sh` script is provided to install all required packages and configure
your enviroment. Use the '-h' or '--help' option to see all available flags

```
./install.sh -h
```

Example (see [Stow](#Stow) section):

```
./install.sh --stow --all
```

### Notes
* After running `install.sh`, relogin (`Super+M`) to apply new settings

# Stow

Dotfiles are organized in tree structure so you can manage them with [GNU Stow](www.gnu.org/software/stow/).
Run the install script with the `--stow` argument to prevent dotfiles from being copied to your HOME directory.
```
./install.sh --stow
```

To use Stow, make sure you are in `/dotfiles` directory and run

```bash
stow -t ~ .
```

### Update

With Stow, you can easily update your dotfiles. Change your directory to
`/dotfiles`. For example

```bash
cd ~/git/dotfiles
```

And pull updates

```bash
git pull --rebase --depth 1
stow -t ~ .
```
