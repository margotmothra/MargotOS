{
  profile,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./zshrc-personal.nix
  ];

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "regexp" "root" "line"];
    };
    historySubstringSearch.enable = true;

    history = {
      ignoreDups = true;
      save = 10000;
      size = 10000;
    };

    oh-my-zsh = {
      enable = true;
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./p10k-config;
        file = "p10k.zsh";
      }
    ];

    initContent = ''
            export TERM=xterm-256color
            export ZDOTDIR=$HOME/.config/zsh
            # Override LS_COLORS with EZA_COLORS for better dash visibility
            export EZA_COLORS="xx=01;34:da=01;34" # xx = punctuation/dashes (bold blue), da = dates (bold blue)
            bindkey -e # Enable Emacs-style keybindings

            # Fix for arrow keys and other special keys over SSH
            bindkey "\e[1~" beginning-of-line # Home
            bindkey "\e[4~" end-of-line       # End
            bindkey "\e[5~" beginning-of-history # PageUp
            bindkey "\e[6~" end-of-history     # PageDown
            bindkey "\e[3~" delete-char        # Delete
            bindkey "\e[2~" quoted-insert      # Insert

            # For older terminals
            bindkey "\eOH" beginning-of-line
            bindkey "\eOF" end-of-line
      3
            # Standard arrow key bindings for history navigation
            bindkey '^[[A' history-search-backward
            bindkey '^[[B' history-search-forward
            bindkey '^[[C' forward-char
            bindkey '^[[D' backward-char

            # Common keybindings for word movement
            bindkey '^[[1;5C' forward-word # Ctrl+Right Arrow
            bindkey '^[[1;5D' backward-word # Ctrl+Left Arrow
            bindkey '^[[H' beginning-of-line # Home
            bindkey '^[[F' end-of-line # End

            # Ensure prompt is reset after keybindings are set
            if [[ $options[zle] = on ]]; then
              zle reset-prompt
            fi
            if [ -f $HOME/.zshrc-personal ]; then
              source $HOME/.zshrc-personal
            fi
    '';

    shellAliases = {
      sv = "sudo nvim";
      v = "nvim";
      c = "clear";
      fr = "nh os switch --hostname ${profile}";
      fu = "nh os switch --hostname ${profile} --update";
      zu = "sh <(curl -L https://gitlab.com/Zaney/margotos/-/releases/latest/download/install-margotos.sh)";
      ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      cat = "bat";
      man = "batman";
      ff = "fastfetch";
    };
  };
}
