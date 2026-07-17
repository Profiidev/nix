{
  pkgs,
  pkgsUnstableNoCuda,
  isLinux,
  ...
}:

let
  wrapped-kubernetes-helm =
    with pkgs;
    wrapHelm kubernetes-helm {
      plugins = with pkgs.kubernetes-helmPlugins; [
        helm-secrets
        helm-diff
        helm-s3
        helm-git
      ];
    };

  wrapped-helmfile = pkgs.helmfile-wrapped.override {
    inherit (wrapped-kubernetes-helm) pluginsDir;
  };

  wrapped-azure-cli = pkgs.azure-cli.withExtensions [ pkgs.azure-cli-extensions.account ];
in
{
  environment.systemPackages =
    with pkgs;
    [
      act
      docker
      docker-buildx
      docker-compose
      maven
      sea-orm-cli
      wasm-pack
      ldproxy
      pkg-config
      gobject-introspection
      terraform
      minikube
      k9s
      #wrapped-azure-cli
      #wrapped-helmfile
      wrapped-kubernetes-helm
      kubectl
      kubevirt
      kustomize
      helm-ls
      pkgsUnstableNoCuda.devenv
      gh
      espflash
      stackit-cli
      awscli2
      pre-commit
      nodejs_26
      bun
      pnpm
      llvmPackages.lld
      wasm-bindgen-cli
      clang.cc
    ]
    ++ (
      if isLinux then
        (with pkgs; [
          release-plz
          esp-generate
          espup
          probe-rs-tools
          kdePackages.qtdeclarative
          strix
        ])
      else
        [ ]
    );

  services.udev.packages = with pkgs; [
    probe-rs-tools
  ];

  users.groups.plugdev = { };

  networking.firewall = {
    allowedTCPPorts = [
      1420
      1421
    ];
  };
}
