{
  programs.umbriel.settings = fromTOML (builtins.readFile ../../../assets/umbriel/corona.toml);
}
