{pkgs, ...}: {
  nix.settings = {
    substituters = [
      #"https://cache.nixos-cuda.org"
      "https://cache.nixos.org"
      "https://cache.flox.dev"
    ];
    trusted-public-keys = [
      #"cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
    ];
  };
}
