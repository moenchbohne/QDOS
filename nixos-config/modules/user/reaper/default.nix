{ config, pkgs, inputs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # ===== REAPER =====
    reaper # DAW 4 Life
    
    reaper-sws-extension
    reaper-reapack-extension

    # ===== yabridge compat =====
    yabridge
    yabridgectl
  ];
}