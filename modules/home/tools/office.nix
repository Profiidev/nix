{ lib, pkgs, ... }:

{
  home.packages = [ pkgs.onlyoffice-desktopeditors ];

  xdg.mimeApps =
    let
      associations = lib.genAttrs [
        "application/msword"
        "application/msword-template"
        "application/vnd.ms-word.document.macroEnabled.12"
        "application/vnd.ms-word.template.macroEnabled.12"
        "application/vnd.ms-excel"
        "application/vnd.ms-excel.sheet.macroEnabled.12"
        "application/vnd.ms-excel.sheet.binary.macroEnabled.12"
        "application/vnd.ms-excel.template.macroEnabled.12"
        "application/vnd.ms-powerpoint"
        "application/vnd.ms-powerpoint.presentation.macroEnabled.12"
        "application/vnd.ms-powerpoint.slideshow.macroEnabled.12"
        "application/vnd.ms-powerpoint.template.macroEnabled.12"
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        "application/vnd.openxmlformats-officedocument.wordprocessingml.template"
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        "application/vnd.openxmlformats-officedocument.spreadsheetml.template"
        "application/vnd.openxmlformats-officedocument.presentationml.presentation"
        "application/vnd.openxmlformats-officedocument.presentationml.slideshow"
        "application/vnd.openxmlformats-officedocument.presentationml.template"
        "application/vnd.oasis.opendocument.text"
        "application/vnd.oasis.opendocument.text-template"
        "application/vnd.oasis.opendocument.spreadsheet"
        "application/vnd.oasis.opendocument.spreadsheet-template"
        "application/vnd.oasis.opendocument.presentation"
        "application/vnd.oasis.opendocument.presentation-template"
        "application/rtf"
      ] (_: [ "onlyoffice-desktopeditors.desktop" ]);
    in
    {
      defaultApplications = associations;
      associations.added = associations;
    };

  # OnlyOffice rewrites this file on exit, so patch the key instead of managing the whole file.
  # titlebar=system drops the custom frame whose invisible margin shows as a gap under Hyprland.
  home.activation.onlyofficeSystemTitlebar = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    conf="$HOME/.config/onlyoffice/DesktopEditors.conf"
    if [ ! -f "$conf" ]; then
      run mkdir -p "$(dirname "$conf")"
      run cp ${builtins.toFile "DesktopEditors.conf" "[General]\ntitlebar=system\n"} "$conf"
      run chmod u+w "$conf"
    elif grep -q '^titlebar=' "$conf"; then
      run sed -i 's/^titlebar=.*/titlebar=system/' "$conf"
    else
      run sed -i '/^\[General\]$/a titlebar=system' "$conf"
    fi
  '';
}
