# shell.nix
with (import <nixpkgs> {});
mkShell {
  buildInputs = [
	 zsh
	 curl
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
     openssl
     zplug
     yarn
     nodejs
     podman
     doctl
     hugo
     whois
     go_1_17
     protoc-gen-go
     python
     clang
     kind
     automake
  ];
}
