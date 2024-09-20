# TBD_Name
[FiNAL NAME TO BE DETERMINED], Linux the Ascellayn way. Performance and efficiency over ease of use.

This is a collection of Shell scripts destined to quickly set-up a Debian SID Computer, whenever it's for daily drivers, as a secondary machine, or a server oriented environement.

## This collection of scripts is VERY personal
I won't care if you think this is an outragiously stupid way to use Linux. This is how I do it. If you're not happy, use Ubuntu or do the same shit this repository does but your way with Debian SID or Arch Linux.
### Use these scripts at your risk!
As I don't intend this to be a fully fledged, ready to ship OS, obviously a lot of things aren't user friendly. Hell, these scripts might actually fuck everything up. Don't say I didn't warn you.

**I WILL NOT PROVIDE ANY SUPPORT WITH THIS. FEEL FREE TO COMPLAIN AS MUCH AS YOU WANT. THIS MAY ALSO RANDOMLY STAY OUTDATED FOR LONG PERIODS OF TIME.**

### DO NOT USE THESE SCRIPTS ON ANY OTHER OPERATING SYSTEM BUT A CLEAN DEBIAN UNSTABLE/SID INSTALL
These scripts COULD work on other distributions but I wouldn't recommend it. Also don't run this on an already established system, this does signficant changes to your OS.

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
 
## X11_VM Screenshot here
- X11_VM: TBD
  - This branch is what I'd use in a Hyper-V VM. It's really just X11_DE but with several things modified to be lighter and less pretty.

## X11_SERVER Screenshot here
- X11_SERVER: TBD
  - oh no SGN security through obscurity leaked
