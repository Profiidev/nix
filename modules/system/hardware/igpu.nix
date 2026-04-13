{ pkgs, ... }:

{
  hardware.graphics = {
    enabled = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-ocl
      intel-vaapi-driver
      vpl-gpu-rt
    ];
  };
}
