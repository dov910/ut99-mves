//================================================================================
// MapHistory.
//================================================================================
class MapHistory expands Object
	config(MVE_MapHistory);

var MV_MapList MapList;

struct MapElement
{
	var() config int mIdx;
	var() config byte gIdx;
	var() config int Acc; //Accumulated points
};

var() config MapElement Elements[512];
var() config int iMe;

//Validation checks already passed
//Map indexes are ALWAYS sorted
function NewMapPlayed( int mIdx, int gIdx, int CostAdd)
{
	local int i;

	For ( i=0 ; i<iMe ; i++ )
	{
		if ( --Elements[i].Acc <= 0 )
			ClearElement( i);
	}
	i=0;
	While ( i<iMe )
	{
		if ( (Elements[i].mIdx == mIdx) && (Elements[i].gIdx == gIdx) ) //FOUND EXISTING ENTRY!
		{
			Elements[i].Acc += CostAdd + 1;
			Goto END;
		}
		if ( Elements[i].mIdx > mIdx ) //This one is one slot after, perform push and use this slot instead
		{
			PushList( i);
			Goto SET;
		}
		i++;
	}
	//This happens if we went through all list and see we're last
	iMe++;	
	SET:	
	Elements[i].mIdx = mIdx;
	Elements[i].gIdx = gIdx;
	Elements[i].Acc = CostAdd;
	END:
	SaveConfig();
	Log("History Saved");
}

//Delete element and keep order
function ClearElement( int idx)
{
	local int i;
	i = idx+1;
	While ( (i < iMe) && (i < ArrayCount(Elements)) )
	{
		Elements[i-1] = Elements[i];
		i++;
	}
	iMe--;
}

//Push list one place up, let idx slot ready to replace
function PushList( int idx)
{
	local int i;
	i = iMe++;
	While ( i > idx )
	{
		Elements[i] = Elements[i-1];
		i--;
	}
}


function bool IsExcluded( int idx)
{	return Elements[idx].Acc > MapList.Mutator.MapCostMaxAllow;	}

function int GameIdx( int idx)
{	return Elements[idx].gIdx;	}

function int MapIdx( int idx)
{	return Elements[idx].mIdx;	}

defaultproperties
{
      MapList=None
      Elements(0)=(mIdx=205,gIdx=3,Acc=3)
      Elements(1)=(mIdx=251,gIdx=3,Acc=4)
      Elements(2)=(mIdx=258,gIdx=3,Acc=5)
      Elements(3)=(mIdx=215,gIdx=3,Acc=2)
      Elements(4)=(mIdx=215,gIdx=3,Acc=4)
      Elements(5)=(mIdx=99,gIdx=0,Acc=3)
      Elements(6)=(mIdx=0,gIdx=0,Acc=0)
      Elements(7)=(mIdx=0,gIdx=0,Acc=0)
      Elements(8)=(mIdx=0,gIdx=0,Acc=0)
      Elements(9)=(mIdx=0,gIdx=0,Acc=0)
      Elements(10)=(mIdx=0,gIdx=0,Acc=0)
      Elements(11)=(mIdx=0,gIdx=0,Acc=0)
      Elements(12)=(mIdx=0,gIdx=0,Acc=0)
      Elements(13)=(mIdx=0,gIdx=0,Acc=0)
      Elements(14)=(mIdx=0,gIdx=0,Acc=0)
      Elements(15)=(mIdx=0,gIdx=0,Acc=0)
      Elements(16)=(mIdx=0,gIdx=0,Acc=0)
      Elements(17)=(mIdx=0,gIdx=0,Acc=0)
      Elements(18)=(mIdx=0,gIdx=0,Acc=0)
      Elements(19)=(mIdx=0,gIdx=0,Acc=0)
      Elements(20)=(mIdx=0,gIdx=0,Acc=0)
      Elements(21)=(mIdx=0,gIdx=0,Acc=0)
      Elements(22)=(mIdx=0,gIdx=0,Acc=0)
      Elements(23)=(mIdx=0,gIdx=0,Acc=0)
      Elements(24)=(mIdx=0,gIdx=0,Acc=0)
      Elements(25)=(mIdx=0,gIdx=0,Acc=0)
      Elements(26)=(mIdx=0,gIdx=0,Acc=0)
      Elements(27)=(mIdx=0,gIdx=0,Acc=0)
      Elements(28)=(mIdx=0,gIdx=0,Acc=0)
      Elements(29)=(mIdx=0,gIdx=0,Acc=0)
      Elements(30)=(mIdx=0,gIdx=0,Acc=0)
      Elements(31)=(mIdx=0,gIdx=0,Acc=0)
      Elements(32)=(mIdx=0,gIdx=0,Acc=0)
      Elements(33)=(mIdx=0,gIdx=0,Acc=0)
      Elements(34)=(mIdx=0,gIdx=0,Acc=0)
      Elements(35)=(mIdx=0,gIdx=0,Acc=0)
      Elements(36)=(mIdx=0,gIdx=0,Acc=0)
      Elements(37)=(mIdx=0,gIdx=0,Acc=0)
      Elements(38)=(mIdx=0,gIdx=0,Acc=0)
      Elements(39)=(mIdx=0,gIdx=0,Acc=0)
      Elements(40)=(mIdx=0,gIdx=0,Acc=0)
      Elements(41)=(mIdx=0,gIdx=0,Acc=0)
      Elements(42)=(mIdx=0,gIdx=0,Acc=0)
      Elements(43)=(mIdx=0,gIdx=0,Acc=0)
      Elements(44)=(mIdx=0,gIdx=0,Acc=0)
      Elements(45)=(mIdx=0,gIdx=0,Acc=0)
      Elements(46)=(mIdx=0,gIdx=0,Acc=0)
      Elements(47)=(mIdx=0,gIdx=0,Acc=0)
      Elements(48)=(mIdx=0,gIdx=0,Acc=0)
      Elements(49)=(mIdx=0,gIdx=0,Acc=0)
      Elements(50)=(mIdx=0,gIdx=0,Acc=0)
      Elements(51)=(mIdx=0,gIdx=0,Acc=0)
      Elements(52)=(mIdx=0,gIdx=0,Acc=0)
      Elements(53)=(mIdx=0,gIdx=0,Acc=0)
      Elements(54)=(mIdx=0,gIdx=0,Acc=0)
      Elements(55)=(mIdx=0,gIdx=0,Acc=0)
      Elements(56)=(mIdx=0,gIdx=0,Acc=0)
      Elements(57)=(mIdx=0,gIdx=0,Acc=0)
      Elements(58)=(mIdx=0,gIdx=0,Acc=0)
      Elements(59)=(mIdx=0,gIdx=0,Acc=0)
      Elements(60)=(mIdx=0,gIdx=0,Acc=0)
      Elements(61)=(mIdx=0,gIdx=0,Acc=0)
      Elements(62)=(mIdx=0,gIdx=0,Acc=0)
      Elements(63)=(mIdx=0,gIdx=0,Acc=0)
      Elements(64)=(mIdx=0,gIdx=0,Acc=0)
      Elements(65)=(mIdx=0,gIdx=0,Acc=0)
      Elements(66)=(mIdx=0,gIdx=0,Acc=0)
      Elements(67)=(mIdx=0,gIdx=0,Acc=0)
      Elements(68)=(mIdx=0,gIdx=0,Acc=0)
      Elements(69)=(mIdx=0,gIdx=0,Acc=0)
      Elements(70)=(mIdx=0,gIdx=0,Acc=0)
      Elements(71)=(mIdx=0,gIdx=0,Acc=0)
      Elements(72)=(mIdx=0,gIdx=0,Acc=0)
      Elements(73)=(mIdx=0,gIdx=0,Acc=0)
      Elements(74)=(mIdx=0,gIdx=0,Acc=0)
      Elements(75)=(mIdx=0,gIdx=0,Acc=0)
      Elements(76)=(mIdx=0,gIdx=0,Acc=0)
      Elements(77)=(mIdx=0,gIdx=0,Acc=0)
      Elements(78)=(mIdx=0,gIdx=0,Acc=0)
      Elements(79)=(mIdx=0,gIdx=0,Acc=0)
      Elements(80)=(mIdx=0,gIdx=0,Acc=0)
      Elements(81)=(mIdx=0,gIdx=0,Acc=0)
      Elements(82)=(mIdx=0,gIdx=0,Acc=0)
      Elements(83)=(mIdx=0,gIdx=0,Acc=0)
      Elements(84)=(mIdx=0,gIdx=0,Acc=0)
      Elements(85)=(mIdx=0,gIdx=0,Acc=0)
      Elements(86)=(mIdx=0,gIdx=0,Acc=0)
      Elements(87)=(mIdx=0,gIdx=0,Acc=0)
      Elements(88)=(mIdx=0,gIdx=0,Acc=0)
      Elements(89)=(mIdx=0,gIdx=0,Acc=0)
      Elements(90)=(mIdx=0,gIdx=0,Acc=0)
      Elements(91)=(mIdx=0,gIdx=0,Acc=0)
      Elements(92)=(mIdx=0,gIdx=0,Acc=0)
      Elements(93)=(mIdx=0,gIdx=0,Acc=0)
      Elements(94)=(mIdx=0,gIdx=0,Acc=0)
      Elements(95)=(mIdx=0,gIdx=0,Acc=0)
      Elements(96)=(mIdx=0,gIdx=0,Acc=0)
      Elements(97)=(mIdx=0,gIdx=0,Acc=0)
      Elements(98)=(mIdx=0,gIdx=0,Acc=0)
      Elements(99)=(mIdx=0,gIdx=0,Acc=0)
      Elements(100)=(mIdx=0,gIdx=0,Acc=0)
      Elements(101)=(mIdx=0,gIdx=0,Acc=0)
      Elements(102)=(mIdx=0,gIdx=0,Acc=0)
      Elements(103)=(mIdx=0,gIdx=0,Acc=0)
      Elements(104)=(mIdx=0,gIdx=0,Acc=0)
      Elements(105)=(mIdx=0,gIdx=0,Acc=0)
      Elements(106)=(mIdx=0,gIdx=0,Acc=0)
      Elements(107)=(mIdx=0,gIdx=0,Acc=0)
      Elements(108)=(mIdx=0,gIdx=0,Acc=0)
      Elements(109)=(mIdx=0,gIdx=0,Acc=0)
      Elements(110)=(mIdx=0,gIdx=0,Acc=0)
      Elements(111)=(mIdx=0,gIdx=0,Acc=0)
      Elements(112)=(mIdx=0,gIdx=0,Acc=0)
      Elements(113)=(mIdx=0,gIdx=0,Acc=0)
      Elements(114)=(mIdx=0,gIdx=0,Acc=0)
      Elements(115)=(mIdx=0,gIdx=0,Acc=0)
      Elements(116)=(mIdx=0,gIdx=0,Acc=0)
      Elements(117)=(mIdx=0,gIdx=0,Acc=0)
      Elements(118)=(mIdx=0,gIdx=0,Acc=0)
      Elements(119)=(mIdx=0,gIdx=0,Acc=0)
      Elements(120)=(mIdx=0,gIdx=0,Acc=0)
      Elements(121)=(mIdx=0,gIdx=0,Acc=0)
      Elements(122)=(mIdx=0,gIdx=0,Acc=0)
      Elements(123)=(mIdx=0,gIdx=0,Acc=0)
      Elements(124)=(mIdx=0,gIdx=0,Acc=0)
      Elements(125)=(mIdx=0,gIdx=0,Acc=0)
      Elements(126)=(mIdx=0,gIdx=0,Acc=0)
      Elements(127)=(mIdx=0,gIdx=0,Acc=0)
      Elements(128)=(mIdx=0,gIdx=0,Acc=0)
      Elements(129)=(mIdx=0,gIdx=0,Acc=0)
      Elements(130)=(mIdx=0,gIdx=0,Acc=0)
      Elements(131)=(mIdx=0,gIdx=0,Acc=0)
      Elements(132)=(mIdx=0,gIdx=0,Acc=0)
      Elements(133)=(mIdx=0,gIdx=0,Acc=0)
      Elements(134)=(mIdx=0,gIdx=0,Acc=0)
      Elements(135)=(mIdx=0,gIdx=0,Acc=0)
      Elements(136)=(mIdx=0,gIdx=0,Acc=0)
      Elements(137)=(mIdx=0,gIdx=0,Acc=0)
      Elements(138)=(mIdx=0,gIdx=0,Acc=0)
      Elements(139)=(mIdx=0,gIdx=0,Acc=0)
      Elements(140)=(mIdx=0,gIdx=0,Acc=0)
      Elements(141)=(mIdx=0,gIdx=0,Acc=0)
      Elements(142)=(mIdx=0,gIdx=0,Acc=0)
      Elements(143)=(mIdx=0,gIdx=0,Acc=0)
      Elements(144)=(mIdx=0,gIdx=0,Acc=0)
      Elements(145)=(mIdx=0,gIdx=0,Acc=0)
      Elements(146)=(mIdx=0,gIdx=0,Acc=0)
      Elements(147)=(mIdx=0,gIdx=0,Acc=0)
      Elements(148)=(mIdx=0,gIdx=0,Acc=0)
      Elements(149)=(mIdx=0,gIdx=0,Acc=0)
      Elements(150)=(mIdx=0,gIdx=0,Acc=0)
      Elements(151)=(mIdx=0,gIdx=0,Acc=0)
      Elements(152)=(mIdx=0,gIdx=0,Acc=0)
      Elements(153)=(mIdx=0,gIdx=0,Acc=0)
      Elements(154)=(mIdx=0,gIdx=0,Acc=0)
      Elements(155)=(mIdx=0,gIdx=0,Acc=0)
      Elements(156)=(mIdx=0,gIdx=0,Acc=0)
      Elements(157)=(mIdx=0,gIdx=0,Acc=0)
      Elements(158)=(mIdx=0,gIdx=0,Acc=0)
      Elements(159)=(mIdx=0,gIdx=0,Acc=0)
      Elements(160)=(mIdx=0,gIdx=0,Acc=0)
      Elements(161)=(mIdx=0,gIdx=0,Acc=0)
      Elements(162)=(mIdx=0,gIdx=0,Acc=0)
      Elements(163)=(mIdx=0,gIdx=0,Acc=0)
      Elements(164)=(mIdx=0,gIdx=0,Acc=0)
      Elements(165)=(mIdx=0,gIdx=0,Acc=0)
      Elements(166)=(mIdx=0,gIdx=0,Acc=0)
      Elements(167)=(mIdx=0,gIdx=0,Acc=0)
      Elements(168)=(mIdx=0,gIdx=0,Acc=0)
      Elements(169)=(mIdx=0,gIdx=0,Acc=0)
      Elements(170)=(mIdx=0,gIdx=0,Acc=0)
      Elements(171)=(mIdx=0,gIdx=0,Acc=0)
      Elements(172)=(mIdx=0,gIdx=0,Acc=0)
      Elements(173)=(mIdx=0,gIdx=0,Acc=0)
      Elements(174)=(mIdx=0,gIdx=0,Acc=0)
      Elements(175)=(mIdx=0,gIdx=0,Acc=0)
      Elements(176)=(mIdx=0,gIdx=0,Acc=0)
      Elements(177)=(mIdx=0,gIdx=0,Acc=0)
      Elements(178)=(mIdx=0,gIdx=0,Acc=0)
      Elements(179)=(mIdx=0,gIdx=0,Acc=0)
      Elements(180)=(mIdx=0,gIdx=0,Acc=0)
      Elements(181)=(mIdx=0,gIdx=0,Acc=0)
      Elements(182)=(mIdx=0,gIdx=0,Acc=0)
      Elements(183)=(mIdx=0,gIdx=0,Acc=0)
      Elements(184)=(mIdx=0,gIdx=0,Acc=0)
      Elements(185)=(mIdx=0,gIdx=0,Acc=0)
      Elements(186)=(mIdx=0,gIdx=0,Acc=0)
      Elements(187)=(mIdx=0,gIdx=0,Acc=0)
      Elements(188)=(mIdx=0,gIdx=0,Acc=0)
      Elements(189)=(mIdx=0,gIdx=0,Acc=0)
      Elements(190)=(mIdx=0,gIdx=0,Acc=0)
      Elements(191)=(mIdx=0,gIdx=0,Acc=0)
      Elements(192)=(mIdx=0,gIdx=0,Acc=0)
      Elements(193)=(mIdx=0,gIdx=0,Acc=0)
      Elements(194)=(mIdx=0,gIdx=0,Acc=0)
      Elements(195)=(mIdx=0,gIdx=0,Acc=0)
      Elements(196)=(mIdx=0,gIdx=0,Acc=0)
      Elements(197)=(mIdx=0,gIdx=0,Acc=0)
      Elements(198)=(mIdx=0,gIdx=0,Acc=0)
      Elements(199)=(mIdx=0,gIdx=0,Acc=0)
      Elements(200)=(mIdx=0,gIdx=0,Acc=0)
      Elements(201)=(mIdx=0,gIdx=0,Acc=0)
      Elements(202)=(mIdx=0,gIdx=0,Acc=0)
      Elements(203)=(mIdx=0,gIdx=0,Acc=0)
      Elements(204)=(mIdx=0,gIdx=0,Acc=0)
      Elements(205)=(mIdx=0,gIdx=0,Acc=0)
      Elements(206)=(mIdx=0,gIdx=0,Acc=0)
      Elements(207)=(mIdx=0,gIdx=0,Acc=0)
      Elements(208)=(mIdx=0,gIdx=0,Acc=0)
      Elements(209)=(mIdx=0,gIdx=0,Acc=0)
      Elements(210)=(mIdx=0,gIdx=0,Acc=0)
      Elements(211)=(mIdx=0,gIdx=0,Acc=0)
      Elements(212)=(mIdx=0,gIdx=0,Acc=0)
      Elements(213)=(mIdx=0,gIdx=0,Acc=0)
      Elements(214)=(mIdx=0,gIdx=0,Acc=0)
      Elements(215)=(mIdx=0,gIdx=0,Acc=0)
      Elements(216)=(mIdx=0,gIdx=0,Acc=0)
      Elements(217)=(mIdx=0,gIdx=0,Acc=0)
      Elements(218)=(mIdx=0,gIdx=0,Acc=0)
      Elements(219)=(mIdx=0,gIdx=0,Acc=0)
      Elements(220)=(mIdx=0,gIdx=0,Acc=0)
      Elements(221)=(mIdx=0,gIdx=0,Acc=0)
      Elements(222)=(mIdx=0,gIdx=0,Acc=0)
      Elements(223)=(mIdx=0,gIdx=0,Acc=0)
      Elements(224)=(mIdx=0,gIdx=0,Acc=0)
      Elements(225)=(mIdx=0,gIdx=0,Acc=0)
      Elements(226)=(mIdx=0,gIdx=0,Acc=0)
      Elements(227)=(mIdx=0,gIdx=0,Acc=0)
      Elements(228)=(mIdx=0,gIdx=0,Acc=0)
      Elements(229)=(mIdx=0,gIdx=0,Acc=0)
      Elements(230)=(mIdx=0,gIdx=0,Acc=0)
      Elements(231)=(mIdx=0,gIdx=0,Acc=0)
      Elements(232)=(mIdx=0,gIdx=0,Acc=0)
      Elements(233)=(mIdx=0,gIdx=0,Acc=0)
      Elements(234)=(mIdx=0,gIdx=0,Acc=0)
      Elements(235)=(mIdx=0,gIdx=0,Acc=0)
      Elements(236)=(mIdx=0,gIdx=0,Acc=0)
      Elements(237)=(mIdx=0,gIdx=0,Acc=0)
      Elements(238)=(mIdx=0,gIdx=0,Acc=0)
      Elements(239)=(mIdx=0,gIdx=0,Acc=0)
      Elements(240)=(mIdx=0,gIdx=0,Acc=0)
      Elements(241)=(mIdx=0,gIdx=0,Acc=0)
      Elements(242)=(mIdx=0,gIdx=0,Acc=0)
      Elements(243)=(mIdx=0,gIdx=0,Acc=0)
      Elements(244)=(mIdx=0,gIdx=0,Acc=0)
      Elements(245)=(mIdx=0,gIdx=0,Acc=0)
      Elements(246)=(mIdx=0,gIdx=0,Acc=0)
      Elements(247)=(mIdx=0,gIdx=0,Acc=0)
      Elements(248)=(mIdx=0,gIdx=0,Acc=0)
      Elements(249)=(mIdx=0,gIdx=0,Acc=0)
      Elements(250)=(mIdx=0,gIdx=0,Acc=0)
      Elements(251)=(mIdx=0,gIdx=0,Acc=0)
      Elements(252)=(mIdx=0,gIdx=0,Acc=0)
      Elements(253)=(mIdx=0,gIdx=0,Acc=0)
      Elements(254)=(mIdx=0,gIdx=0,Acc=0)
      Elements(255)=(mIdx=0,gIdx=0,Acc=0)
      Elements(256)=(mIdx=0,gIdx=0,Acc=0)
      Elements(257)=(mIdx=0,gIdx=0,Acc=0)
      Elements(258)=(mIdx=0,gIdx=0,Acc=0)
      Elements(259)=(mIdx=0,gIdx=0,Acc=0)
      Elements(260)=(mIdx=0,gIdx=0,Acc=0)
      Elements(261)=(mIdx=0,gIdx=0,Acc=0)
      Elements(262)=(mIdx=0,gIdx=0,Acc=0)
      Elements(263)=(mIdx=0,gIdx=0,Acc=0)
      Elements(264)=(mIdx=0,gIdx=0,Acc=0)
      Elements(265)=(mIdx=0,gIdx=0,Acc=0)
      Elements(266)=(mIdx=0,gIdx=0,Acc=0)
      Elements(267)=(mIdx=0,gIdx=0,Acc=0)
      Elements(268)=(mIdx=0,gIdx=0,Acc=0)
      Elements(269)=(mIdx=0,gIdx=0,Acc=0)
      Elements(270)=(mIdx=0,gIdx=0,Acc=0)
      Elements(271)=(mIdx=0,gIdx=0,Acc=0)
      Elements(272)=(mIdx=0,gIdx=0,Acc=0)
      Elements(273)=(mIdx=0,gIdx=0,Acc=0)
      Elements(274)=(mIdx=0,gIdx=0,Acc=0)
      Elements(275)=(mIdx=0,gIdx=0,Acc=0)
      Elements(276)=(mIdx=0,gIdx=0,Acc=0)
      Elements(277)=(mIdx=0,gIdx=0,Acc=0)
      Elements(278)=(mIdx=0,gIdx=0,Acc=0)
      Elements(279)=(mIdx=0,gIdx=0,Acc=0)
      Elements(280)=(mIdx=0,gIdx=0,Acc=0)
      Elements(281)=(mIdx=0,gIdx=0,Acc=0)
      Elements(282)=(mIdx=0,gIdx=0,Acc=0)
      Elements(283)=(mIdx=0,gIdx=0,Acc=0)
      Elements(284)=(mIdx=0,gIdx=0,Acc=0)
      Elements(285)=(mIdx=0,gIdx=0,Acc=0)
      Elements(286)=(mIdx=0,gIdx=0,Acc=0)
      Elements(287)=(mIdx=0,gIdx=0,Acc=0)
      Elements(288)=(mIdx=0,gIdx=0,Acc=0)
      Elements(289)=(mIdx=0,gIdx=0,Acc=0)
      Elements(290)=(mIdx=0,gIdx=0,Acc=0)
      Elements(291)=(mIdx=0,gIdx=0,Acc=0)
      Elements(292)=(mIdx=0,gIdx=0,Acc=0)
      Elements(293)=(mIdx=0,gIdx=0,Acc=0)
      Elements(294)=(mIdx=0,gIdx=0,Acc=0)
      Elements(295)=(mIdx=0,gIdx=0,Acc=0)
      Elements(296)=(mIdx=0,gIdx=0,Acc=0)
      Elements(297)=(mIdx=0,gIdx=0,Acc=0)
      Elements(298)=(mIdx=0,gIdx=0,Acc=0)
      Elements(299)=(mIdx=0,gIdx=0,Acc=0)
      Elements(300)=(mIdx=0,gIdx=0,Acc=0)
      Elements(301)=(mIdx=0,gIdx=0,Acc=0)
      Elements(302)=(mIdx=0,gIdx=0,Acc=0)
      Elements(303)=(mIdx=0,gIdx=0,Acc=0)
      Elements(304)=(mIdx=0,gIdx=0,Acc=0)
      Elements(305)=(mIdx=0,gIdx=0,Acc=0)
      Elements(306)=(mIdx=0,gIdx=0,Acc=0)
      Elements(307)=(mIdx=0,gIdx=0,Acc=0)
      Elements(308)=(mIdx=0,gIdx=0,Acc=0)
      Elements(309)=(mIdx=0,gIdx=0,Acc=0)
      Elements(310)=(mIdx=0,gIdx=0,Acc=0)
      Elements(311)=(mIdx=0,gIdx=0,Acc=0)
      Elements(312)=(mIdx=0,gIdx=0,Acc=0)
      Elements(313)=(mIdx=0,gIdx=0,Acc=0)
      Elements(314)=(mIdx=0,gIdx=0,Acc=0)
      Elements(315)=(mIdx=0,gIdx=0,Acc=0)
      Elements(316)=(mIdx=0,gIdx=0,Acc=0)
      Elements(317)=(mIdx=0,gIdx=0,Acc=0)
      Elements(318)=(mIdx=0,gIdx=0,Acc=0)
      Elements(319)=(mIdx=0,gIdx=0,Acc=0)
      Elements(320)=(mIdx=0,gIdx=0,Acc=0)
      Elements(321)=(mIdx=0,gIdx=0,Acc=0)
      Elements(322)=(mIdx=0,gIdx=0,Acc=0)
      Elements(323)=(mIdx=0,gIdx=0,Acc=0)
      Elements(324)=(mIdx=0,gIdx=0,Acc=0)
      Elements(325)=(mIdx=0,gIdx=0,Acc=0)
      Elements(326)=(mIdx=0,gIdx=0,Acc=0)
      Elements(327)=(mIdx=0,gIdx=0,Acc=0)
      Elements(328)=(mIdx=0,gIdx=0,Acc=0)
      Elements(329)=(mIdx=0,gIdx=0,Acc=0)
      Elements(330)=(mIdx=0,gIdx=0,Acc=0)
      Elements(331)=(mIdx=0,gIdx=0,Acc=0)
      Elements(332)=(mIdx=0,gIdx=0,Acc=0)
      Elements(333)=(mIdx=0,gIdx=0,Acc=0)
      Elements(334)=(mIdx=0,gIdx=0,Acc=0)
      Elements(335)=(mIdx=0,gIdx=0,Acc=0)
      Elements(336)=(mIdx=0,gIdx=0,Acc=0)
      Elements(337)=(mIdx=0,gIdx=0,Acc=0)
      Elements(338)=(mIdx=0,gIdx=0,Acc=0)
      Elements(339)=(mIdx=0,gIdx=0,Acc=0)
      Elements(340)=(mIdx=0,gIdx=0,Acc=0)
      Elements(341)=(mIdx=0,gIdx=0,Acc=0)
      Elements(342)=(mIdx=0,gIdx=0,Acc=0)
      Elements(343)=(mIdx=0,gIdx=0,Acc=0)
      Elements(344)=(mIdx=0,gIdx=0,Acc=0)
      Elements(345)=(mIdx=0,gIdx=0,Acc=0)
      Elements(346)=(mIdx=0,gIdx=0,Acc=0)
      Elements(347)=(mIdx=0,gIdx=0,Acc=0)
      Elements(348)=(mIdx=0,gIdx=0,Acc=0)
      Elements(349)=(mIdx=0,gIdx=0,Acc=0)
      Elements(350)=(mIdx=0,gIdx=0,Acc=0)
      Elements(351)=(mIdx=0,gIdx=0,Acc=0)
      Elements(352)=(mIdx=0,gIdx=0,Acc=0)
      Elements(353)=(mIdx=0,gIdx=0,Acc=0)
      Elements(354)=(mIdx=0,gIdx=0,Acc=0)
      Elements(355)=(mIdx=0,gIdx=0,Acc=0)
      Elements(356)=(mIdx=0,gIdx=0,Acc=0)
      Elements(357)=(mIdx=0,gIdx=0,Acc=0)
      Elements(358)=(mIdx=0,gIdx=0,Acc=0)
      Elements(359)=(mIdx=0,gIdx=0,Acc=0)
      Elements(360)=(mIdx=0,gIdx=0,Acc=0)
      Elements(361)=(mIdx=0,gIdx=0,Acc=0)
      Elements(362)=(mIdx=0,gIdx=0,Acc=0)
      Elements(363)=(mIdx=0,gIdx=0,Acc=0)
      Elements(364)=(mIdx=0,gIdx=0,Acc=0)
      Elements(365)=(mIdx=0,gIdx=0,Acc=0)
      Elements(366)=(mIdx=0,gIdx=0,Acc=0)
      Elements(367)=(mIdx=0,gIdx=0,Acc=0)
      Elements(368)=(mIdx=0,gIdx=0,Acc=0)
      Elements(369)=(mIdx=0,gIdx=0,Acc=0)
      Elements(370)=(mIdx=0,gIdx=0,Acc=0)
      Elements(371)=(mIdx=0,gIdx=0,Acc=0)
      Elements(372)=(mIdx=0,gIdx=0,Acc=0)
      Elements(373)=(mIdx=0,gIdx=0,Acc=0)
      Elements(374)=(mIdx=0,gIdx=0,Acc=0)
      Elements(375)=(mIdx=0,gIdx=0,Acc=0)
      Elements(376)=(mIdx=0,gIdx=0,Acc=0)
      Elements(377)=(mIdx=0,gIdx=0,Acc=0)
      Elements(378)=(mIdx=0,gIdx=0,Acc=0)
      Elements(379)=(mIdx=0,gIdx=0,Acc=0)
      Elements(380)=(mIdx=0,gIdx=0,Acc=0)
      Elements(381)=(mIdx=0,gIdx=0,Acc=0)
      Elements(382)=(mIdx=0,gIdx=0,Acc=0)
      Elements(383)=(mIdx=0,gIdx=0,Acc=0)
      Elements(384)=(mIdx=0,gIdx=0,Acc=0)
      Elements(385)=(mIdx=0,gIdx=0,Acc=0)
      Elements(386)=(mIdx=0,gIdx=0,Acc=0)
      Elements(387)=(mIdx=0,gIdx=0,Acc=0)
      Elements(388)=(mIdx=0,gIdx=0,Acc=0)
      Elements(389)=(mIdx=0,gIdx=0,Acc=0)
      Elements(390)=(mIdx=0,gIdx=0,Acc=0)
      Elements(391)=(mIdx=0,gIdx=0,Acc=0)
      Elements(392)=(mIdx=0,gIdx=0,Acc=0)
      Elements(393)=(mIdx=0,gIdx=0,Acc=0)
      Elements(394)=(mIdx=0,gIdx=0,Acc=0)
      Elements(395)=(mIdx=0,gIdx=0,Acc=0)
      Elements(396)=(mIdx=0,gIdx=0,Acc=0)
      Elements(397)=(mIdx=0,gIdx=0,Acc=0)
      Elements(398)=(mIdx=0,gIdx=0,Acc=0)
      Elements(399)=(mIdx=0,gIdx=0,Acc=0)
      Elements(400)=(mIdx=0,gIdx=0,Acc=0)
      Elements(401)=(mIdx=0,gIdx=0,Acc=0)
      Elements(402)=(mIdx=0,gIdx=0,Acc=0)
      Elements(403)=(mIdx=0,gIdx=0,Acc=0)
      Elements(404)=(mIdx=0,gIdx=0,Acc=0)
      Elements(405)=(mIdx=0,gIdx=0,Acc=0)
      Elements(406)=(mIdx=0,gIdx=0,Acc=0)
      Elements(407)=(mIdx=0,gIdx=0,Acc=0)
      Elements(408)=(mIdx=0,gIdx=0,Acc=0)
      Elements(409)=(mIdx=0,gIdx=0,Acc=0)
      Elements(410)=(mIdx=0,gIdx=0,Acc=0)
      Elements(411)=(mIdx=0,gIdx=0,Acc=0)
      Elements(412)=(mIdx=0,gIdx=0,Acc=0)
      Elements(413)=(mIdx=0,gIdx=0,Acc=0)
      Elements(414)=(mIdx=0,gIdx=0,Acc=0)
      Elements(415)=(mIdx=0,gIdx=0,Acc=0)
      Elements(416)=(mIdx=0,gIdx=0,Acc=0)
      Elements(417)=(mIdx=0,gIdx=0,Acc=0)
      Elements(418)=(mIdx=0,gIdx=0,Acc=0)
      Elements(419)=(mIdx=0,gIdx=0,Acc=0)
      Elements(420)=(mIdx=0,gIdx=0,Acc=0)
      Elements(421)=(mIdx=0,gIdx=0,Acc=0)
      Elements(422)=(mIdx=0,gIdx=0,Acc=0)
      Elements(423)=(mIdx=0,gIdx=0,Acc=0)
      Elements(424)=(mIdx=0,gIdx=0,Acc=0)
      Elements(425)=(mIdx=0,gIdx=0,Acc=0)
      Elements(426)=(mIdx=0,gIdx=0,Acc=0)
      Elements(427)=(mIdx=0,gIdx=0,Acc=0)
      Elements(428)=(mIdx=0,gIdx=0,Acc=0)
      Elements(429)=(mIdx=0,gIdx=0,Acc=0)
      Elements(430)=(mIdx=0,gIdx=0,Acc=0)
      Elements(431)=(mIdx=0,gIdx=0,Acc=0)
      Elements(432)=(mIdx=0,gIdx=0,Acc=0)
      Elements(433)=(mIdx=0,gIdx=0,Acc=0)
      Elements(434)=(mIdx=0,gIdx=0,Acc=0)
      Elements(435)=(mIdx=0,gIdx=0,Acc=0)
      Elements(436)=(mIdx=0,gIdx=0,Acc=0)
      Elements(437)=(mIdx=0,gIdx=0,Acc=0)
      Elements(438)=(mIdx=0,gIdx=0,Acc=0)
      Elements(439)=(mIdx=0,gIdx=0,Acc=0)
      Elements(440)=(mIdx=0,gIdx=0,Acc=0)
      Elements(441)=(mIdx=0,gIdx=0,Acc=0)
      Elements(442)=(mIdx=0,gIdx=0,Acc=0)
      Elements(443)=(mIdx=0,gIdx=0,Acc=0)
      Elements(444)=(mIdx=0,gIdx=0,Acc=0)
      Elements(445)=(mIdx=0,gIdx=0,Acc=0)
      Elements(446)=(mIdx=0,gIdx=0,Acc=0)
      Elements(447)=(mIdx=0,gIdx=0,Acc=0)
      Elements(448)=(mIdx=0,gIdx=0,Acc=0)
      Elements(449)=(mIdx=0,gIdx=0,Acc=0)
      Elements(450)=(mIdx=0,gIdx=0,Acc=0)
      Elements(451)=(mIdx=0,gIdx=0,Acc=0)
      Elements(452)=(mIdx=0,gIdx=0,Acc=0)
      Elements(453)=(mIdx=0,gIdx=0,Acc=0)
      Elements(454)=(mIdx=0,gIdx=0,Acc=0)
      Elements(455)=(mIdx=0,gIdx=0,Acc=0)
      Elements(456)=(mIdx=0,gIdx=0,Acc=0)
      Elements(457)=(mIdx=0,gIdx=0,Acc=0)
      Elements(458)=(mIdx=0,gIdx=0,Acc=0)
      Elements(459)=(mIdx=0,gIdx=0,Acc=0)
      Elements(460)=(mIdx=0,gIdx=0,Acc=0)
      Elements(461)=(mIdx=0,gIdx=0,Acc=0)
      Elements(462)=(mIdx=0,gIdx=0,Acc=0)
      Elements(463)=(mIdx=0,gIdx=0,Acc=0)
      Elements(464)=(mIdx=0,gIdx=0,Acc=0)
      Elements(465)=(mIdx=0,gIdx=0,Acc=0)
      Elements(466)=(mIdx=0,gIdx=0,Acc=0)
      Elements(467)=(mIdx=0,gIdx=0,Acc=0)
      Elements(468)=(mIdx=0,gIdx=0,Acc=0)
      Elements(469)=(mIdx=0,gIdx=0,Acc=0)
      Elements(470)=(mIdx=0,gIdx=0,Acc=0)
      Elements(471)=(mIdx=0,gIdx=0,Acc=0)
      Elements(472)=(mIdx=0,gIdx=0,Acc=0)
      Elements(473)=(mIdx=0,gIdx=0,Acc=0)
      Elements(474)=(mIdx=0,gIdx=0,Acc=0)
      Elements(475)=(mIdx=0,gIdx=0,Acc=0)
      Elements(476)=(mIdx=0,gIdx=0,Acc=0)
      Elements(477)=(mIdx=0,gIdx=0,Acc=0)
      Elements(478)=(mIdx=0,gIdx=0,Acc=0)
      Elements(479)=(mIdx=0,gIdx=0,Acc=0)
      Elements(480)=(mIdx=0,gIdx=0,Acc=0)
      Elements(481)=(mIdx=0,gIdx=0,Acc=0)
      Elements(482)=(mIdx=0,gIdx=0,Acc=0)
      Elements(483)=(mIdx=0,gIdx=0,Acc=0)
      Elements(484)=(mIdx=0,gIdx=0,Acc=0)
      Elements(485)=(mIdx=0,gIdx=0,Acc=0)
      Elements(486)=(mIdx=0,gIdx=0,Acc=0)
      Elements(487)=(mIdx=0,gIdx=0,Acc=0)
      Elements(488)=(mIdx=0,gIdx=0,Acc=0)
      Elements(489)=(mIdx=0,gIdx=0,Acc=0)
      Elements(490)=(mIdx=0,gIdx=0,Acc=0)
      Elements(491)=(mIdx=0,gIdx=0,Acc=0)
      Elements(492)=(mIdx=0,gIdx=0,Acc=0)
      Elements(493)=(mIdx=0,gIdx=0,Acc=0)
      Elements(494)=(mIdx=0,gIdx=0,Acc=0)
      Elements(495)=(mIdx=0,gIdx=0,Acc=0)
      Elements(496)=(mIdx=0,gIdx=0,Acc=0)
      Elements(497)=(mIdx=0,gIdx=0,Acc=0)
      Elements(498)=(mIdx=0,gIdx=0,Acc=0)
      Elements(499)=(mIdx=0,gIdx=0,Acc=0)
      Elements(500)=(mIdx=0,gIdx=0,Acc=0)
      Elements(501)=(mIdx=0,gIdx=0,Acc=0)
      Elements(502)=(mIdx=0,gIdx=0,Acc=0)
      Elements(503)=(mIdx=0,gIdx=0,Acc=0)
      Elements(504)=(mIdx=0,gIdx=0,Acc=0)
      Elements(505)=(mIdx=0,gIdx=0,Acc=0)
      Elements(506)=(mIdx=0,gIdx=0,Acc=0)
      Elements(507)=(mIdx=0,gIdx=0,Acc=0)
      Elements(508)=(mIdx=0,gIdx=0,Acc=0)
      Elements(509)=(mIdx=0,gIdx=0,Acc=0)
      Elements(510)=(mIdx=0,gIdx=0,Acc=0)
      Elements(511)=(mIdx=0,gIdx=0,Acc=0)
      iMe=0
}
