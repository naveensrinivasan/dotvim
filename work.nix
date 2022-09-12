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
     whois
     go_1_18
     python
     clang
     kind
     git-crypt
     gnupg
     kubernetes-helm
     direnv
     wget
     jdk17
     python3
  ];
}
