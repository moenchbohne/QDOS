{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = ''
      font_family	  JetBrainsMono Nerd Font
      font_size	  13.5
      
      scrollback_lines 8000
      
      paste_actions quote-urls-at-prompt
      
      strip_trailing_spaces never
      
      select_by_word_characters @-./_~?&=%+#
      
      show_hyperlink_targets yes
      
      enable_audio_bell no
      
      remote_kitty if-needed
      
      window_border_width 0.5pt
      
      confirm_os_window_close -1
      
      
      tab_bar_style powerline


      #: Increase font size

      map ctrl+equal  change_font_size all +2.0
      map ctrl+plus   change_font_size all +2.0
      map ctrl+kp_add change_font_size all +2.0


      #: Decrease font size

      map ctrl+minus       change_font_size all -2.0
      map ctrl+kp_subtract change_font_size all -2.0


      #: Reset font size

      map ctrl+0 change_font_size all 0
    '';
  };
}