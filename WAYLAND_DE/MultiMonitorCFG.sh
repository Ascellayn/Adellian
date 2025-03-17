echo "Making Hyprland Workspaces less retarded..."
hyprpm add https://github.com/Duckonaut/split-monitor-workspaces
hyprpm enable split-monitor-workspaces
hyprpm reload

echo "Done. Don't forget to edit /System/Configuration/Hyprland/Common/binds.conf accordingly."
