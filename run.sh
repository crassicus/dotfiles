#!/bin/env bash

echo "Creating required folders..."

rm -rf \
   "$HOME/.config/qutebrowser" \
   "$HOME/.vim/config"

mkdir -p \
   "$HOME/.config/qutebrowser" \
   "$HOME/.vim/config"


# Simplify the creation of symbolic links
linker(){
  local from="$1"
  local to="$2"

  if [[ $# -lt 2 ]]; then
      echo "ERROR: At least 2 arguments are required."
      return 1
  fi

  ln -srf "$HOME/.dotfiles/$from" "$HOME/$to"
}

echo "Creating symbolic links..."

# Symlinks for files
linker "shell/aliasrc"                ".aliasrc"
linker "shell/zprofile"               ".zprofile"
linker "shell/zshinputrc"             ".zshinputrc"
linker "shell/zshrc"                  ".zshrc"
linker "shell/utils"                  ".utils"

linker "vim/vimrc"                    ".vimrc"
linker "vim/pluggins.vim"             ".vim/config/pluggins.vim"
linker "vim/settings.vim"             ".vim/config/settings.vim"

linker "git/gitconfig"                ".gitconfig"

linker "qutebrowser/config.py"        ".config/qutebrowser/config.py"
linker "qutebrowser/autoconfig.yml"   ".config/qutebrowser/autoconfig.yml"
linker "qutebrowser/gruvbox.py"       ".config/qutebrowser/gruvbox.py"

# Symlinks for directories
[ -e "$HOME/.vim/customizations" ] && rm "$HOME/.vim/customizations"
linker "vim/customizations" ".vim/customizations"

[ -e "$HOME/.config/mpv" ] && rm "$HOME/.config/mpv"
linker "mpv" ".config/mpv"

[ -e "$HOME/.config/yazi" ] && rm "$HOME/.config/yazi"
linker "yazi" ".config/yazi"

[ -e "$HOME/.config/foot" ] && rm "$HOME/.config/foot"
linker "foot" ".config/foot"

[ -e "$HOME/.config/zathura" ] && rm "$HOME/.config/zathura"
linker "zathura" ".config/zathura"

[ -e "$HOME/.config/alacritty" ] && rm "$HOME/.config/alacritty"
linker "alacritty" ".config/alacritty"

[ -e "$HOME/.scripts" ] && rm "$HOME/.scripts"
linker "shell/scripts" ".scripts"

[ -e "$HOME/.config/niri" ] && rm "$HOME/.config/niri"
linker "niri" ".config/niri"

echo "Symlinks created."
