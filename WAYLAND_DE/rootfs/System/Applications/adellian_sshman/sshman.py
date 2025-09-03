import subprocess
import json
import os
import time
import math

Application_Name = "Adellian SSH Connection Manager"
Application_Desc = "A Python-based SSH utility to manage mounting or connecting to SSH Servers."
Application_Vers = "v250524"

Debug_Force = True

def log(Log, Debug):
	if Debug == False or Debug_Force == True:
		print(Log)

def nl(): # New Line
	print("")

def DoNothing(): # BEST FUNCTION
	return

class SSH:
	def __init__(self, server):
		self.name = server["name"]
		self.address = server["address"]
		self.port = server["port"]
		self.user = server["user"]
		self.sshkey = server["sshkey"]
		self.remote_folder = server["remote_folder"]
		self.mount_point = server["mount_point"]
		self.reachable = False
		self.latency = "Unreachable"

	def mount(self):
		log(f"Mounting {self.address} to {self.mount_point} as {self.user}...",False)
		cmd = f'/usr/bin/sshfs -oIdentityFile={self.sshkey} -p {self.port} {self.user}@{self.address}:{self.remote_folder} {self.mount_point}'
		log(f'Running "{cmd}".',True)
		subprocess.run(cmd, shell=True)

	def unmount(self):
		log(f"Unmounting {self.mount_point} ({self.name})...",False)
		cmd = f'umount {self.mount_point}'
		log(f'Running "{cmd}".',True)
		subprocess.run(cmd, shell=True)

	def connect(self):
		log(f"Connecting to {self.address} as {self.user}...",False)
		cmd = f'TERM=xterm-256color /usr/bin/ssh -oIdentityFile={self.sshkey} -p {self.port} {self.user}@{self.address}'
		log(f'Running "{cmd}".',True)
		subprocess.run(cmd, shell=True)

	def ping(self):
		log(f"Pinging {self.address}...",True)
		cmd = f'/usr/bin/ping {self.address} -c 1 -W 1'
		latency_init = time.monotonic()
		result = subprocess.run(cmd, shell=True, capture_output=True)
		if "100% packet loss" in str(result.stdout):
			log(f"Failed to ping {self.name}!",True)
			return [False,"Unreachable"]
		else:
			latency = math.ceil((time.monotonic() - latency_init)*1000)
			log(f"Pinged successfully {self.name} in {latency}ms.",True)
			return [True,f"{latency}ms"]


def LoadJSON():
	global ServerJSON
	try:
		with open("entries.json", "r", encoding="UTF-8") as Entries:
			ServerJSON = json.load(Entries)
	except:
		log(f'"entries.json was not found, creating..."',True)
		with open("entries.json", "w", encoding="UTF-8") as Entries:
			Entries.write("{}")
			ServerJSON = {}

def ClassifyJSON():
	global Servers
	Servers = []
	print(f"\nSaved Servers:")
	for cycle in ServerJSON.keys():
		Servers.append(SSH(ServerJSON[cycle]))
		print(f"{ServerJSON[cycle]['name']} ({ServerJSON[cycle]['user']})")

def ReachAll():
	for cycle in Servers:
		log(f"Attempting to reach {cycle.name}...",True)
		server = cycle.ping()
		if server[0] == True:
			cycle.reachable = True
			cycle.latency = server[1]
			log(f"Reached {cycle.name} in {cycle.latency}.",True)
		else:
			log(f"Failed to reach {cycle.name}.",True)

def CatchInput(text):
	UserInput = input(text)
	try: UserInput = UserInput.upper()
	except: DoNothing()
	try: UserInput = int(UserInput)
	except: DoNothing()
	return UserInput

""" Menus and user-controlled actions """

def Entry_Add():
	nl()
	nl()
	log(f"Please enter the prompted server information.",False)
	nl()
	Entry = {}
	Entry["name"] = input("Server Display Name: ")
	Entry["address"] = input("Server Address: ")
	Entry["port"] = input("Server Port: ")
	Entry["user"] = input("User to log on as: ")
	log(f"The following information requires ABSOLUTE paths!",False)
	Entry["sshkey"] = input("Path of your SSH Key: ")
	Entry["remote_folder"] = input("Path of the remote folder to mount: ")
	Entry["mount_point"] = input("Path of the local mount point: ")
	nl()

	log(f'================================',False)
	log(Entry["name"],False)
	log(f'{Entry["user"]}@{Entry["address"]}:{Entry["port"]}',False)
	log(f'Remote Folder = {Entry["remote_folder"]}',False)
	log(f'Local Mount Point = {Entry["mount_point"]}',False)
	log(f'SSH Key Location = {Entry["sshkey"]}',False)
	log(f'================================',False)

	UIn = CatchInput("Is this information correct? (y/n): ")
	match UIn:
		case "Y":
			CreationDate = time.ctime()
			log(f"Reloading server entries...",False)
			LoadJSON()

			log(f"Writing new entry...",False)
			ServerJSON[f"{CreationDate}"] = Entry
			with open("entries.json", "w", encoding="UTF-8") as Entries:
				Entries.write(json.dumps(ServerJSON, indent = 1))
			ClassifyJSON()

			log(f"Testing server reachability...",False)
			ReachAll()
			log(f"Added new entry!",False)
		case "N":
			log(f"Returning to the main menu...",False)
	return

def Menu_ServerAction(server):
	nl()
	log(f"Server Information:",False)
	log(f"{server.name} ({server.latency})",False)
	log(f"{server.user}@{server.address}:{server.port}",False)
	log(f"Remote Folder = {server.remote_folder}",False)
	log(f"Local Mount Point = {server.mount_point}",False)
	log(f"SSH Key Location = {server.sshkey}",False)


	nl()
	log(f"What would you like to do with {server.name}?",False)
	log(f"[C] | Connect via SSH",False)
	log(f'[M] | Mount via SSHFS the remote folder "{server.remote_folder}"',False)
	log(f'[U] | Unmount SSHFS',False)
	nl()
	log(f'[E] | Edit this entry',False)
	log(f'[D] | Delete this entry',False)
	log(f'[Q] | Return to the main menu',False)

	UIn = CatchInput("Enter Choice: ")
	match UIn:
		case "C":
			server.connect()
		case "M":
			server.mount()
		case "U":
			server.unmount()
		case "E":
			Entry_Edit(server)
		case "D":
			Entry_Delete(server)
		case "Q":
			Menu_ServerList()

def Menu_ServerList():
	nl()
	log(f"Available servers:",False)
	id = -1 # Yes this is jank but I can't be fucked
	for cycle in Servers:
		id+=1
		log(f"[{id}] | {cycle.name} ({cycle.user}) - [{cycle.latency}]",False)
	nl()
	log(f"[C] | Add new server entry",False)
	log(f"[Q] | Quit SSHMan",False)

	UIn = CatchInput("Enter Choice: ")
	match UIn:
		case "C":
			Entry_Add()
		case "Q":
			log(f"Quitting...",False)
			nl()
			exit()
	try: # Note: Try Band-aid fix.
		if UIn < len(Servers): # Issue with strings, tbd fix
			Menu_ServerAction(Servers[UIn])
		else:
			Menu_ServerList()
	except:
		DoNothing()
	Menu_ServerList()

if __name__ == '__main__':
	subprocess.run("clear")
	log(f"{Application_Name} - {Application_Vers}",False)
	log(f"{Application_Desc}",False)
	nl()

	# Fix the script running anywhere and thus not being in the correct folder
	log(f"Fixing file path...",False)
	fileloc = os.path.abspath(__file__)
	apploc = os.path.dirname(fileloc)
	os.chdir(apploc)

	# Load the server entries and correctly put them individually in classes
	log(f"Loading server entries...",False)
	LoadJSON()
	ClassifyJSON()

	log(f"Testing server reachability...",False)
	ReachAll()

	Menu_ServerList()
