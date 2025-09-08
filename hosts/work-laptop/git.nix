{ ... }:

{
  programs.git = {
    enable = true;
    config = {
      user.name = "eweaver";
      user.email = "eweaver@classicalconversations.com";
    };
  };
}
