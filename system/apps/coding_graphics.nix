{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dbeaver-bin
    jetbrains-toolbox
    zed-editor
    massif-visualizer
    postman
    renderdoc
    vulkan-caps-viewer
    vulkan-tools
    vulkan-utility-libraries
    vulkan-validation-layers
    vulkan-extension-layer
    wireshark
  ];
}
