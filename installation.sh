run_as_root() {
    if command -v sudo &> /dev/null; then
        root=sudo
    elif command -v doas &> /dev/null; then
        root=doas
    fi
}
if ! [ "$EUID" -eq 0 ] ; then
    run_as_root
fi

set -e 

$root pacman -Sy


#yea i yonk this from ai because it look cleaner than my own

CORE_PACKAGES=(
  # Window Manager & Display
  niri
  quickshell
  wl-clipboard
  xorg-xwayland
  awww

  # Shell & Terminal
  kitty
  neovim
  starship
  zsh

  # Audio
  pipewire
  pipewire-pulse
  pipewire-alsa
  wireplumber

  # System & Utils
  stow
  upower
  brightnessctl

  # Fonts
  ttf-dejavu
  ttf-liberation
  noto-fonts

  # App Management
  flatpak
)

echo " Installing core packages..."
$root pacman -S --noconfirm "${CORE_PACKAGES[@]}"

# Zinit set up
if [ ! -d "$HOME/.local/share/zinit/zinit.git" ]; then
  echo " Installing Zinit..."
  bash -c "$(curl --fsSLo- https://git.io/zinit-install)"
else
  echo " Zinit already installed"
fi






stow --dotfiles --adopt -t ~ main
