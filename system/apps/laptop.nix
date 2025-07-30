{ pkgs, inputs, ... }:

{
  services.cloudflare-warp = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    inputs.proton.packages.${system}.default
  ];
}
