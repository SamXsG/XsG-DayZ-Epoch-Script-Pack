//Enable/Disable scripts
IsTowOn = false;
IsSelfBloodBagOn = false;
IsMissionsOn = false; //Do not enable if SarAI is on. Use IsMissionsAndSarAION for running both
IsSarAIOn = false; //Do not enable if Missions is on. Use IsMissionsAndSarAION for running both
IsSarAIWithMissionsOn = false;
IsBPAdminToolOn = false;
IsDebugMonitorOn = false;


//BluePhoenix's Admin Tools - Admins List - Enter UID to set an Admin
AdminUID1="12345678";
AdminUID2="12345678";
AdminUID3="12345678";


//Starting Loadout -- Start Gear
DefaultMagazines = ["ItemBandage","ItemPainkiller"]; 
DefaultWeapons = ["ItemFlashlight"];  
DefaultBackpack = "";  
DefaultBackpackWeapon = "";



// DayZ Epoch settings
spawnShoremode = 1; // Default = 1 (on shore)
spawnArea= 1500; // Default = 1500


MaxVehicleLimit = 200; // Default = 50
MaxDynamicDebris = 100; // Default = 100
dayz_maxLocalZombies = 20; // Default = 30 

dayz_paraSpawn = false;
dayz_maxAnimals = 8; // Default: 8
dayz_tameDogs = true;

DynamicVehicleDamageLow = 0; // Default: 0
DynamicVehicleDamageHigh = 0; // Default: 100
dayz_fullMoonNights = true;

EpochEvents = [["any","any","any","any",30,"crash_spawner"],["any","any","any","any",0,"crash_spawner"],["any","any","any","any",15,"supply_drop"]];

dayz_sellDistance_vehicle = 10;
dayz_sellDistance_boat = 30;
dayz_sellDistance_air = 40;

DZE_TRADER_SPAWNMODE = false; //Setting to true spawns purchased vehicles by parachute




//Do not edit below this line
if (IsMissionsOn && IsSarAIOn) then {
IsMissionsOn = false;
IsSarAIOn = false;
};
IsSCAdminToolOn = false;