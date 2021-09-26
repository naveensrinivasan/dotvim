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
	 docker
	 nodejs
	 docker-machine
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
	 podman
	 doctl
    go_1_15
	ag
  ];
}
