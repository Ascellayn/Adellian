# TBD_Name
[FiNAL NAME TO BE DETERMINED], Linux the Ascellayn way. Performance and efficiency over ease of use.

This is a collection of Shell scripts destined to quickly set-up a Debian SID Computer, whenever it's for daily drivers, as a secondary machine, or a server oriented environement.

## This collection of scripts is VERY personal
I won't care if you think this is an outragiously stupid way to use Linux. This is how I do it. If you're not happy, use Ubuntu or do the same shit this repository does but your way with Debian SID or Arch Linux.
**RUN AT YOUR OWN RISK: I WILL NOT PROVIDE ANY SUPPORT WITH THIS. FEEL FREE TO COMPLAIN AS MUCH AS YOU WANT, YOU'VE BEEN WARNED.**

### DO NOT USE THESE SCRIPTS ON ANY OTHER OPERATING SYSTEM BUT A CLEAN DEBIAN UNSTABLE/SID INSTALL
These scripts COULD work on other distributions but I wouldn't recommend it. Also don't run this on an already established system, this does signficant changes to your OS. [You may get a clean mini debian ISO here](https://d-i.debian.org/daily-images/amd64/daily/netboot/), make sure to disable all optional packages (ie: XFCE4, Network tools etc), [TBD NAME] is formed from the most minimal clean Debian install you possibly can have.

## Branches
The current branch being worked on is: WAYLAND_DE

## WAYLAND_DE Screenshot here
- WAYLAND_DE: TBD
  - This branch is what I'd use as a daily driver on a non-nvidia machine.
  - Installs Hyprland (optionally with Waybar, optional because this garbage is a GPU sinkhole on my laptop)
  - Dark theme currently only.
  - Terminal Emulator is Foot.

## X11_DE Screenshot here
- X11_DE: ⚠️ this script is from ages ago, this shit is probably not a good idea but it works
  - This branch is what I'd use as a daily driver when Wayland is making my GPU die of cringe.
  - Installs XFCE4 with the Fluent GTK Theme (builds it automatically). -> note, it will in a future update, needa get out wayland_de out first tho
  - Light theme currently only
  - Terminal Emulator is XTERM.
 
# [TBD NAME] Applications
[TBD NAME] comes with several terminal applications aimed to replace partially several bloated GUI apps (ie, no offense I still like your app, Termius), here is the full list of mini applications made specifically for this collection of script.
- [sshman](https://github.com/SiriusBYT/TBD_Name/tree/main/WAYLAND_DE/rootfs/System/Applications/adellian_sshman), a Python CLI tool to mount via sshfs, or simply connect to SSH servers, aimed to replace Termius. 
