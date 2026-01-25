> [!CAUTION]
> ### Adellian is entirely broken thanks to `rust-coreutils`/`coreutils-from-uutils`
> good job debian you entirely nuked both my linux installs
> 
> Adellian has always been an "Debian Experimental" AF """distro""" and it finally came to bite me in the butt, there's no way to even reinstall the old GNU coreutils because they broke the `coreutils-from-gnu` package :D  
> You also can't downgrade the coreutils package if you've already updated to the rust ones as well so good luck :D
>
> You can absolutely expect Adellian to be worked on significantly more in the upcoming days because... Well I basically have to reinstall Adellian myself twice. If I reboot my laptop right now I literally don't have any working Linux machine in my hands.
> They really put the "experimental" in Debian Experimental. I'm very salty.
>
> ***There should be a way to freeze the coreutils package to prevent your entire system to nuke itself and Adellian will do that soon enough the moment I'm no longer busy.***

<br><br><br>

<br>

<p align="center">
  <img src="https://github.com/Ascellayn/Adellian/blob/main/Ressources/AdellianBanner-256px.png?raw=true"/>
</p>
<h1 align=center>
  <a href="https://www.pixiv.net/en/artworks/118554698">The palace for a certain Princess.
</h1>

<br>

### Linux the Ascellayn way. A set of scripts to set up a Debian SID/Experimental environement that prioritizes performance and minimalism.  
This is a collection of Shell scripts destined to quickly set-up a Debian SID/Experimental Computer, whenever it's for daily driving, as a secondary machine, or a server oriented environment.

<br>

> [!WARNING]
> ### **Adellian is designed exclusively for Debian Experimental.**
> Running these scripts outside of a brand new fresh installation of **SPECIFICALLY DEBIAN UNSTABLE/SID** is beyond discouraged.  
> You may get a [Debian SID ISO here](https://d-i.debian.org/daily-images/amd64/daily/netboot/), just make sure to select "SID" when prompted for which Debian Branch to install and make sure to **deselect ALL additional software** when prompted.  
> We recommend also for minimalism's sake to select the "Targeted" option when prompted about drivers.
> DO NOT CREATE AN USER ACCOUNT DURING THE DEBIAN INSTALL: Adellian needs to create the user in order to properly set itself up.

<br>

# Adellian Eco-System
| Adellian Repository | Description |
|-|-|
| Installer (This repository) | Scripts used to configure and install Adellian. |
| [RootFS](https://github.com/Ascellayn/Adellian_RootFS) | The files used to configure the Adellian Environement. |
| [Fluent](https://github.com/Ascellayn/Adellian_Fluent) | A fork of the Fluent GTK Theme built specifically for the "Hyprllian" Adellian Branch. |

| Adellian Application | Description |
|-|-|
| [Manager](https://github.com/Ascellayn/Adellian_Manager) | A TSNA-Based Python tool to manage/update your Adellian Installation. |
| [Screenshot](https://github.com/Ascellayn/Adellian_Screenshot) | Bash Scripts used to capture Screenshots within an Adellian Environement. |
| [SSHMan](https://github.com/Ascellayn/Adellian_SSHMan) | A TSNA-Based Python Terminal application used to connect to SSH Servers. |

<br>

# Adellian is unfinished and is currently under a massive change.
> [!CAUTION]
> Don't run any of these scripts right now unless you're catastrophically stupid. No seriously come back later.

<br>

<br>
<br>

## Adellian Branches

### Hyprllian (Wayland; Designed for Daily Driving)
<p align="center">
  <img src="https://github.com/Ascellayn/Adellian/blob/main/Ressources/Hyprllian_Light.png?raw=true"/>
  <img src="https://github.com/Ascellayn/Adellian/blob/main/Ressources/Hyprllian_Dark.png?raw=true"/>
</p>
[TBD DESCRIPTION]

<br>

### Siriollian (TTY; Designed for TSN's Servers)
[TBD DESCRIPTION & SCREENSHOTS]
