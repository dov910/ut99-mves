//================================================================================
// MapVoteCache.
//================================================================================
class MapVoteCache extends Object
	config(MVE_ClientCache);

var config bool bCached;
var config string ServerName;
var config string LastUpdate;
var config string RuleList[63];
var config int RuleListCount;
var config string GameModeName[63];
var config string RuleName[63];
var config int RuleCount;
var config float VotePriority[63];
var config string MapList1[256];
var config string MapList2[256];
var config string MapList3[256];
var config string MapList4[256];
var config string MapList5[256];
var config string MapList6[256];
var config string MapList7[256];
var config string MapList8[256];
var config string MapList9[256];
var config string MapList10[256];
var config string MapList11[256];
var config string MapList12[256];
var config string MapList13[256];
var config string MapList14[256];
var config string MapList15[256];
var config string MapList16[256];
var config int MapCount;

simulated function CacheClear ()
{
  local int i;

  i = 0;
  JL0007:
  if ( i < 63 )
  {
    RuleList[i] = "";
    GameModeName[i] = "";
    RuleName[i] = "";
    VotePriority[i] = 0.0;
    i++;
    goto JL0007;
  }
  RuleListCount = 0;
  RuleCount = 0;
  i = 0;
  JL006D:
  if ( i < 256 )
  {
    MapList1[i] = "";
    MapList2[i] = "";
    MapList3[i] = "";
    MapList4[i] = "";
    MapList5[i] = "";
    MapList6[i] = "";
    MapList7[i] = "";
    MapList8[i] = "";
    MapList9[i] = "";
    MapList10[i] = "";
    MapList11[i] = "";
    MapList12[i] = "";
    MapList13[i] = "";
    MapList14[i] = "";
    MapList15[i] = "";
    MapList16[i] = "";
    i++;
    goto JL006D;
  }
  MapCount = 0;
}