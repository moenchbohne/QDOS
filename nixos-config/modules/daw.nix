{ config, pkgs, inputs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # REAPER
    reaper
    reaper-sws-extension
    reaper-reapack-extension

    # yabridge compat
    yabridge
    yabridgectl

    # VSTs (plugins)
    oxefmsynth
    vital
    # chow-tape-model
    # x42-avldrums
    lsp-plugins # collection
    # gxmatcheq-lv2
    tap-plugins # collection
  ];

  # MUSNIX real-time audio
  musnix = {
    enable = true;
  };
}

