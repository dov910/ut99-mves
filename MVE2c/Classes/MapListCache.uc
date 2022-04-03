//================================================================================
// MapListCache.
//================================================================================
class MapListCache extends Info
	config(MVE_ClientCache);

var Class<MapListCacheHelper> Helper;
var string ServerCode;
var string LastUpdate;
var string RuleList[512];
var int RuleListCount;
var string GameModeName[ArrayCount(RuleList)];
var string RuleName[ArrayCount(RuleList)];
var int RuleCount;
var float VotePriority[ArrayCount(RuleList)];
var string MapList1[256];
var string MapList2[256];
var string MapList3[256];
var string MapList4[256];
var string MapList5[256];
var string MapList6[256];
var string MapList7[256];
var string MapList8[256];
var string MapList9[256];
var string MapList10[256];
var string MapList11[256];
var string MapList12[256];
var string MapList13[256];
var string MapList14[256];
var string MapList15[256];
var string MapList16[256];
var int MapCount;
var int iNewMaps[32];
var bool bInitialized;
var bool bClientLoadEnd;
var bool bChaceCheck;
var bool bNeedServerMapList;
var int LoadMapCount;
var int LoadRuleCount;
var float LoadPercentage;
var MapVoteCache MVC;
var bool bDebugMode;
var string HTTPMapListLocation;
var HTTPMapListReceiver Link;
var bool bHTTPReceiving;
var string HTTPLastParameter;
var bool bHTTPError;
var int iNewMaps[32];

replication
{
    reliable if(((HTTPMapListLocation ~= "None") && bNeedServerMapList) && Role == ROLE_Authority)
        GameModeName, MapCount, 
        MapList1, MapList10, 
        MapList11, MapList12, 
        MapList13, MapList14, 
        MapList15, MapList16, 
        MapList2, MapList3, 
        MapList4, MapList5, 
        MapList6, MapList7, 
        MapList8, MapList9, 
        RuleCount, RuleList, 
        RuleListCount, RuleName, 
        VotePriority;

    reliable if(Role == ROLE_Authority)
        HTTPMapListLocation, LastUpdate, 
        ServerCode;

    reliable if(Role < ROLE_Authority)
        NeedServerMapList, bChaceCheck, 
        bClientLoadEnd;
}

final simulated function AddCache()
{
    local int i;

    // End:0x2B
    if(!(Role != ROLE_Authority) || Level.NetMode == NM_Standalone)
    {
        return;
    }
    // End:0x47
    if((ServerCode == "") || LastUpdate == "")
    {
        return;
    }
    class'MapListCacheHelper'.static.ConvertServerCode(self);
    MVC.bCached = true;
    // End:0xAC
    if(PlayerPawn(Owner).GameReplicationInfo != none)
    {
        MVC.ServerName = PlayerPawn(Owner).GameReplicationInfo.ServerName;
    }
    MVC.LastUpdate = LastUpdate;
    i = 0;
    J0xC7:
    // End:0x15D [Loop If]
    if(i < 63)
    {
        MVC.RuleList[i] = RuleList[i];
        MVC.GameModeName[i] = GameModeName[i];
        MVC.RuleName[i] = RuleName[i];
        MVC.VotePriority[i] = VotePriority[i];
        ++ i;
        // [Loop Continue]
        goto J0xC7;
    }
    MVC.RuleListCount = RuleListCount;
    MVC.RuleCount = RuleCount;
    i = 0;
    J0x18C:
    // End:0x3A5 [Loop If]
    if(i < 256)
    {
        MVC.MapList1[i] = MapList1[i];
        MVC.MapList2[i] = MapList2[i];
        MVC.MapList3[i] = MapList3[i];
        MVC.MapList4[i] = MapList4[i];
        MVC.MapList5[i] = MapList5[i];
        MVC.MapList6[i] = MapList6[i];
        MVC.MapList7[i] = MapList7[i];
        MVC.MapList8[i] = MapList8[i];
        MVC.MapList9[i] = MapList9[i];
        MVC.MapList10[i] = MapList10[i];
        MVC.MapList11[i] = MapList11[i];
        MVC.MapList12[i] = MapList12[i];
        MVC.MapList13[i] = MapList13[i];
        MVC.MapList14[i] = MapList14[i];
        MVC.MapList15[i] = MapList15[i];
        MVC.MapList16[i] = MapList16[i];
        ++ i;
        // [Loop Continue]
        goto J0x18C;
    }
    MVC.MapCount = MapCount;
    MVC.SaveConfig();
    dlog("client: Save!");
}

simulated function Tick (float F)
{
  if (  !bInitialized )
  {
    Initialized();
  } else {
    Disable('Tick');
  }
}

final simulated function Initialized()
{
    local PlayerPawn P;
    local LevelInfo L;

    if(Owner == none)
    {
        return;
    }

    if(bInitialized)
    {
        return;
    }
    bInitialized = true;

    if(Level.NetMode == NM_Client)
    {
        foreach AllActors(class'PlayerPawn', P)
        {
            if(P.Player == none)
            {
                continue;                
            }
            break;            
        }        

        if(P != none)
        {
            L = P.GetEntryLevel();
            if((L == none) || P != Owner)
            {
                Destroy();
                return;
            }
        }
        else
        {
            Destroy();
            return;
        }
    }
    SetTimer(0.50, true);
}

final simulated function HTTPStateReset ()
{
  bHTTPError = True;
  bHTTPReceiving = False;
  if ( Link != None )
  {
    Link.Destroy();
  }
  HTTPMapListLocation = "None";
  NeedServerMapList();
}

final simulated function HTTPLinkerSetup ()
{
  local string temp;
  local string host;
  local string Port;
  local string Path;
  local int pos;

  if ( (Link != None) || bHTTPError )
  {
    return;
  }
  bHTTPReceiving = True;
  temp = HTTPMapListLocation;
  if ( Left(HTTPMapListLocation,7) ~= "http://" )
  {
    temp = Mid(temp,7);
  }
  pos = InStr(temp,":");
  host = Left(temp,pos);
  temp = Mid(temp,pos + 1);
  pos = InStr(temp,"/");
  Port = Left(temp,pos);
  Path = Mid(temp,pos);
  if ( HTTPLastParameter != "" )
  {
    Path = Path $ "&val=" $ HTTPLastParameter;
  }
  Link = Spawn(Class'HTTPMapListReceiver',self);
  Link.BrowseCurrentURI(host,Path,int(Port));
  dlog("http://" $ host $ ":" $ Port $ Path);
}

final simulated function bool checksam (string P, string V)
{
  if ( Left(P,7) ~= "MapList" )
  {
    if ( Mid(V,Len(V) - 1) == ";" )
    {
      return True;
    } else {
      return False;
    }
  }
  return True;
}

final simulated function bool LinkerAddValue(string S)
{
    local string P, V;
    local int i;
    local string temp;
    local int pos, iTemp;
    local string PTemp;
    local bool bSuccess;

    bSuccess = true;
    // End:0x4E
    if(S ~= "[END]")
    {
        HTTPLastParameter = "";
        bHTTPReceiving = false;
        dlog("HTTPReceiving SUCCESS!");
        return bSuccess;
    }
    // End:0x67
    if(S ~= "[Next]")
    {
        return bSuccess;
    }
    pos = InStr(S, "=");
    // End:0x95
    if(pos == -1)
    {
        bSuccess = false;
        return bSuccess;
    }
    P = Left(S, pos);
    V = Mid(S, pos + 1);
    PTemp = P;
    pos = InStr(P, "[");
    // End:0x142
    if(pos > 0)
    {
        temp = P;
        P = Left(P, pos);
        temp = Mid(temp, pos + 1);
        pos = InStr(temp, "]");
        temp = Left(temp, pos);
        i = int(temp);
    }
    // End:0x1D0
    if(P ~= "MapList")
    {
        // End:0x177
        if(i < 256)
        {
            P = P $ "1";
        }
        // End:0x1D0
        else
        {
            iTemp = int(float(i) - (float(i) % float(256)));
            iTemp /= float(256);
            ++ iTemp;
            P = P $ string(iTemp);
            i = int(float(i) % float(256));
        }
    }
    bSuccess = checksam(P, V);
    // End:0x1F9
    if(!bSuccess)
    {
        return bSuccess;
    }
    switch(P)
    {
        // End:0x221
        case "RuleList":
            RuleList[i] = V;
            // End:0x574
            break;
        // End:0x242
        case "RuleListCount":
            RuleListCount = int(V);
            // End:0x574
            break;
        // End:0x267
        case "GameModeName":
            GameModeName[i] = V;
            // End:0x574
            break;
        // End:0x288
        case "RuleName":
            RuleName[i] = V;
            // End:0x574
            break;
        // End:0x2A5
        case "RuleCount":
            RuleCount = int(V);
            // End:0x574
            break;
        // End:0x2CA
        case "VotePriority":
            VotePriority[i] = float(V);
            // End:0x574
            break;
        case "MapList1":
            MapList1[i] = V;
            // End:0x574
            break;
        // End:0x375
        case "MapList2":
            MapList2[i] = V;
            // End:0x574
            break;
        // End:0x396
        case "MapList3":
            MapList3[i] = V;
            // End:0x574
            break;
        // End:0x3B7
        case "MapList4":
            MapList4[i] = V;
            // End:0x574
            break;
        // End:0x3D8
        case "MapList5":
            MapList5[i] = V;
            // End:0x574
            break;
        // End:0x3F9
        case "MapList6":
            MapList6[i] = V;
            // End:0x574
            break;
        // End:0x41A
        case "MapList7":
            MapList7[i] = V;
            // End:0x574
            break;
        // End:0x43B
        case "MapList8":
            MapList8[i] = V;
            // End:0x574
            break;
        // End:0x45C
        case "MapList9":
            MapList9[i] = V;
            // End:0x574
            break;
        // End:0x47E
        case "MapList10":
            MapList10[i] = V;
            // End:0x574
            break;
        // End:0x4A0
        case "MapList11":
            MapList11[i] = V;
            // End:0x574
            break;
        // End:0x4C2
        case "MapList12":
            MapList12[i] = V;
            // End:0x574
            break;
        // End:0x4E4
        case "MapList13":
            MapList13[i] = V;
            // End:0x574
            break;
        // End:0x506
        case "MapList14":
            MapList14[i] = V;
            // End:0x574
            break;
        // End:0x528
        case "MapList15":
            MapList15[i] = V;
            // End:0x574
            break;
        // End:0x54A
        case "MapList16":
            MapList16[i] = V;
            // End:0x574
            break;
        // End:0x566
        case "MapCount":
            MapCount = int(V);
            // End:0x574
            break;
        // End:0xFFFF
        default:
            bSuccess = false;
            // End:0x574
            break;
    }
    // End:0x588
    if(bSuccess)
    {
        HTTPLastParameter = PTemp;
    }
    return bSuccess;
}

final simulated function ChaceCheck()
{
    local int i;

    // End:0x2B
    if(!(Role != ROLE_Authority) || Level.NetMode == NM_Standalone)
    {
        return;
    }
    // End:0x55
    if(((HTTPMapListLocation == "") || ServerCode == "") || LastUpdate == "")
    {
        return;
    }
    class'MapListCacheHelper'.static.ConvertServerCode(self);
    MVC = new (class'MapVoteCache', class'MapListCacheHelper'.default.ServerCodeN) class'MapVoteCache';
    bChaceCheck = true;
    dlog("client: ChaceCheckEnd!");
    // End:0x16B
    if(!MVC.bCached || MVC.LastUpdate != LastUpdate)
    {
        bNeedServerMapList = true;
        // End:0x12B
        if(HTTPMapListLocation ~= "None")
        {
            dlog("client: NeedServerMapList!");
            MVC.CacheClear();
            NeedServerMapList();
        }
        // End:0x169
        else
        {
            dlog("client: NeedServerMapList! (HTTP)");
            MVC.CacheClear();
            HTTPLinkerSetup();
        }
        return;
    }
    i = 0;
    J0x172:
    // End:0x208 [Loop If]
    if(i < ArrayCount(RuleList))
    {
        RuleList[i] = MVC.RuleList[i];
        GameModeName[i] = MVC.GameModeName[i];
        RuleName[i] = MVC.RuleName[i];
        VotePriority[i] = MVC.GetVotePriority(i);
        ++ i;
        // [Loop Continue]
        goto J0x172;
    }
    RuleListCount = MVC.RuleListCount;
    RuleCount = MVC.RuleCount;
    i = 0;
    J0x237:
    // End:0x450 [Loop If]
  if ( i < ArrayCount(RuleList) )
    {
        MapList1[i] = MVC.MapList1[i];
        MapList2[i] = MVC.MapList2[i];
        MapList3[i] = MVC.MapList3[i];
        MapList4[i] = MVC.MapList4[i];
        MapList5[i] = MVC.MapList5[i];
        MapList6[i] = MVC.MapList6[i];
        MapList7[i] = MVC.MapList7[i];
        MapList8[i] = MVC.MapList8[i];
        MapList9[i] = MVC.MapList9[i];
        MapList10[i] = MVC.MapList10[i];
        MapList11[i] = MVC.MapList11[i];
        MapList12[i] = MVC.MapList12[i];
        MapList13[i] = MVC.MapList13[i];
        MapList14[i] = MVC.MapList14[i];
        MapList15[i] = MVC.MapList15[i];
        MapList16[i] = MVC.MapList16[i];
        ++ i;
        // [Loop Continue]
        goto J0x237;
    }
    MapCount = MVC.MapCount;
}

final function NeedServerMapList()
{
    //local string S;

    if(Role != ROLE_Authority)
    {
        return;
    }
    dlog("NeedServerMapList() call");
    HTTPMapListLocation = "None";
    bNeedServerMapList = true;
/*     S = Left(string(default.Class), InStr(string(default.Class), "."));
    S = Mid(S, 0, Len(S) - 1);
    Helper = class<MapListCacheHelper>(DynamicLoadObject(S $ "S.MapListCacheHelperS", Class.Class));
    Helper.static.NeedServerMapList(self); */
}

simulated function Timer ()
{
  if ( Owner == None )
  {
    Destroy();
    return;
  }
  if ( bClientLoadEnd )
  {
    SetTimer(0.0,False);
    return;
  }
  if (  !bChaceCheck )
  {
    ChaceCheck();
  }
  if ( bHTTPReceiving )
  {
    HTTPLinkerSetup();
    return;
  }
  MapListCheck();
}

final simulated function MapListCheck ()
{
  local int i;
  local int NECount;
  local int RLCount;
  local int RCount;

  if (  !(Role != ROLE_Authority) || (Level.NetMode == NM_Standalone) )
  {
    return;
  }
  if ( MapCount == 0 )
  {
    return;
  }
  i = 0;
  JL003F:
  if ( i < 256 )
  {
    NECount += MapCounter(MapList1[i]);
    NECount += MapCounter(MapList2[i]);
    NECount += MapCounter(MapList3[i]);
    NECount += MapCounter(MapList4[i]);
    NECount += MapCounter(MapList5[i]);
    NECount += MapCounter(MapList6[i]);
    NECount += MapCounter(MapList7[i]);
    NECount += MapCounter(MapList8[i]);
    NECount += MapCounter(MapList9[i]);
    NECount += MapCounter(MapList10[i]);
    NECount += MapCounter(MapList11[i]);
    NECount += MapCounter(MapList12[i]);
    NECount += MapCounter(MapList13[i]);
    NECount += MapCounter(MapList14[i]);
    NECount += MapCounter(MapList15[i]);
    NECount += MapCounter(MapList16[i]);
    i++;
    goto JL003F;
  }
  i = 0;
  JL01DF:
  if ( i < 63 )
  {
    if ( RuleList[i] != "" )
    {
      RLCount++;
    }
    if ( (GameModeName[i] != "") && (RuleName[i] != "") && (VotePriority[i] > 0) )
    {
      RCount++;
    }
    i++;
    goto JL01DF;
  }
  LoadMapCount = NECount;
  LoadRuleCount = RCount;
  LoadPercentage = (NECount + RLCount + RCount) / (MapCount + RuleListCount + RuleCount);
  LoadPercentage *= 100;
  if ( (NECount == MapCount) && (RLCount == RuleListCount) && (RCount == RuleCount) )
  {
    bClientLoadEnd = True;
    dlog("client: ClientLoadEnd!");
    if ( bNeedServerMapList )
    {
      AddCache();
    }
  }
}

final simulated function int MapCounter (string S)
{
  local int i;

  if ( S == "" )
  {
    return 0;
  }
  JL000E:
  if ( InStr(S,":") != -1 )
  {
    S = Mid(S,InStr(S,":") + 1);
    i++;
    goto JL000E;
  }
  return i;
}

final function dlog (string S)
{
  if (  !bDebugMode )
  {
    return;
  }
  Log(S,Class.Name);
}

final simulated function float GetVotePriority( int Idx)
{
	return VotePriority[Idx];
}

final simulated function SetVotePriority( int Idx, float Value)
{
	VotePriority[Idx] = Value;
}


defaultproperties
{
      helper=None
      ServerCode=""
      LastUpdate=""
      RuleListCount=0
      RuleCount=0
      bInitialized=False
      bClientLoadEnd=False
      bChaceCheck=False
      bNeedServerMapList=False
      LoadMapCount=0
      LoadRuleCount=0
      LoadPercentage=0.000000
      MVC=None
      bDebugMode=False
      HTTPMapListLocation=""
      Link=None
      bHTTPReceiving=False
      HTTPLastParameter=""
      bHTTPError=False
      RemoteRole=ROLE_SimulatedProxy
      NetUpdateFrequency=100.000000
}
