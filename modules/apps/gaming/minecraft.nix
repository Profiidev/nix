{
  pkgs,
  inputs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    proton-launcher
    prismlauncher
    basalt-launcher
  ];
}
