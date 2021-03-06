# shell.nix
with (import <nixpkgs> {});
mkShell {
  buildInputs = [
	 zsh
	 curl
         httpie
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
	 bat
	 shellcheck
	 google-cloud-sdk
     zplug
  ];
}
