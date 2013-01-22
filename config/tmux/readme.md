This folder is responsible for holding layouts for different dev environments in tmux



selectp -t 0              # Select pane 0
splitw -h -p 50 'bpython' # Split pane 0 vertically by 50%
selectp -t 1              # Select pane 1
splitw -v -p 25           # Split pane 1 horizontally by 25%
selectp -t 0              # Select pane 0