from TSN_Abstracter import *;
import subprocess;
import shutil;

# Might wanna push this one to TSN_Abstracter
def Shell_Run(Command: str) -> subprocess.CompletedProcess:
	Process: subprocess.CompletedProcess = subprocess.run(Command, shell=True, stdout=subprocess.PIPE, text=True);
	Log.Stateless(Process.stdout.replace("\n", ""));
	Log.Debug(f"Process exited with code {Process.returncode} | STDOUT: {Process.stdout}");
	return Process;

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

def DownloadRepo_RootFS() -> None:
	if (File.Exists("/System/Adellian/RootFS")):
		Log.Warning(f"The Adellian RootFS Repository was left undeleted from a previous installation attempt.");
		shutil.rmtree("/System/Adellian/RootFS");

	Log.Info(f"Downloading Adellian RootFS...");
	Process: subprocess.CompletedProcess = Shell_Run(f"git clone https://github.com/Ascellayn/Adellian_RootFS /System/Adellian/RootFS");
	if (Process.returncode == 0): Log.Fetch_ALog().OK(); return;

	Log.Fetch_ALog().ERROR(f"Process exited with code {Process.returncode}");
	Log.Critical(f"An error occurred while downloading crucial Adellian Files. The installer will now exit.\n[ERROR]: {Process.stdout}");
	exit();

# RootFS Installers
def Install_RootFS(Branch: str) -> None:
	Log.Info(f"Installing Adellian's {Branch} RootFS...");
	Process: subprocess.CompletedProcess = Shell_Run(f"cp -R -v /System/Adellian/RootFS/{Branch}_RootFS /");
	if (Process.returncode == 0): Log.Fetch_ALog().OK(); return;

	Log.Fetch_ALog().ERROR(f"Process exited with code {Process.returncode}");
	Log.Critical(f"An error occurred while installing the {Branch} Adellian RootFS. The installer will now exit.\n[ERROR]: {Process.stdout}");
	exit();


def Bootstrap() -> None:
	DownloadRepo_RootFS();
	Install_RootFS("Universal");


# Ignition
if (__name__ == '__main__'):
	Log.Delete(); TSN_Abstracter.Require_Version((3,3,0));
	Config.Logger.Print_Level = 15;
	Config.Logger.Display_Date = False;
	Config.Logger.File = True;

	Log.Stateless(Adellian_Logo);
	Log.Info("Adellian Installer v250824_DEV");
	Bootstrap();