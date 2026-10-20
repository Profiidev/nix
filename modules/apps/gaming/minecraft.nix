{
  pkgs,
  inputs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    proton-launcher
    prismlauncher
    lunar-client
  ];
}
