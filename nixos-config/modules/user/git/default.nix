{ ... }:

{
  programs.git = {
    enable = true;

    settings.user = {
      name = "moenchbohne";
      email = "beckercelle@gmail.com";
    };
  };
}