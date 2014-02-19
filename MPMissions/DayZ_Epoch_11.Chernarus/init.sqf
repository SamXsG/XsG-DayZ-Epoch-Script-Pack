/*	
	For DayZ Epoch
	Addons Credits: Jetski Yanahui by Kol9yN, Zakat, Gerasimow9, YuraPetrov, zGuba, A.Karagod, IceBreakr, Sahbazz
*/
//Set Script On/Off values (XsG)
_scriptvariables = execVM "scriptvariables.sqf";
waitUntil {scriptDone _scriptvariables};


startLoadingScreen ["","RscDisplayLoadCustom"];
cutText ["","BLACK OUT"];
enableSaving [false, false];

//REALLY IMPORTANT VALUES
dayZ_instance =	11;					//The instance
dayzHiveRequest = [];
initialized = false;
dayz_previousID = 0;

//disable greeting menu 
player setVariable ["BIS_noCoreConversations", true];
//disable radio messages to be heard and shown in the left lower corner of the screen
enableRadio false;
// May prevent "how are you civillian?" messages from NPC
enableSentences false;

// DayZ Epoch config
dayz_MapArea = 14000; // Default = 10000
DZE_teleport = [99999,99999,99999,99999,99999];
dayz_minpos = 0; 
dayz_maxpos = 16000;
DZE_BuildOnRoads = false; // Default: False


//Load in compiled functions
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf";				//Initilize the Variables (IMPORTANT: Must happen very early)
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";				//Initilize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";	//Functions used by CLIENT for medical
progressLoadingScreen 0.4;
if (IsDebugMonitorOn) then {
	call compile preprocessFileLineNumbers "custom\compiles.sqf";		//Debug Monitor On
	} else {
		call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";		//Compile regular functions
};
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf";				//Compile regular functions
progressLoadingScreen 0.5;
call compile preprocessFileLineNumbers "server_traders.sqf";				//Compile trader configs
if (IsSelfBloodBagOn) then {
call compile preprocessFileLineNumbers "SelfBloodBag\compiles.sqf";        //Self Blood Bag Addition (XsG)
};
progressLoadingScreen 1.0;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";
if (IsDebugMonitorOn) then {
	playerstats = compile preprocessFileLineNumbers "custom\playerstats.sqf"; //Playerstats for Debug Monitor
};

if (isServer) then {
	call compile preprocessFileLineNumbers "\z\addons\dayz_server\missions\DayZ_Epoch_11.Chernarus\dynamic_vehicle.sqf";
	//Compile vehicle configs
	
	// Add trader citys
	_nil = [] execVM "\z\addons\dayz_server\missions\DayZ_Epoch_11.Chernarus\mission.sqf";
	_serverMonitor = 	[] execVM "\z\addons\dayz_code\system\server_monitor.sqf";
};

if (!isDedicated) then {
	//Conduct map operations
	0 fadeSound 0;
	waitUntil {!isNil "dayz_loadScreenMsg"};
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");
	
	//Run the player monitor
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";	
	
	// Anti Hack 
	//	[] execVM "\z\addons\dayz_code\system\antihack.sqf";
	
	
	//Lights
	//[false,12] execVM "\z\addons\dayz_code\compile\local_lights_init.sqf";
};


#include "\z\addons\dayz_code\system\REsec.sqf"


//Start Dynamic Weather

execVM "\z\addons\dayz_code\external\DynamicWeatherEffects.sqf";


#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"

//Script Pack Enabling Code
//R3F trigger Also in description.ext (XsG)
if (IsTowOn) then {
	execVM "R3F_ARTY_AND_LOG\init.sqf"; //Call R3F Log to enable Towing
};

//Enable Missions (other code enables)
if (IsMissionsOn) then {
	execVM "faction.sqf"; //Needed to enable DayZ Chernarus Missions
};

//Enable SAR AI (also in description.ext)
if (IsSarAIOn) then {
	call compile preprocessFileLineNumbers "addons\UPSMON\scripts\Init_UPSMON.sqf";
	call compile preprocessfile "addons\SHK_pos\shk_pos_init.sqf";
	execVM "addons\SARGE\SAR_AI_init.sqf";
};
if (IsSarAIWithMissionsOn) then {
	call compile preprocessFileLineNumbers "addons\UPSMON\scripts\Init_UPSMON.sqf";
	call compile preprocessfile "addons\SHK_pos\shk_pos_init.sqf";
	execVM "addons\SARGE\SAR_AI_init.sqf";
};

//Enable BluePhoenix Admin tools
if (IsBPAdminToolOn) then {
	execVM "admintools\Activate.sqf";
};
