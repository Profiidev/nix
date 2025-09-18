{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.proton.packages.${system}.default
    prismlauncher
    modrinth-app
    badlion-client
  ];
}
