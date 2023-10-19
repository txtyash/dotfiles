{...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;
    settings = {
      add_newline = true;
      shlvl = {
        threshold = 1;
        disabled = false;
      };
    };
  };
}
