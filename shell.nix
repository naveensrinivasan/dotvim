# shell.nix
with (import <nixpkgs> {});
mkShell {
  buildInputs = [
	 zsh
	 curl
	 go
     glow
	 jq
	 neovim
	 kubectl
	 gh
	 oh-my-zsh
	 coreutils
	 fzf
	 ripgrep
	 powerline-fonts
	 kubectx
	 docker
	 nodejs
	 docker-machine
	 tree
	 graphviz
	 fd
	 delta
	 bat
	 shellcheck
	 google-cloud-sdk
         vault-bin
         awscli
         openssl
     zplug
	 yarn
     nodejs
	 podman
     doctl
  ];
}
