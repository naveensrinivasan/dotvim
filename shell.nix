# shell.nix
with (import <nixpkgs> {});
mkShell {
  buildInputs = [
	 curl
	 go
	 httpie
	 jq
	 neovim
	 kubectl
	 gh
	 oh-my-zsh
	 coreutils
	 wget
	 fzf
	 ripgrep
	 powerline-fonts
	 kubectx
	 watch
	 docker
	  nodejs
	 docker-machine
	 tree
	 graphviz
	 tmux
	 kind
	 kustomize
	 k3d
	 golangci-lint
	 fd
	 ripgrep
     delta
	redis
	 bat
	 starship
	 shellcheck
	 google-cloud-sdk
     zplug
  ];
}
