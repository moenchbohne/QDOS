{ config, pkgs, inputs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # ===== REAPER =====
    reaper
    reaper-sws-extension
    reaper-reapack-extension

    # ===== yabridge compat =====
    yabridge
    yabridgectl
    (wine.override { 
      # You may need to experiment, but wine-staging is often good
      wineBuild = "wine-staging"; 
    })

    # ===== VSTs (plugins) =====
    oxefmsynth
    vital
    # chow-tape-model
    # x42-avldrums
    # lsp-plugins # collection
    # gxmatcheq-lv2
    # tap-plugins # collection
  ];

  # ===== MUSNIX real-time audio =====
  musnix = {
    enable = true;
  };
}

