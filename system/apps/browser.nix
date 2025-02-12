{ pkgs, ... }:

{
  # Module installing brave as default browser
  home.packages = [ pkgs.google-chrome ];

  xdg.mimeApps.defaultApplications = {
  "text/html" = "brave-browser.desktop";
  "x-scheme-handler/http" = "google-chrome.desktop";
  "x-scheme-handler/https" = "google-chrome.desktop";
  "x-scheme-handler/about" = "google-chrome.desktop";
  "x-scheme-handler/unknown" = "google-chrome.desktop";
  };

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.google-chrome}/bin/google-chrome";
  };

}