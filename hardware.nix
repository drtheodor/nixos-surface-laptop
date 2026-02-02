{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;

  hardware.graphics = {
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      libva
      libva-vdpau-driver
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  services = {
    xserver.videoDrivers = [ "modesetting" ];
    logind.settings.Login.HandleLidSwitch = "sleep";
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
}
