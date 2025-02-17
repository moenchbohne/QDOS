{ config, pkgs, ... }:

# AI-Generated

{
  # Enable MPD service
  services.mpd = {
    enable = true;

    # Music directory (where your music files are stored)
    musicDirectory = "/home/quentin/Music";

    # Playlist directory
    playlistDirectory = "/var/lib/mpd/playlists";

    # Database file location
    dbFile = "/var/lib/mpd/mpd.db";

    # User and group under which MPD runs
    user = "quentin";
    group = "mpd";

    # Audio output configuration (example: ALSA)
    # extraConfig = ''
    #   audio_output {
    #     type "alsa"
    #     name "My ALSA Device"
    #     device "hw:0,0" # Replace with your audio device
    #   }
    # '';
  };

  # Create necessary directories with correct permissions
  systemd.tmpfiles.rules = [
    "d /var/lib/mpd/playlists 0755 mpd mpd -"
    "d /var/log/mpd 0755 mpd mpd -"
  ];
}