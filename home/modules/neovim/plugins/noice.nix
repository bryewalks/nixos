{ ... }:

{
  programs.nixvim = {
    plugins = {
      noice = {
        enable = true;
        settings = { };
        routes = [{
          filter = { event = "msg_showmode"; };
          view = "notify";
        }];
        presets = {
          long_message_to_split = true;
        };
      };

      # Dependencies
      nui.enable = true;
      notify.enable = true;
    };
  };
}
