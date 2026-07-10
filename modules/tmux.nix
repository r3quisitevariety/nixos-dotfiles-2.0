{...}: {
  programs.tmux = {
    enable = true;
    shortcut = "b";
    escapeTime = 0;
    historyLimit = 10000;
    extraConfig = ''
      # pane navigation (hjkl)
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # pane resizing (HJKL)
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # splits that open in current directory
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      set -g mouse on
      set -g set-clipboard on
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"
    '';
  };
}
