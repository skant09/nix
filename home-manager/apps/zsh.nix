{
programs = {
      zsh = {
        enable = true;
        oh-my-zsh = {
          enable = true;
          theme = "robbyrussell";
          plugins = [
            "sudo"
	    "git"
            "terraform"
            "systemadmin"
	    "powerlevel10k"
            "vi-mode"
          ];
        };
      };
    };
}
