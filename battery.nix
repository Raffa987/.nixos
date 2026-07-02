{ config, pkgs, ... }:

{
  services = {
    tlp = {
      enable = true;
      settings = {
        RUNTIME_PM_ON_AC = "auto";
        RUNTIME_PM_ON_BAT = "auto";

        START_CHARGE_THRESH_BATO = 60;
        STOP_CHARGE_THRESH_BATO = 80;
      };
    };
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };
}