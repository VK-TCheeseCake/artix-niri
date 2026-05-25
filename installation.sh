root=""
if ! [ "$EUID" -eq 0 ] ; then
    root=doas
fi

$root pacman -S stow 








stow --dotfiles --adopt -t ~ main
