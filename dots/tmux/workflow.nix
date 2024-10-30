{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    tmux
  ];
  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    extraConfig = ''
      # Shell.
      set-option -g default-shell /bin/bash

      # Terminal.
      set-option -ga terminal-overrides ",screen-256color:Tc"
      # set-option -g default-terminal "${TERM}"
      # Undercurl
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

      # Settings.
      set -g prefix None
      set -g prefix2 None
      setw -g mode-keys vi
      set -g base-index 1
      setw -g mouse on
      set -s escape-time 0
      set -g focus-events on
      set -g automatic-rename on
      set-option -g set-titles on
      set-option -gw xterm-keys on
      set -g status-interval 1
      set -g renumber-windows on

      # Some setup.
      unbind h
      unbind j
      unbind k
      unbind l
      unbind M-h
      unbind M-j
      unbind M-k
      unbind M-l

      # Modes
      bind -T copy-mode-vi Escape send-keys -X cancel

      # Panes.
      bind -n C-h select-pane -L
      bind -n C-j select-pane -D
      bind -n C-k select-pane -U
      bind -n C-l select-pane -R
      bind -n M-q kill-pane
      bind -n M-v split-window -c "#{pane_current_path}" -h fish
      bind -n M-d split-window -c "#{pane_current_path}" -v fish
      bind -n M-Left resize-pane -L 5
      bind -n M-Right resize-pane -R 5
      bind -n M-Up resize-pane -U 5
      bind -n M-Down resize-pane -D 5
      bind -n M-= next-layout

      # Windows.
      bind -n M-Tab next-window
      bind -n M-S-Tab previous-window
      bind -n M-l next-window
      bind -n M-h previous-window
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t :2
      bind -n M-3 select-window -t :3
      bind -n M-4 select-window -t :4
      bind -n M-5 select-window -t :5
      bind -n M-6 select-window -t :6
      bind -n M-7 select-window -t :7
      bind -n M-8 select-window -t :8
      bind -n M-9 select-window -t :9
      bind -n M-0 select-window -t :0
      bind -n M-w command-prompt -I "#W" "rename-window '%%'"

      # Session.
      bind -n M-r command-prompt -I "#S" "rename-session '%%'"

      # Programs.
      bind -n M-m new-window -n "monitor" btop
      bind -n M-g new-window -c "#{pane_current_path}" -n "git" lazygit
      bind -n M-s new-window -c "#{pane_current_path}" -n "shell" fish
      bind -n M-f new-window -c "#{pane_current_path}" -n "files" ranger
      bind -n M-e new-window -c "#{pane_current_path}" -n "editor" nvim
      bind -n M-b new-window -c "#{pane_current_path}" -n "browser" lynx

      # Plugins.
      set -g @plugin 'tmux-plugins/tpm'
      set -g @plugin 'aserowy/tmux.nvim'
      set -g @plugin 'tmux-plugins/tmux-resurrect'
      run '~/.tmux/plugins/tpm/tpm'

      # Message style.
      set -g message-style "fg=#EBCB8B,bg=#191C24"
      set -g message-command-style "fg=#EBCB8B,bg=#191C24"

      # Pane style.
      set -g pane-border-style "fg=#191C24"
      set -g pane-active-border-style "fg=#191C24"

      # Status style.
      set -g status-style "fg=#BBC3D4,bg=#191C24"
      set -g status-left "#[fg=#8FBCBB,bg=#191C24]#[fg=#191C24,bg=#8FBCBB,bold] #{session_windows}#[fg=#8FBCBB,bg=#191C24]  "
      set -g status-right "#[fg=#3B4252,bg=#191C24] #S #[fg=#A3BE8C,bg=#191C24] #[fg=#191C24,bg=#A3BE8C,bold]󱫋 #{session_attached}#[fg=#A3BE8C,bg=#191C24]"
      set -g status-left-length 100
      set -g status-position top
      set -g status-justify left

      # Window style.
      set -g window-status-style "fg=#434C5E,bg=black"
      set -g window-status-format "#[fg=default,bg=black] #[fg=default,bg=black]#W"
      set -g window-status-separator "  "
      set -g window-status-current-format "#[fg=cyan,bg=black] #[fg=cyan,bg=black]#W"

    '';
    plugins = with pkgs.tmuxPlugins; [
      yank
    ];
  };
}
