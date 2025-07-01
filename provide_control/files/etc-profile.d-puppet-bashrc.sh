if [ -n "$BASH_VERSION" -a -f "$HOME/.bashrc" -a ! -f "$HOME/.profile" ]; then
    . "$HOME/.bashrc"
fi
