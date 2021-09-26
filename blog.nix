# shell.nix
with (import <nixpkgs> {});
mkShell {
  buildInputs = [
	 zsh
	 curl
	 glow
	 jq
	 neovim
	 gh
	 oh-my-zsh
	 coreutils
	 fzf
	 ripgrep
	 powerline-fonts
	 nodejs
	 tree
	 graphviz
	 fd
	 delta
	 bat
	 shellcheck
         openssl
	 zplug
	 yarn
	 nodejs
         go
	 ag
         hugo
  ];
}
