{ pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.podman.enable = true;

  environment.systemPackages = with pkgs; [ ];

  virtualisation.containers.policy = {
    default = [ { type = "insecureAcceptAnything"; } ];
    transports = {
      docker-daemon = {
        "" = [ { type = "insecureAcceptAnything"; } ];
      };
    };
  };

}
