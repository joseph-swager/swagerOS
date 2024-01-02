{ config, lib, pkgs, user, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in {
  imports = [ (import "${home-manager}/nixos") ]
  ++ [ (import ./apps/neovim.nix) ]
  ++ [ (import ./configs/kitty.nix) ]
  ++ [ (import ./configs/direnv.nix) ];
  

  home-manager.users.josephs = {
    home.username = "josephs";
    home.homeDirectory = "/home/josephs";
    home.stateVersion = "23.11";

    home.packages = with pkgs; [
      home-manager
      #############
      # Editors   #
      #############
      emacs29
      #############
      # Gnome     #
      #############
      gnome.dconf-editor
      gnome.gnome-terminal
      gnome.gnome-tweaks
      gnomeExtensions.caffeine
      gnomeExtensions.gsconnect
      gnomeExtensions.just-perfection
      gnomeExtensions.pop-shell
      gnomeExtensions.tray-icons-reloaded
      nordic
      ##############
      # ROFI       #
      ##############
      rofi
      pinentry-rofi
      ##############
      # Tools      #
      ##############
      coreutils
      curl
      docker
      docker-compose
      fzf
      gcc
      github-cli
      gnupg
      gnumake
      jq
      lsd
      neofetch
      nixfmt
      nmap
      ripgrep
      openssl
      xclip
      ################
      # Desktop Apps #
      ################
      signal-desktop
      discord
      _1password-gui
    ];
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = "disabled";
        enabled-extensions = [
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
          "pop-shell@system76.com"
          "caffeine@patapon.info"
          "hidetopbar@mathieu.bidon.ca"
          "gsconnect@andyholmes.github.io"
        ];
        favorite-apps = ["firefox.desktop" "kitty.desktop"];
        had-bluetooth-devices-setup = true;
        remember-mount-password = false;
        welcome-dialog-last-shown-version = "42.4";
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "Nordic-darker";
      };

      "org/gnome/shell/extensions/pop-shell" = {
        focus-right = "disabled";
        tile-by-default = true;
        tile-enter = "disabled";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "kitty super";
        command = "kitty";
        binding = "<Ctrl><Alt>t";
      };
    };
  };
  programs = {
    bash = {
      enableCompletion = true;
      shellAliases = {
        sv="sudo nvim";
        ls="lsd";
        ll="lsd -l";
        la="lsd -a";
        lla="lsd -al";
        gp="git pull";
      };
    };
  };
}
