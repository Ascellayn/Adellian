from TSN_Abstracter import *;
import subprocess;
import shutil, os;

# Might wanna push this one to TSN_Abstracter
def Shell_Run(Command: str) -> subprocess.CompletedProcess:
	Process: subprocess.CompletedProcess = subprocess.run(Command, shell=True, stdout=subprocess.PIPE, text=True);
	for Line in iter(Process.stdout.readline, ""):
		Log.Stateless(Line);
	Log.Debug(f"Process exited with code {Process.returncode}");
	return Process;

def Shell_Run_Critical(Command: str) -> None:
	Process: subprocess.CompletedProcess = Shell_Run(Command);
	if (Process.returncode == 0): return;
	Log.Critical(f"An error occurred while running an Adellian Installation Script. The installer will now exit.\n[ERROR]: {Process.stdout}");
	exit();

Adellian_Logo: str = \
"""
                     .-.    :-                                                                        
      -:             .=.    .:                                                                        
      =@#=          .-=*#%##-                                                                         
      .*@@%=.   .-+#%%%%=:#%#                    .--:           :--: :--:  ::                         
      . #@@@%+-*##%%#*++-+%#:     .#%%*          =@@*           *@@* +@@# =@@*                        
         %%%@@@%%%+:  .+%%+.      *@@@@=     .:-:=@@*   .:--.   +@@* +@@* :++-   .:-:.   .:: .-:.     
        .*@@@%%@@@#.:*%%+.       =@@*#@@:   +%@@%@@@* .#@@%@@#- +@@* +@@# +@@# :%@@%@@%- #@@%%@@@*    
      :+#%@@@@@@@%%%%#=.        :@@% :@@#. -@@%. *@@* #@@*-=@@@.+@@* +@@# =@@# :+*+-*@@# #@@+ :@@@.   
    :*##%##%@@%%%%%#:           #@@@%%@@@* =@@#  -@@*.@@@######.+@@* +@@# =@@# -#@#+#@@# #@@- .%@@:   
  .+####*:-*%%%%%%@@=          *@@%++++%@@=.%@@+=%@@# +@@%==*#- *@@# +@@# +@@# #@@*-#@@% #@@= .@@@:   
 :##+:##+===-::+%@@@@= .-     :###:    =##* .+#%#+##+  :+#%%%*: =##+ =##+ =##+ .+#%%*###.+##- .###.   
 +#=   ...      .+@@@@- :                                                                             
 :-.              .*@@@-                                                                              
  .       .-        :*@@-                                                                             
           .          :*@:                                                                            
                        :-                                                                            
"""

# Internal Tools
def DownloadRepo_RootFS() -> None:
	if (File.Exists("/System/Adellian/RootFS")):
		Log.Warning(f"The Adellian RootFS Repository was left undeleted from a previous installation attempt.");
		shutil.rmtree("/System/Adellian/RootFS");

	#Log.Info(f"Downloading Adellian RootFS...");
	Process: subprocess.CompletedProcess = Shell_Run(f"git clone https://github.com/Ascellayn/Adellian_RootFS /System/Adellian/RootFS");
	if (Process.returncode == 0): Log.Fetch_ALog().OK(); return;

	Log.Fetch_ALog().ERROR(f"Process exited with code {Process.returncode}");
	Log.Critical(f"An error occurred while downloading crucial Adellian Files. The installer will now exit.\n[ERROR]: {Process.stdout}");
	exit();

# RootFS Installers
def Install_RootFS(Branch: str) -> None:
	#Log.Info(f"Installing Adellian's {Branch} RootFS...");
	Process: subprocess.CompletedProcess = Shell_Run(f"cp -R -v /System/Adellian/RootFS/{Branch}_RootFS/* /");
	if (Process.returncode == 0): Log.Fetch_ALog().OK(); return;

	Log.Fetch_ALog().ERROR(f"Process exited with code {Process.returncode}");
	Log.Critical(f"An error occurred while installing the {Branch} Adellian RootFS. The installer will now exit.\n[ERROR]: {Process.stdout}");
	exit();


def Bootstrap() -> None:
	Log.Stateless(Adellian_Logo);
	Log.Info("Adellian Installer v250824_DEV");
	Shell_Run_Critical("adduser ascellayn");
	Adellian_Installer({
		"Branch": "Hyprllian",
		"Username": "ascellayn",
		"Scripts": [
			"/System/Adellian/Installer/Install-Scripts/Hyprllian/HyprInit.sh"
		]
	});


# Installation Process
def Failed_Install() -> None:
	Log.Critical("Adellian failed to install properly. The installer will now exit.");
	exit();

Steps_Current: int = 0;
Steps_Total: int = 11;

def Display_Step() -> str:
	global Steps_Current;
	Steps_Current +=1;
	return f"[{Steps_Current}/{Steps_Total}]";

def Adellian_Installer(Configuration: dict) -> None:
	""" This installs Adellian according to the specified Dictionary.
	Example dictionary:
	>>> "{
		Branch: "Hyprllian",
		Username: "ascellayn",
		Scripts: [
			"/System/Adellian/Installer/Install-Scripts/Hyprllian/HyprInit.sh",
			"/System/Adellian/Installer/Install-Scripts/Universal/NoVideo.sh"
		]
	}"
	"""
	global Steps_Total;
	Steps_Total += len(Configuration["Scripts"]);

	Log.Warning("=== INSTALLING ADELLIAN ===");
	Log.Info(f"{Display_Step()} Downloading the Adellian RootFS Repository...");
	DownloadRepo_RootFS();

	Log.Info(f"{Display_Step()} Installing the Universal RootFS...");
	Install_RootFS("Universal"); Log.Fetch_ALog().OK();

	Log.Info(f"{Display_Step()} Setting up Adellian's {Configuration['Branch']} Branch's RootFS...");
	Install_RootFS(Configuration["Branch"]); Log.Fetch_ALog().OK();

	Log.Info(f"{Display_Step()} Installing Adellian Base System...");
	Shell_Run_Critical("/bin/bash /System/Adellian/Installer/Install-Scripts/Universal/Base_Installation.sh");
	Log.Fetch_ALog().OK();

	Log.Info(f"{Display_Step()} Installing {Configuration['Branch']} Base System...");
	Shell_Run_Critical(f"/bin/bash /System/Adellian/Installer/Install-Scripts/{Configuration['Branch']}/Base_Installation.sh");
	Log.Fetch_ALog().OK();

	for Script in Configuration["Scripts"]:
		Script_Name = Script.split("/")[-1];
		Log.Info(f"\t{Display_Step()} Running Script \"{Script_Name}\"...");
		Shell_Run_Critical(Script);
		Log.Fetch_ALog().OK();

	Log.Info(f"{Display_Step()} Copying UserFS for \"{Configuration["Username"]}\"...");
	Shell_Run_Critical(f"/bin/bash cp -R -v /root/.config /home/{Configuration["Username"]}");
	Log.Fetch_ALog().OK();

	Log.Info(f"{Display_Step()} Installing TSN Abstracter for \"{Configuration["Username"]}\"...");
	Shell_Run_Critical(f"printf '\n# Adellian Bootstrap - TSN Abstracter Installation\nexport PYTHONPATH=/System/Library/TSN_Abstracter:$\n' >> /home/{Configuration['Username']}/.bashrc");
	Log.Fetch_ALog().OK();

	Log.Info(f"{Display_Step()} Saving Adellian Configuration...");
	File.JSON_Write("/System/Adellian_Configuration.json", Configuration);
	Log.Fetch_ALog().OK();

	Log.Info(f"{Display_Step()} Fixing file permissions...");
	Shell_Run_Critical(f"chown -R {Configuration['Username']} /home/{Configuration['Username']}");
	Shell_Run_Critical(f"chown -R {Configuration['Username']} /System");
	Log.Fetch_ALog().OK();

	# Cleanup
	Log.Warning("=== CLEANING UP INSTALLATION FILES ===");
	Log.Info(f"{Display_Step()} Deleting RootFS Repository...");
	shutil.rmtree("/System/Adellian/RootFS");
	Log.Fetch_ALog().OK();

	Log.Info(f"{Display_Step()} Deleting Adellian Installer...");
	shutil.rmtree("/System/Adellian/Installer");
	Log.Fetch_ALog().OK();

	Log.Info("\n\nAdellian has finished installing. Please reboot your computer. There may be left over files such as the Adellian Bootstrap Script of which you will have to delete.");
	exit();

# Ignition
if (__name__ == '__main__'):
	TSN_Abstracter.Require_Version((3,3,0));
	Config.Logger.Print_Level = 15;
	Config.Logger.Display_Date = False;
	Config.Logger.File = True;
	Log.Delete();
	Bootstrap();