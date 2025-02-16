{ ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;

    initExtra = ''
      exec fish
    '';
  };
}