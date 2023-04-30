{ pkgs, config, lib, ... }:

let
in {
  environment.etc."greetd/greeter.jpg".source = ./greeter.jpg;

  programs = {
    regreet = {
      enable = true;
      settings = ./regreet.toml;
    };
  };

  services.greetd = {
    enable = true;
    restart = true;
    # settings.default_session.command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.gtkgreet}/bin/gtkgreet -c sway";
    settings.default_session.command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet";
  };

  users.users.greeter.extraGroups = [ "video" ];
}
