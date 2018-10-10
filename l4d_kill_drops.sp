#include <sourcemod>
#include <sdktools>
#include <sdktools_functions>
#include <l4d2_weapon_stocks>
#define CVAR_FLAGS FCVAR_PLUGIN
#define PLUGIN_VERSION "22"

#define ZOMBIECLASS_SMOKER	1
#define ZOMBIECLASS_BOOMER	2
#define ZOMBIECLASS_HUNTER	3
#define ZOMBIECLASS_SPITTER	4
#define ZOMBIECLASS_JOCKEY	5
#define ZOMBIECLASS_CHARGER	6
new ZOMBIECLASS_TANK=	5;
new L4D2Version=false;

public Plugin:myinfo = 
{
	name = "Recover And Drop",
	author = "Pan Xiaohai",
	description = "Recover And Drop",
	version = "1.23",
	url = "http://forums.alliedmods.net"
}

new Handle:l4d_loot_enabled;
 
new Handle:l4d_loot_boss_show_msg;
new Handle:l4d_kill_show_msg;
 
 

new Handle:l4d_loot_hunter;
new Handle:l4d_loot_boomer;
new Handle:l4d_loot_smoker;
new Handle:l4d_loot_spitter;
new Handle:l4d_loot_jockey;
new Handle:l4d_loot_charger;
new Handle:l4d_loot_tank;
new Handle:l4d_loot_witch;

new Handle:l4d_loot_hunter_num;
new Handle:l4d_loot_boomer_num;
new Handle:l4d_loot_smoker_num;
new Handle:l4d_loot_spitter_num;
new Handle:l4d_loot_jockey_num ;
new Handle:l4d_loot_charger_num;
new Handle:l4d_loot_tank_num;
new Handle:l4d_loot_witch_num;


new Handle:l4d_loot_killtank_reward;
new Handle:l4d_loot_killwitch_reward;	
 

new Handle:l4d_kill_addhp_enabled;
new Handle:l4d_kill_addhp_lt50_mult;

new Handle:l4d_kill_addhp_distance;



new Handle: l4d_kill_addhp_weapon_pistol_1 ;
new Handle: l4d_kill_addhp_weapon_msg_1 ;
new Handle: l4d_kill_addhp_weapon_rifle_1 ;
new Handle: l4d_kill_addhp_weapon_sniper_1 ;
new Handle: l4d_kill_addhp_weapon_shotgun_1 ;
new Handle: l4d_kill_addhp_weapon_melee ;
  
new Handle: l4d_kill_addhp_weapon_pistol_2 ;
new Handle: l4d_kill_addhp_weapon_msg_2 ;
new Handle: l4d_kill_addhp_weapon_rifle_2 ;
new Handle: l4d_kill_addhp_weapon_sniper_2 ;
new Handle: l4d_kill_addhp_weapon_shotgun_2 ;
new Handle: l4d_kill_addhp_weapon_other;

new Handle: l4d_kill_addhp_hunter_1 ;
new Handle: l4d_kill_addhp_smoker_1 ;
new Handle: l4d_kill_addhp_boomer_1 ;
new Handle: l4d_kill_addhp_spitter_1 ;
new Handle: l4d_kill_addhp_jockey_1 ;
new Handle: l4d_kill_addhp_charger_1 ; 

new Handle: l4d_kill_addhp_hunter_2 ;
new Handle: l4d_kill_addhp_smoker_2 ;
new Handle: l4d_kill_addhp_boomer_2 ;
new Handle: l4d_kill_addhp_spitter_2 ;
new Handle: l4d_kill_addhp_jockey_2 ;
new Handle: l4d_kill_addhp_charger_2 ; 
 
new Handle:l4d_kill_addhp_tank;
new Handle:l4d_kill_addhp_witch;	
 

new Handle:l4d_kill_addhp_mult;
new Handle:l4d_loot_headshot ;
new Handle:l4d_loot_headshotno ;

new Handle:l4d_kill_addhp_headshot_mult;
new Handle:l4d_kill_addhp_noheadshot_mult;

new Handle:l4d_kill_addhp_healthlimit;

new Handle:l4d_loot_weapon;
new Handle:l4d_loot_weapon_melee;
new Handle:l4d_loot_health;
new Handle:l4d_loot_item;
 
public OnMapStart()
{
	PrecacheModel( "models/weapons/melee/v_bat.mdl", true );
	PrecacheModel( "models/weapons/melee/v_cricket_bat.mdl", true );
	PrecacheModel( "models/weapons/melee/v_crowbar.mdl", true );
	PrecacheModel( "models/weapons/melee/v_electric_guitar.mdl", true );
	PrecacheModel( "models/weapons/melee/v_fireaxe.mdl", true );
	PrecacheModel( "models/weapons/melee/v_frying_pan.mdl", true );
	PrecacheModel( "models/weapons/melee/v_golfclub.mdl", true );
	PrecacheModel( "models/weapons/melee/v_katana.mdl", true );
	PrecacheModel( "models/weapons/melee/v_machete.mdl", true );
	PrecacheModel( "models/weapons/melee/v_tonfa.mdl", true );
	
	PrecacheModel( "models/weapons/melee/w_bat.mdl", true );
	PrecacheModel( "models/weapons/melee/w_cricket_bat.mdl", true );
	PrecacheModel( "models/weapons/melee/w_crowbar.mdl", true );
	PrecacheModel( "models/weapons/melee/w_electric_guitar.mdl", true );
	PrecacheModel( "models/weapons/melee/w_fireaxe.mdl", true );
	PrecacheModel( "models/weapons/melee/w_frying_pan.mdl", true );
	PrecacheModel( "models/weapons/melee/w_golfclub.mdl", true );
	PrecacheModel( "models/weapons/melee/w_katana.mdl", true );
	PrecacheModel( "models/weapons/melee/w_machete.mdl", true );
	PrecacheModel( "models/weapons/melee/w_tonfa.mdl", true );
	
	PrecacheGeneric( "scripts/melee/baseball_bat.txt", true );
	PrecacheGeneric( "scripts/melee/cricket_bat.txt", true );
	PrecacheGeneric( "scripts/melee/crowbar.txt", true );
	PrecacheGeneric( "scripts/melee/electric_guitar.txt", true );
	PrecacheGeneric( "scripts/melee/fireaxe.txt", true );
	PrecacheGeneric( "scripts/melee/frying_pan.txt", true );
	PrecacheGeneric( "scripts/melee/golfclub.txt", true );
	PrecacheGeneric( "scripts/melee/katana.txt", true );
	PrecacheGeneric( "scripts/melee/machete.txt", true );
	PrecacheGeneric( "scripts/melee/tonfa.txt", true );
}
public void OnPluginStart() {
	SetRandomSeed(GetSysTickCount());
	
 	l4d_loot_enabled = CreateConVar("l4d_loot_enabled", "1", "0: disable loot from boss, 1: enable", FCVAR_PLUGIN);
	l4d_loot_boss_show_msg = CreateConVar("l4d_loot_boss_show_msg", "1", "0:disable print loot message in HintBox, 1:disable ", FCVAR_PLUGIN);
 
	l4d_loot_hunter = CreateConVar("l4d_loot_hunter", "4.0", "loot of hunter %[0-100]", FCVAR_PLUGIN);
	l4d_loot_smoker = CreateConVar("l4d_loot_smoker", "5.0", "loot of smoker %[0-100]", FCVAR_PLUGIN);
	l4d_loot_boomer = CreateConVar("l4d_loot_boomer", "5.0", "loot of Boomer %[0-100]", FCVAR_PLUGIN);
	l4d_loot_spitter = CreateConVar("l4d_loot_spitter", "4.0", "loot of spitter %[0-100]", FCVAR_PLUGIN);
	l4d_loot_jockey = CreateConVar("l4d_loot_jockey", "4.0", "loot of jockey %[0-100]", FCVAR_PLUGIN);
	l4d_loot_charger = CreateConVar("l4d_loot_charger", "4.0", "loot of charger %[0-100]", FCVAR_PLUGIN);
	l4d_loot_tank = CreateConVar("l4d_loot_tank", "70", "loot of tank %[0-100]", FCVAR_PLUGIN);
	l4d_loot_witch = CreateConVar("l4d_loot_witch", "60", "loot of witch %[0-100]", FCVAR_PLUGIN);

	l4d_loot_hunter_num = CreateConVar("l4d_loot_hunter_num", "1", "loot count of hunter ", FCVAR_PLUGIN);
	l4d_loot_smoker_num = CreateConVar("l4d_loot_smoker_num", "1", "loot count of smoker ", FCVAR_PLUGIN);
	l4d_loot_boomer_num = CreateConVar("l4d_loot_boomer_num", "1", "loot count of Boomer ", FCVAR_PLUGIN);	
	l4d_loot_spitter_num = CreateConVar("l4d_loot_spitter_num", "1", "loot count of spitter ", FCVAR_PLUGIN);
	l4d_loot_jockey_num = CreateConVar("l4d_loot_jockey_num", "1", "loot count of jockey ", FCVAR_PLUGIN);
	l4d_loot_charger_num = CreateConVar("l4d_loot_charger_num", "1", "loot count of charger ", FCVAR_PLUGIN);
	l4d_loot_tank_num = CreateConVar("l4d_loot_tank_num", "4", "loot count of tank ", FCVAR_PLUGIN);
	l4d_loot_witch_num = CreateConVar("l4d_loot_witch_num", "3", "loot count of witch ", FCVAR_PLUGIN);

	l4d_loot_headshot = CreateConVar("l4d_loot_headshot", "3.0", "loot factor with headshot", FCVAR_PLUGIN);
 	l4d_loot_headshotno = CreateConVar("l4d_loot_headshotno", "1.0", "loot factor without headshot", FCVAR_PLUGIN);
   
  
	l4d_loot_killtank_reward = CreateConVar("l4d_loot_killtank_reward", "60", "probability of reward for kill tank %[0-100]", FCVAR_PLUGIN);
	l4d_loot_killwitch_reward = CreateConVar("l4d_loot_killwitch_reward", "50", "probability of reward for kill witch %[0-100]", FCVAR_PLUGIN);
  	l4d_kill_addhp_tank = CreateConVar("l4d_kill_addhp_tank", "50", "health recover for kill tank", FCVAR_PLUGIN);
	l4d_kill_addhp_witch = CreateConVar("l4d_kill_addhp_witch", "50", "health recover for kill witch", FCVAR_PLUGIN);
 
	l4d_loot_weapon = CreateConVar("l4d_loot_weapon", "25.0", "probability of loot guns %", FCVAR_PLUGIN);
	l4d_loot_weapon_melee = CreateConVar("l4d_loot_weapon_melee", "25.0", "probability of loot melee weapon %", FCVAR_PLUGIN);
	l4d_loot_health = CreateConVar("l4d_loot_health", "15.0", "probability of loot Medical supplies %", FCVAR_PLUGIN);
	l4d_loot_item = CreateConVar("l4d_loot_item", "35.0", "probability of loot items %", FCVAR_PLUGIN);

	l4d_kill_addhp_enabled = CreateConVar("l4d_kill_addhp_enabled", "1", "0: disable health recover, 1:eanble", FCVAR_PLUGIN);
	l4d_kill_addhp_mult = CreateConVar("l4d_kill_addhp_mult", "0.15", "health recover factor", FCVAR_PLUGIN);
	l4d_kill_addhp_lt50_mult = CreateConVar("l4d_kill_addhp_lt50_mult", "3.0", "health recover factor when health < 50", FCVAR_PLUGIN);
	l4d_kill_addhp_healthlimit = CreateConVar("l4d_kill_addhp_healthlimit", "200.0", "health limit", FCVAR_PLUGIN);

	l4d_kill_show_msg = CreateConVar("l4d_kill_show_msg", "3", "print kill messge 1:in chatŒ2: int hintbox, 3:all, 0:disable", FCVAR_PLUGIN);


	l4d_kill_addhp_noheadshot_mult = CreateConVar("l4d_kill_addhp_noheadshot_mult", "1.0", "health recover multiple without headshot ", FCVAR_PLUGIN);
	l4d_kill_addhp_headshot_mult = CreateConVar("l4d_kill_addhp_headshot_mult", "3.0", "health recover multiple with headshot ", FCVAR_PLUGIN);

	l4d_kill_addhp_weapon_pistol_1 = CreateConVar("l4d_kill_addhp_weapon_pistol_1", "8.0", "health recover factor of pistol killing", FCVAR_PLUGIN);
	l4d_kill_addhp_weapon_msg_1 = CreateConVar("l4d_kill_addhp_weapon_msg_1", "4.0", "health recover factor of smg", FCVAR_PLUGIN);
	l4d_kill_addhp_weapon_rifle_1 = CreateConVar("l4d_kill_addhp_weapon_rifle_1", "3.0", "health recover factor of rifle killing", FCVAR_PLUGIN);
	l4d_kill_addhp_weapon_sniper_1 = CreateConVar("l4d_kill_addhp_weapon_sniper_1", "4.0", "health recover factor of sniper killing", FCVAR_PLUGIN);
	l4d_kill_addhp_weapon_shotgun_1 = CreateConVar("l4d_kill_addhp_weapon_shotgun_1", "2.0", "health recover factor of shotgun killing", FCVAR_PLUGIN);
	l4d_kill_addhp_weapon_melee = CreateConVar("l4d_kill_addhp_weapon_melee", "30.0", "health recover factor of melee killing", FCVAR_PLUGIN);
	l4d_kill_addhp_weapon_other = CreateConVar("l4d_kill_addhp_weapon_other", "1.0", "health recover factor of ohter weapon killing", FCVAR_PLUGIN);
  
	l4d_kill_addhp_weapon_pistol_2 = CreateConVar("l4d_kill_addhp_weapon_pistol_2", "30.0", "health recover factor of long range pistol killing", FCVAR_PLUGIN);
	l4d_kill_addhp_weapon_msg_2 = CreateConVar("l4d_kill_addhp_weapon_msg_2", "16.0", "health recover factor of long range smg killing", FCVAR_PLUGIN);
	l4d_kill_addhp_weapon_rifle_2 = CreateConVar("l4d_kill_addhp_weapon_rifle_2", "13.0", "health recover factor of long range rifle killing", FCVAR_PLUGIN);
	l4d_kill_addhp_weapon_sniper_2 = CreateConVar("l4d_kill_addhp_weapon_sniper_2", "12.0", "health recover factor of long range sniper killing", FCVAR_PLUGIN);
	l4d_kill_addhp_weapon_shotgun_2 = CreateConVar("l4d_kill_addhp_weapon_shotgun_2", "20.0", "health recover factor of long range shotgun killing", FCVAR_PLUGIN);

 	l4d_kill_addhp_distance = CreateConVar("l4d_kill_addhp_distance", "1200.0", "long range", FCVAR_PLUGIN);

 	l4d_kill_addhp_hunter_1 = CreateConVar("l4d_kill_addhp_hunter_1", "1.0", "health recover factor for hunter killing", FCVAR_PLUGIN);
 	l4d_kill_addhp_smoker_1 = CreateConVar("l4d_kill_addhp_smoker_1", "1.0", "health recover factor for smoker killing", FCVAR_PLUGIN);
 	l4d_kill_addhp_boomer_1 = CreateConVar("l4d_kill_addhp_boomer_1", "1.0", "health recover factor for boomer killing", FCVAR_PLUGIN);
 	l4d_kill_addhp_spitter_1 = CreateConVar("l4d_kill_addhp_spitter_1", "1.0", "health recover factor for spitter killing", FCVAR_PLUGIN);
 	l4d_kill_addhp_jockey_1 = CreateConVar("l4d_kill_addhp_jockey_1", "1.0", "health recover factor for jockey killing", FCVAR_PLUGIN);
 	l4d_kill_addhp_charger_1 = CreateConVar("l4d_kill_addhp_charger_1", "1.0", "health recover factor for charger killing", FCVAR_PLUGIN);

 	l4d_kill_addhp_hunter_2 = CreateConVar("l4d_kill_addhp_hunter_2", "5.0", "health recover factor for long range hunter killing", FCVAR_PLUGIN);
 	l4d_kill_addhp_smoker_2 = CreateConVar("l4d_kill_addhp_smoker_2", "3.0", "health recover factor for long range smoker killing", FCVAR_PLUGIN);
 	l4d_kill_addhp_boomer_2 = CreateConVar("l4d_kill_addhp_boomer_2", "2.0", "health recover factor for long range boomer killing", FCVAR_PLUGIN);
 	l4d_kill_addhp_spitter_2 = CreateConVar("l4d_kill_addhp_spitter_2", "3.0", "health recover factor for long range spitter killing", FCVAR_PLUGIN);
 	l4d_kill_addhp_jockey_2 = CreateConVar("l4d_kill_addhp_jockey_2", "3.0", "health recover factor for long range jockey killing", FCVAR_PLUGIN);
 	l4d_kill_addhp_charger_2 = CreateConVar("l4d_kill_addhp_charger_2", "4.0", "health recover factor for long range charger killing", FCVAR_PLUGIN);


	AutoExecConfig(true, "kill_drop_v22");
 
	decl String:GameName[16];
	GetGameFolderName(GameName, sizeof(GameName));
	if (L4DW_GetL4DVer() >= 2) {	// L4D2
		ZOMBIECLASS_TANK=8;
		L4D2Version=true;
	} else if (L4DW_GetL4DVer() == 1){	// L4D
		ZOMBIECLASS_TANK=5;
		L4D2Version=false;
	} else {
		SetFailState("l4d_kill_drops only supports on L4D and L4D2!");
	}
 
	HookEvent("player_incapacitated_start", Event_PlayerIncapacitated);
	HookEvent("player_death", Event_PlayerDeath);
	HookEvent("witch_killed", Event_WitchKilled); 
}

public bool ShowKillMsgOnChat() {
	int d = GetConVarInt(l4d_kill_show_msg);
	return d==1 || d==3;
}
public bool ShowKillMsgOnPanel() {
	int d = GetConVarInt(l4d_kill_show_msg);
	return d==2 || d==3;
}
 
void AddHealth(int client, float add)
{
	if(add<=0.0)
		return;
	int hardhp = GetClientHealth(client) + 0; 

	if(GetClientTeam(client) == 2) {
		int addhp;
		float fhp=hardhp*1.0;
		float newhp=add;
		if(fhp<50.0) {
			newhp = add*(1.0+ (50.0-fhp)*GetConVarFloat(l4d_kill_addhp_lt50_mult)/50.0);
		}
		addhp = RoundFloat(newhp);
		if(hardhp+addhp<=RoundFloat(GetConVarFloat(l4d_kill_addhp_healthlimit)))
			SetEntityHealth(client, hardhp + addhp);
		else
			SetEntityHealth(client, RoundFloat(GetConVarFloat(l4d_kill_addhp_healthlimit)));
	}
	return;
}
 

public Action Event_WitchKilled(Event event, const char[] name, bool dontBroadcast) {
	if(GetConVarInt(l4d_loot_enabled) == 0)
		return Plugin_Continue;
	
	int ClientId = GetClientOfUserId(event.GetInt("userid"));
	
	// Get the position of the witch
	int WitchId = event.GetInt("witchid");
	float position[3];
	GetEntPropVector(WitchId, Prop_Send, "m_vecOrigin", position);
	PrintToChatAll("WitchPos = (%f,%f,%f)", position[0], position[1], position[2]);
	PrintToChatAll("L4DVersion = %d", L4D2Version ? 2 : 1);
	if(!IsValidClient(ClientId))
		return Plugin_Continue;

	if(GetClientTeam(ClientId) != 2)
		return Plugin_Continue;

	int r = GetRandomInt(0, 100);
 	if(r < RoundFloat(GetConVarFloat(l4d_loot_killwitch_reward))) {
		int r1 = GetRandomInt(0, L4D2Version ? 3 : 1);

		if(r1==0) {
			SpawnWeapon(WEPID_FIRST_AID_KIT, position);
			PrintToChatAll("\x04Witch\x03 finally killed by \x04%N \x03and earned a \x04first aid kit",ClientId);
 		} else if(r1==1) {
			SpawnWeapon(WEPID_PAIN_PILLS, position);
			PrintToChatAll("\x04Witch\x03 finally killed by \x04%N \x03and earned a \x04pills",ClientId);
		} else if(r1==2) {
			SpawnWeapon(WEPID_ADRENALINE, position);
			PrintToChatAll("\x04Witch\x03 finally killed by \x04%N \x03and earned a \x04adrenaline",ClientId);
		} if(r1==3) {
			SpawnWeapon(WEPID_DEFIBRILLATOR, position);
			PrintToChatAll("\x04Witch\x03 finally killed by \x04%N \x03and earned a \x04defibrillator",ClientId);
		}
	} else {
		PrintToChatAll("\x04Witch\x03 finally killed by\x04 %N \x03",ClientId);
	}

	decl String:buff[165];
	Format(buff, sizeof(buff), "Witch was robbed by %N", ClientId);
	int res = SpawnItemFromDieResult(position, GetConVarFloat(l4d_loot_witch), GetConVarFloat(l4d_loot_witch_num), buff);
	if( ShowKillMsgOnChat() && res>0)
		PrintToChatAll("\x04Witch\x03 was robbed by\x04 %N",ClientId);

	CreateTimer(5.0, BossDeadLaught);

	if(GetConVarInt(l4d_kill_addhp_enabled)>0) {
		AddHealth(ClientId, GetConVarFloat(l4d_kill_addhp_witch));
	}
	return Plugin_Continue;
}
 
public Action:Event_PlayerIncapacitated(Handle:hEvent, const String:strName[], bool:DontBroadcast)
{

	if(GetConVarInt(l4d_loot_enabled)==0)
	{
		return Plugin_Continue;
	}

	new client = GetClientOfUserId(GetEventInt(hEvent, "userid"));

	decl String:player_name[65];
	GetClientName(client, player_name, sizeof(player_name));

	decl String:buff[165];

 	new attacker = GetClientOfUserId(GetEventInt(hEvent, "attacker"));
   	
	if (attacker != 0 )
	{
		decl String:player_name2[65];
		GetClientName(attacker, player_name2, sizeof(player_name2));
		if( GetClientTeam(attacker) ==2) 
		{
			Format(buff, sizeof(buff), "\x04 %s \x03 incapacitated\x04 %s", player_name2, player_name);
			PrintToChatAll(buff);
			//PrintHintTextToAll(buff);
		}
		else if(GetClientTeam(attacker) ==3)
		{
 			Format(buff, sizeof(buff), "\x04 %s \x03 incapacitated\x04 %s", player_name2, player_name);
			PrintToChatAll(buff);
			//PrintHintTextToAll(buff);
		}
	}
	else
	{
 			Format(buff, sizeof(buff), "\x04 %s \x03incapacitated", player_name);
			PrintToChatAll(buff);
	}
	CreateTimer(3.0, IcapCry, client);

	return Plugin_Continue;
}
public Action:IcapCry(Handle:timer, any:target)
{
	ClientCommand(target, "vocalize PlayerDeath");
}



public Action Event_PlayerDeath(Handle hEvent, const char[] strName, bool DontBroadcast) {
	if(GetConVarInt(l4d_loot_enabled)==0)
		return Plugin_Continue;
	 
	int victim = GetClientOfUserId(GetEventInt(hEvent, "userid"));
 	int attacker = GetClientOfUserId(GetEventInt(hEvent, "attacker"));
		
	if (!IsValidClient(victim)) 
 		return Plugin_Continue;
	
	float victimPos[3];	// Position of the victim
	GetEntPropVector(victim, Prop_Send, "m_vecOrigin", victimPos);
	// PrintToChatAll("Event_PlayerDeath, victim.pos = [%f,%f,%f]", victimPos[0], victimPos[1], victimPos[2]);	
	
	if(GetClientTeam(victim) == 2) {
 		if (attacker != 0 ) {
 			if(GetClientTeam(attacker)==2) {

				PrintToChatAll("\x04 %N \x03killed\x04 %N ", attacker, victim);
				PrintHintTextToAll("%N killed %N ", attacker, victim);
			} else {
 				PrintToChatAll("\x04 %N \x03killed\x04 %N", attacker, victim);
				PrintHintTextToAll("%N killed %N ", attacker, victim);
			}
		} else {
			 
			PrintToChatAll("\x04 %N \x03dead", victim);
			PrintHintTextToAll("%N dead", victim);
		}
		return Plugin_Continue;
	}
	
	if(GetClientTeam(victim) != 3)
		return Plugin_Continue;

	float v1[3];
	float v2[3];
	GetClientEyePosition(victim, v1);
	if(IsValidClient(attacker))
		GetClientEyePosition(attacker, v2);	
	else
	    GetClientEyePosition(victim, v2);

	float fdist = GetVectorDistance(v1, v2);
	int dist=RoundFloat(fdist); 

	int class = GetEntProp(victim, Prop_Send, "m_zombieClass");

	bool headshot=GetEventBool(hEvent, "headshot");
	 
	float lootheadmult=1.0;
	float headhpmult=1.0;
	float kindmult=1.0;

	float weapon1=1.0;
	float weapon2=1.0;
	float weaponmult=1.0;

	float addhpmult=GetConVarFloat(l4d_kill_addhp_mult);
	int difficult=1;
	
	char weapon[65];
 	GetEventString(hEvent, "weapon", weapon,sizeof(weapon));
	if(StrContains(weapon, "pistol")>=0)
	{
		weapon1=GetConVarFloat(l4d_kill_addhp_weapon_pistol_1);
		weapon2=GetConVarFloat(l4d_kill_addhp_weapon_pistol_2);
		//PrintToChatAll("weapon : pistol ");
	}
	else if(StrContains(weapon, "smg")>=0)
	{
		weapon1=GetConVarFloat(l4d_kill_addhp_weapon_msg_1);
		weapon2=GetConVarFloat(l4d_kill_addhp_weapon_msg_2);
		//PrintToChatAll("weapon :  smg");
	}
	else if(StrContains(weapon, "hunting_rifle")>=0 || StrContains(weapon, "sniper")>=0)
	{
		weapon1=GetConVarFloat(l4d_kill_addhp_weapon_sniper_1);
		weapon2=GetConVarFloat(l4d_kill_addhp_weapon_sniper_2);
		//PrintToChatAll("weapon :  awp");
	}
	else if(StrContains(weapon, "rifle")>=0)
	{
		weapon1=GetConVarFloat(l4d_kill_addhp_weapon_rifle_1);
		weapon2=GetConVarFloat(l4d_kill_addhp_weapon_rifle_2);
		//PrintToChatAll("weapon :  rifle");
	}
	else if(StrContains(weapon, "shotgun")>=0 || StrContains(weapon, "launcher")>=0)
	{
		weapon1=GetConVarFloat(l4d_kill_addhp_weapon_shotgun_1);
		weapon2=GetConVarFloat(l4d_kill_addhp_weapon_shotgun_2);
		//PrintToChatAll("weapon :  shotgun");
	}
 	else if( StrContains(weapon, "melee")>=0 ||  StrContains(weapon, "chainsaw")>=0)
	{
		weapon1=GetConVarFloat(l4d_kill_addhp_weapon_melee);
		weapon2=GetConVarFloat(l4d_kill_addhp_weapon_melee);
		//PrintToChatAll("weapon :  other");
	}
 	else  
	{
		weapon1=GetConVarFloat(l4d_kill_addhp_weapon_other);
		weapon2=GetConVarFloat(l4d_kill_addhp_weapon_other);
		//PrintToChatAll("weapon :  other");
	}

	char name[65];
	GetClientName(attacker, name, sizeof(name));
 
	char chatmsg[165];
	char hintmsg[165];
	char lootmsg[165];
 ///////////////////////////////////////////////////////////////
 
/////////////////////////////////////////////////////////////////////////
	float loot_num;
	float loot_p;
	float y1;
	float y2;
	bool show=false;
	if (class == ZOMBIECLASS_HUNTER) {
		loot_p=GetConVarFloat(l4d_loot_hunter);
		loot_num=GetConVarFloat(l4d_loot_hunter_num);
		y1=GetConVarFloat(l4d_kill_addhp_hunter_1);
		y2=GetConVarFloat(l4d_kill_addhp_hunter_2);
		show=true;
		//PrintToChatAll("ZOMBIECLASS_HUNTER");
	} else if (class == ZOMBIECLASS_SMOKER) {
		loot_p=GetConVarFloat(l4d_loot_smoker);
		loot_num=GetConVarFloat(l4d_loot_smoker_num);
		y1=GetConVarFloat(l4d_kill_addhp_smoker_1);
		y2=GetConVarFloat(l4d_kill_addhp_smoker_2);
		show=true;
		//PrintToChatAll("ZOMBIECLASS_SMOKER");
  	}
	else if (class == ZOMBIECLASS_BOOMER) {
		loot_p=GetConVarFloat(l4d_loot_boomer);
		loot_num=GetConVarFloat(l4d_loot_boomer_num);
		y1=GetConVarFloat(l4d_kill_addhp_boomer_1);
		y2=GetConVarFloat(l4d_kill_addhp_boomer_2);
		show=true;
 		//PrintToChatAll("ZOMBIECLASS_BOOMER");
		//SpawnMelee(WEPID_MACHETE, victimPos);SpawnMelee(WEPID_BASEBALL_BAT, victimPos);SpawnMelee(WEPID_CRICKET_BAT, victimPos);
		//SpawnWeapon(WEPID_RIFLE_AK47, victimPos);
		//SpawnWeapon(WEPID_DEFIBRILLATOR, victimPos);
		//SpawnWeapon(WEPID_INCENDIARY_AMMO, victimPos);
		//SpawnWeapon(WEPID_FRAG_AMMO, victimPos);
		//SpawnWeapon(WEPID_CHAINSAW, victimPos);
		//SpawnWeapon(WEPID_ADRENALINE, victimPos);
	} else if (class == ZOMBIECLASS_SPITTER) {
		loot_p=GetConVarFloat(l4d_loot_spitter);
		loot_num=GetConVarFloat(l4d_loot_spitter_num);
		y1=GetConVarFloat(l4d_kill_addhp_spitter_1);
		y2=GetConVarFloat(l4d_kill_addhp_spitter_2);
		show=true;
		//PrintToChatAll("ZOMBIECLASS_SPITTER");
	} else if (class == ZOMBIECLASS_JOCKEY) {
		loot_p=GetConVarFloat(l4d_loot_jockey);
		loot_num=GetConVarFloat(l4d_loot_jockey_num);
		y1=GetConVarFloat(l4d_kill_addhp_jockey_1);
		y2=GetConVarFloat(l4d_kill_addhp_jockey_2);
		show=true;
		//PrintToChatAll("ZOMBIECLASS_JOCKEY");
	} else if (class == ZOMBIECLASS_CHARGER) {
		loot_p=GetConVarFloat(l4d_loot_charger);
		loot_num=GetConVarFloat(l4d_loot_charger_num);
		y1=GetConVarFloat(l4d_kill_addhp_charger_1);
		y2=GetConVarFloat(l4d_kill_addhp_charger_2);
		show=true;
		//PrintToChatAll("ZOMBIECLASS_CHARGER");
	}
	
	
	
	
	
	if(show) {
		Format(lootmsg, sizeof(lootmsg), "%N droped some thing", victim);
		if(IsValidClient(attacker))	{
			if(GetClientTeam(attacker) == 3) {
				if(ShowKillMsgOnChat())
					PrintToChatAll("\x04%N\x03 ------> \x04%N", attacker, victim);
				SpawnItemFromDieResult(victimPos, loot_p, loot_num, lootmsg);
				return Plugin_Continue;
			}
		} else {
			if(ShowKillMsgOnChat())
				PrintToChatAll("\x04%N\x03 dead", victim);
			SpawnItemFromDieResult(victimPos, loot_p, loot_num,lootmsg);
			return Plugin_Continue;
		}
 		if(headshot)
		{
			lootheadmult=GetConVarFloat(l4d_loot_headshot);
			headhpmult=GetConVarFloat(l4d_kill_addhp_headshot_mult);
			Format(hintmsg, sizeof(hintmsg),  "headshot", dist);
			Format(chatmsg, sizeof(chatmsg), "\x04%N\x03 -headshot-> \x04%N", attacker,victim);
			
			ClientCommand(attacker, "vocalize PlayerNiceShot");
			CreateTimer(1.0, OneLaught, attacker);
		} else {
			lootheadmult=GetConVarFloat(l4d_loot_headshotno);
			headhpmult=GetConVarFloat(l4d_kill_addhp_noheadshot_mult);

			Format(hintmsg, sizeof(hintmsg),  "kill", dist);
			Format(chatmsg, sizeof(chatmsg), "\x04%N\x03 ------> \x04%N", attacker,victim);
		}
 
		float x1=0.0;
		float x2=GetConVarFloat(l4d_kill_addhp_distance);

		kindmult=(fdist*(y2-y1)-x1*y2+y1*x2)/(x2-x1);

		y1=weapon1;
		y2=weapon2;
		weaponmult=(fdist*(y2-y1)-x1*y2+y1*x2)/(x2-x1);
		float addhp= headhpmult*kindmult*weaponmult*addhpmult;
		difficult=RoundFloat(addhp);
 
 		if(GetConVarInt(l4d_kill_addhp_enabled)>0)
		{
			AddHealth(attacker, addhp);
		}
		Format(hintmsg, sizeof(hintmsg),  "%s, hp + %i", hintmsg, difficult);

 		if(ShowKillMsgOnChat()) {
			Format(chatmsg, sizeof(chatmsg), "%s\x03 (%i)", chatmsg, difficult);
			PrintToChatAll(chatmsg);
		}

 		if(SpawnItemFromDieResult(victimPos, loot_p*lootheadmult, loot_num,lootmsg)==0)
 			if(ShowKillMsgOnPanel())PrintHintText(attacker, hintmsg);
	}

	if (class == ZOMBIECLASS_TANK) {
		if(IsValidClient(attacker) && GetClientTeam(attacker) == 2) {	
			int r = GetRandomInt(0, 100);
			if(r < RoundFloat(GetConVarFloat(l4d_loot_killtank_reward))) {
				int r1 = GetRandomInt(0, L4D2Version ? 3 : 1);
				if(r1==0) {
					SpawnWeapon(WEPID_FIRST_AID_KIT, victimPos);
					PrintToChatAll("\x04%N\x03 finally killed by\x04 %N \x03and earned a \x04first aid kit",victim, attacker);
 				} else if(r1==1) {
					SpawnWeapon(WEPID_PAIN_PILLS, victimPos);
					PrintToChatAll("\x04%N\x03 finally killed by\x04 %N \x03and earned a \x04pills",victim, attacker);
				} else if(r1==2) {
					SpawnWeapon(WEPID_ADRENALINE, victimPos);
					PrintToChatAll("\x04%N\x03 finally killed by\x04 %N \x03and earned a \x04adrenaline",victim, attacker);
				} else if(r1==3) {
					SpawnWeapon(WEPID_DEFIBRILLATOR, victimPos);
					PrintToChatAll("\x04%N\x03 finally killed by\x04 %N \x03and earned a \x04defibrillator",victim, attacker);
				}
			} else {
				 Format(chatmsg, sizeof(chatmsg), "\x04%N\x03 finally killed by\x04 %N",victim, attacker);
			}

			if(GetConVarInt(l4d_kill_addhp_enabled)>0)
				AddHealth(attacker, GetConVarFloat(l4d_kill_addhp_tank));
		}
 		else if(attacker==victim) {
 			Format(chatmsg, sizeof(chatmsg), "\x04%N\x03 killed self", victim);
		} else {
 			Format(chatmsg, sizeof(chatmsg), "\x04%N\x03 dead",victim);
		}
		
  		SpawnItemFromDieResult(victimPos, GetConVarFloat(l4d_loot_tank), GetConVarFloat(l4d_loot_tank_num),"Tank droped some thing");
		CreateTimer(5.0, BossDeadLaught);
 		if(ShowKillMsgOnChat())
		{
			 PrintToChatAll(chatmsg);
		} 
	}
	return Plugin_Continue;
}

public Action BossDeadLaught(Handle timer) {
	for (int i = 1; i <= MaxClients; i++) {
		if (!IsClientInGame(i))
			continue;
		if (GetClientTeam(i) == 2)
			ClientCommand(i, "vocalize PlayerLaugh");
	} 
}
public Action OneLaught(Handle timer, int target) {
	ClientCommand(target, "vocalize PlayerLaugh");
}

L4DW_WeaponId[] GiftList_Gun = {
	WEPID_RIFLE,
	WEPID_AUTOSHOTGUN,
	WEPID_HUNTING_RIFLE,
	
	WEPID_PISTOL_MAGNUM,
	WEPID_PISTOL_MAGNUM,
	WEPID_RIFLE_AK47,
	WEPID_RIFLE_AK47,
	WEPID_RIFLE_AK47,
	
	WEPID_SHOTGUN_SPAS,
	WEPID_RIFLE_DESERT,
	WEPID_RIFLE_SG552,
	
	WEPID_GRENADE_LAUNCHER,
	WEPID_SNIPER_AWP,
	WEPID_SNIPER_MILITARY,
	WEPID_SNIPER_SCOUT,
	WEPID_GRENADE_LAUNCHER
};

L4DW_MeleeWeaponId[] GiftList_Melee = {
	WEPID_FIREAXE,
	WEPID_ELECTRIC_GUITAR,
	WEPID_CROWBAR,
	WEPID_KATANA,
	WEPID_KATANA,
	WEPID_GOLF_CLUB,
	WEPID_FRYING_PAN,
	WEPID_MACHETE,
	WEPID_CRICKET_BAT,
	WEPID_BASEBALL_BAT
};

L4DW_WeaponId[] GiftList_Upgrade = {
	WEPID_MOLOTOV,
	WEPID_PIPE_BOMB,
	WEPID_GASCAN,
	WEPID_VOMITJAR,
	WEPID_INCENDIARY_AMMO,
	WEPID_FRAG_AMMO,
	WEPID_FIREWORKS_BOX
}

int SpawnItemFromDieResult(float[] pos, float fp, float fnum, char[] msg) {
	int p = RoundFloat(fp);
	int num = RoundFloat(fnum);
	int r;
	r= GetRandomInt(0, 100);
	
	if(r < p)
	{
		int a=RoundFloat(GetConVarFloat(l4d_loot_health));
		int b=RoundFloat(GetConVarFloat(l4d_loot_weapon));
		int c=RoundFloat(GetConVarFloat(l4d_loot_weapon_melee));
		int d=RoundFloat(GetConVarFloat(l4d_loot_item));
		if(!L4D2Version) {
			b=b+c;
			c=0;
		}
		
		if(GetConVarInt(l4d_loot_boss_show_msg)>0)
			PrintHintTextToAll(msg);

		for(int i=0; i<num ; i++) {
			r = GetRandomInt(0, a+b+c+d);
			int r1=0;
			if(r<a) {
				r1 = GetRandomInt(0, L4D2Version ? 4 : 1);
				if(r1==0)	SpawnWeapon(WEPID_FIRST_AID_KIT, pos);
				if(r1==1)	SpawnWeapon(WEPID_PAIN_PILLS, pos);
				if(r1==3)	SpawnWeapon(WEPID_ADRENALINE, pos);
				if(r1==4)	SpawnWeapon(WEPID_DEFIBRILLATOR, pos);
			} else if(r<(a+b)) {
				r1 = GetRandomInt(0, L4D2Version ? 15 : 2);
				SpawnWeapon(GiftList_Gun[r1], pos);
			} else if(r<(a+b+c)) {
				r1 = GetRandomInt(0, 11);
				if(r1==0)		SpawnWeapon(WEPID_CHAINSAW, pos);
				else if(r1==1)	SpawnWeapon(WEPID_FIREWORKS_BOX, pos);
				else			SpawnMelee(GiftList_Melee[r1-2], pos);
 			} else {
				r1 = GetRandomInt(0, L4D2Version ? 6 : 2);
				SpawnWeapon(GiftList_Upgrade[r1], pos);
 			}
		}
		return 1;
	} else {
		return 0;
	}
}
 
stock bool IsValidClient(int iClient) {
	return !(iClient <= 0 || iClient > MaxClients || !IsClientInGame(iClient));
}

stock int SpawnWeapon(L4DW_WeaponId wid, float[] pos) {
	int entity_weapon = L4DW_PrepareWeaponEntity(wid, false);
	if (entity_weapon == -1)
		return entity_weapon;
		
	float SpawnPosition[3];
	float SpawnAngle[3];
	SpawnPosition[0] = pos[0];
	SpawnPosition[1] = pos[1];
	SpawnPosition[2] = pos[2]+20;
	SpawnAngle[0] = 0.0;
	SpawnAngle[1] = GetRandomFloat( 0.0, 360.0 );
	SpawnAngle[2] = 90.0;
	
	SpawnPosition[0] += ( -10 + GetRandomInt( 0, 20 ) );
	SpawnPosition[1] += ( -10 + GetRandomInt( 0, 20 ) );

	/*if (wid == WEPID_FIRST_AID_KIT) {
		SpawnAngle[0] += 90.0;
		SpawnPosition[2] += 1.0;
	} else if(wid == WEPID_ADRENALINE) {// Adrenaline
		SpawnAngle[1] -= 90.0;
		SpawnAngle[2] -= 90.0;
		SpawnPosition[2] += 1.0;
	} else if(wid == WEPID_DEFIBRILLATOR || wid == WEPID_INCENDIARY_AMMO || wid == WEPID_FRAG_AMMO) { // Defib + Upgrades
		SpawnAngle[0] += 90.0;
	}
	else if(wid == WEPID_CHAINSAW) { // Chainsaw
		SpawnPosition[2] += 3.0;
	}*/
	
	//SetEntityGravity(entity_weapon, 1.0);
	//SetEntityMoveType(entity_weapon, MOVETYPE_FLYGRAVITY);	
	//SetEntPropFloat(entity_weapon, Prop_Data, "m_flGravity", 1.0);
	TeleportEntity(entity_weapon, SpawnPosition, SpawnAngle, NULL_VECTOR );
	DispatchSpawn(entity_weapon);

	if (L4DW_GetSlotFromWeaponId(wid) == L4DW_WeaponSlot_Primary) {
		int amount = L4DW_GetMaxBackupAmmo(wid);
		SetEntProp(entity_weapon, Prop_Send, "m_iExtraPrimaryAmmo", amount, 4);
	}	
	
	return entity_weapon;
}

stock int SpawnMelee(L4DW_MeleeWeaponId mid, float[] pos) {
	int entity_weapon = L4DW_PrepareMeleeEntity(mid);
	if (entity_weapon == -1)
		return entity_weapon;
	
	float SpawnPosition[3];
	float SpawnAngle[3];
	SpawnPosition[0] = pos[0];
	SpawnPosition[1] = pos[1] + 20;
	SpawnPosition[2] = pos[2];
	//SpawnAngle[0] = 90.0;
	//SpawnAngle[1] = 0;
	//SpawnAngle[2] = 0;
	
	SpawnPosition[0] += ( -10 + GetRandomInt( 0, 20 ) );
	SpawnPosition[1] += ( -10 + GetRandomInt( 0, 20 ) );
	SpawnPosition[2] += GetRandomInt( 0, 10 );
	SpawnAngle[1] = GetRandomFloat( 0.0, 360.0 );

	TeleportEntity(entity_weapon, SpawnPosition, SpawnAngle, NULL_VECTOR );
	DispatchSpawn(entity_weapon);
	
	return entity_weapon;
}

stock bool IsPlayerIncapped(client) {
	return GetEntProp(client, Prop_Send, "m_isIncapacitated", 1);
}