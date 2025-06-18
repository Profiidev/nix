{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cudatoolkit
    libnvidia-container
    egl-wayland
    cudaPackages.cudnn
    cudaPackages.cuda_nvrtc
  ];

  hardware.nvidia-container-toolkit.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}