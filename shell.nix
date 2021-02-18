# shell.nix
with (import <nixpkgs> {});
mkShell {
  buildInputs = [
   curl
	 go
	 httpie
	 jq
	 neovim
	 gh
	 coreutils
	 wget
     fzf
     ripgrep
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
	 bat
	 starship
	 shellcheck
     google-cloud-sdk
  ];
}
