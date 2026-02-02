{ pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.lixPackageSets.stable.lix;

    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 7;

    settings = {
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
        "https://attic.xuyh0120.win/lantian"
        "https://cache.garnix.io"
      ];
      extra-trusted-public-keys = [
        "nixos:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "community:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "garnix:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];

      auto-optimise-store = true;
      #builders-use-substituters = true;
      
      trusted-users = [
        "root"
        "@wheel"
      ];

      max-jobs = "auto";

      experimental-features = [ 
        "nix-command"
        "flakes" 
        #"pipe-operators" 
      ];

      system-features = ["nixos-test" "kvm" "recursive-nix" "big-parallel"];
    };
  };
}
