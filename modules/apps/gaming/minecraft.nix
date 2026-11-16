{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    proton-launcher
    prismlauncher
    lunar-client
  ];
}
