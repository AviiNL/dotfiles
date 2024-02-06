# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  colorscheme = inputs.nix-colors.colorSchemes.vice;

  imports = [
    ./desktop/xdg.nix
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    outputs.homeManagerModules.fonts

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim

    # You can also split up your configuration and import pieces of it here:
    ./desktop/wayland
    ./development.nix
    ./discord.nix
    ./firefox.nix
    ./font.nix
    ./gaming.nix
    ./git.nix
    ./gtk.nix
    ./kitty.nix
    ./krita.nix
    ./nemo.nix
    ./nushell.nix
    ./obs.nix
    ./obsidian.nix
    ./plex.nix
    ./qt.nix
    ./remmina.nix
    ./vlc.nix
    ./vscode.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      inputs.neovim-nightly-overlay.overlay

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # Set your username
  home = {
    username = "aviinl";
    homeDirectory = "/home/aviinl";
  };

  # TODO: Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [ fastfetch unzip ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.nixvim = {
    enable = true;
    extraPlugins = with pkgs.vimPlugins; [ plenary-nvim ];
    package = pkgs.neovim-nightly;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
