setup-sora:
  just dotfiles
  just fonts
  just cursors
  just wallpapers
  just flatpak-mods

dotfiles:
  # Clone and deploy dotfiles
  git clone https://github.com/mecattaf/dotfiles ~/dotfiles
  mkdir -p ~/.local/share/bin/
  mkdir -p ~/.config/
  mkdir -p ~/.themes/
  cp -r ~/dotfiles/bin/* ~/.local/share/bin/
  cp -r ~/dotfiles/config/* ~/.config/
  cp -r ~/dotfiles/theme/* ~/.themes/
  rm -rf ~/dotfiles

fonts:
  # Download and setup the font
  mkdir -p ~/.local/share/fonts
  curl -o ~/fonts.tar.gz -L "https://github.com/mecattaf/fonts/archive/refs/tags/nerd.tar.gz"
  tar -xf ~/fonts.tar.gz -C ~/.local/share/fonts
  mv ~/.local/share/fonts/fonts-nerd/* ~/.local/share/fonts/
  rm -rf ~/.local/share/fonts/fonts-nerd/
  rm ~/fonts.tar.gz
  fc-cache -v

  # Add Emoji
  pip install emoji-fzf

cursors:
  # Download and set up the cursor theme
  mkdir -p ~/.icons
  curl -o ~/bibata.tar.gz -L "https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.3/Bibata.tar.gz"
  tar -xf ~/bibata.tar.gz -C ~/.icons/
  rm ~/bibata.tar.gz

wallpapers:
  # Clone and deploy wallpapers
  git clone https://github.com/mecattaf/wallpapers ~/.wallpapers
  mkdir -p ~/.local/share/wallpapers/
  cp -r ~/.wallpapers/* ~/.local/share/wallpapers/
  rm -rf ~/.wallpapers

flatpak-mods:
  echo 'Giving browser permission to create PWAs (Progressive Web Apps)'
  # Add for your favorite chromium-based browser
  flatpak override --system --filesystem=~/.local/share/applications --filesystem=~/.local/share/icons com.google.Chrome
    # Give Flatpak apps access to the custom icons and themes directories
    flatpak override --filesystem=/var/home/$USER/.icons
    flatpak override --filesystem=/var/home/$USER/.themes
    # Give Google Chrome Flatpak specific access to the visuals directories
    flatpak override com.google.Chrome --filesystem=$HOME/.themes
    flatpak override com.google.Chrome --filesystem=$HOME/.icons
    # Set GTK theme for all Flatpak apps
    flatpak override --env=GTK_THEME=Base16

setup-flatpaks:
  #!/usr/bin/env bash
  echo 'Installing flatpaks from the ublue recipe ...'
  flatpaks=$(yq -- '.firstboot.flatpaks[]' "/usr/share/ublue-os/recipe.yml")
  for pkg in $flatpaks; do \
      echo "Installing: ${pkg}" && \
      flatpak install --user --noninteractive flathub $pkg; \
  done
