class MV_MapResult expands MV_Util;

var string OriginalSong;
var string Map;
var string Song;
var int GameIndex;

// private 

var int ServerPackageCount;
const ServerPackageMaxCount = 1024;
var string ServerPackages[1024];

var LevelInfo LevelInfo;
var bool LevelInfoCached;
var LevelSummary LevelSummary;
var bool LevelSummaryCached;

static function MV_MapResult Create(optional string map, optional int gameIdx){
	local MV_MapResult object;
	object = new class'MV_MapResult';
	object.Map = map;
	object.GameIndex = gameIdx;
	return object;
}

function bool AddPackages(string packageNameList)
{
	local string packageName;
	while (class'MV_Parser'.static.TrySplit(packageNameList, ",", packageName, packageNameList))
	{
		AddPackage(packageName);
	}
}

function bool AddPackage(string packageName)
{
	local int i;
	if (i >= ServerPackageMaxCount)
	{
		Err("Cannot add `"$packageName$"`, max server package count reached!");
		return False;
	}
	for (i=0; i<ServerPackageCount; i++)
	{
		if (ServerPackages[i] == packageName)
		{
			return False;
		}
	}
	ServerPackages[ServerPackageCount] = packageName;
	ServerPackageCount++;
	return True;
}

function string GetPackagesStringList()
{
	local string separator, result;
	local int i;
	separator = "";
	for (i=0; i<ServerPackageCount; i++)
	{
		result = result $ separator $ ServerPackages[i];
		separator = ",";
	}
	return result;
}

function string GetSongString()
{
	LoadSongInformation();
	return OriginalSong;
}

function LoadSongInformation(){
	if (OriginalSong == "")
	{
		OriginalSong = ""$GetLevelInfoObject().Song;
	}
}

function bool CanMapBeLoaded()
{
	if (GetLevelSummaryObject() != None) 
	{
		return true;
	}
	if (GetLevelInfoObject() != None) 
	{
		return true;
	}
	// last resort, probably won't help but hey, we tried
	if (DynamicLoadObject(self.Map$".PlayerStart0", class'PlayerStart') != None) 
	{
		return true;
	}
	return false;
}	

function LevelInfo GetLevelInfoObject()
{
	if (LevelInfoCached)
	{
		return LevelInfo; 
	}
	LevelInfoCached = true;
	// 1st try
	LevelInfo = LevelInfo(DynamicLoadObject(self.Map$".LevelInfo0", class'LevelInfo'));
	if (LevelInfo == None) 
	{
		// 2nd try
		LevelInfo = LevelInfo(DynamicLoadObject(self.Map$".LevelInfo1", class'LevelInfo'));
	}
	return LevelInfo;
}

function LevelSummary GetLevelSummaryObject()
{
	if (LevelSummaryCached)
	{
		return LevelSummary;
	}
	LevelSummaryCached = true;
	LevelSummary = LevelSummary(DynamicLoadObject(self.Map$".LevelSummary", class'LevelSummary'));
	return LevelSummary;
}

defaultproperties
{
      OriginalSong=""
      Map=""
      Song=""
      GameIndex=0
      ServerPackageCount=0
      ServerPackages(0)=""
      ServerPackages(1)=""
      ServerPackages(2)=""
      ServerPackages(3)=""
      ServerPackages(4)=""
      ServerPackages(5)=""
      ServerPackages(6)=""
      ServerPackages(7)=""
      ServerPackages(8)=""
      ServerPackages(9)=""
      ServerPackages(10)=""
      ServerPackages(11)=""
      ServerPackages(12)=""
      ServerPackages(13)=""
      ServerPackages(14)=""
      ServerPackages(15)=""
      ServerPackages(16)=""
      ServerPackages(17)=""
      ServerPackages(18)=""
      ServerPackages(19)=""
      ServerPackages(20)=""
      ServerPackages(21)=""
      ServerPackages(22)=""
      ServerPackages(23)=""
      ServerPackages(24)=""
      ServerPackages(25)=""
      ServerPackages(26)=""
      ServerPackages(27)=""
      ServerPackages(28)=""
      ServerPackages(29)=""
      ServerPackages(30)=""
      ServerPackages(31)=""
      ServerPackages(32)=""
      ServerPackages(33)=""
      ServerPackages(34)=""
      ServerPackages(35)=""
      ServerPackages(36)=""
      ServerPackages(37)=""
      ServerPackages(38)=""
      ServerPackages(39)=""
      ServerPackages(40)=""
      ServerPackages(41)=""
      ServerPackages(42)=""
      ServerPackages(43)=""
      ServerPackages(44)=""
      ServerPackages(45)=""
      ServerPackages(46)=""
      ServerPackages(47)=""
      ServerPackages(48)=""
      ServerPackages(49)=""
      ServerPackages(50)=""
      ServerPackages(51)=""
      ServerPackages(52)=""
      ServerPackages(53)=""
      ServerPackages(54)=""
      ServerPackages(55)=""
      ServerPackages(56)=""
      ServerPackages(57)=""
      ServerPackages(58)=""
      ServerPackages(59)=""
      ServerPackages(60)=""
      ServerPackages(61)=""
      ServerPackages(62)=""
      ServerPackages(63)=""
      ServerPackages(64)=""
      ServerPackages(65)=""
      ServerPackages(66)=""
      ServerPackages(67)=""
      ServerPackages(68)=""
      ServerPackages(69)=""
      ServerPackages(70)=""
      ServerPackages(71)=""
      ServerPackages(72)=""
      ServerPackages(73)=""
      ServerPackages(74)=""
      ServerPackages(75)=""
      ServerPackages(76)=""
      ServerPackages(77)=""
      ServerPackages(78)=""
      ServerPackages(79)=""
      ServerPackages(80)=""
      ServerPackages(81)=""
      ServerPackages(82)=""
      ServerPackages(83)=""
      ServerPackages(84)=""
      ServerPackages(85)=""
      ServerPackages(86)=""
      ServerPackages(87)=""
      ServerPackages(88)=""
      ServerPackages(89)=""
      ServerPackages(90)=""
      ServerPackages(91)=""
      ServerPackages(92)=""
      ServerPackages(93)=""
      ServerPackages(94)=""
      ServerPackages(95)=""
      ServerPackages(96)=""
      ServerPackages(97)=""
      ServerPackages(98)=""
      ServerPackages(99)=""
      ServerPackages(100)=""
      ServerPackages(101)=""
      ServerPackages(102)=""
      ServerPackages(103)=""
      ServerPackages(104)=""
      ServerPackages(105)=""
      ServerPackages(106)=""
      ServerPackages(107)=""
      ServerPackages(108)=""
      ServerPackages(109)=""
      ServerPackages(110)=""
      ServerPackages(111)=""
      ServerPackages(112)=""
      ServerPackages(113)=""
      ServerPackages(114)=""
      ServerPackages(115)=""
      ServerPackages(116)=""
      ServerPackages(117)=""
      ServerPackages(118)=""
      ServerPackages(119)=""
      ServerPackages(120)=""
      ServerPackages(121)=""
      ServerPackages(122)=""
      ServerPackages(123)=""
      ServerPackages(124)=""
      ServerPackages(125)=""
      ServerPackages(126)=""
      ServerPackages(127)=""
      ServerPackages(128)=""
      ServerPackages(129)=""
      ServerPackages(130)=""
      ServerPackages(131)=""
      ServerPackages(132)=""
      ServerPackages(133)=""
      ServerPackages(134)=""
      ServerPackages(135)=""
      ServerPackages(136)=""
      ServerPackages(137)=""
      ServerPackages(138)=""
      ServerPackages(139)=""
      ServerPackages(140)=""
      ServerPackages(141)=""
      ServerPackages(142)=""
      ServerPackages(143)=""
      ServerPackages(144)=""
      ServerPackages(145)=""
      ServerPackages(146)=""
      ServerPackages(147)=""
      ServerPackages(148)=""
      ServerPackages(149)=""
      ServerPackages(150)=""
      ServerPackages(151)=""
      ServerPackages(152)=""
      ServerPackages(153)=""
      ServerPackages(154)=""
      ServerPackages(155)=""
      ServerPackages(156)=""
      ServerPackages(157)=""
      ServerPackages(158)=""
      ServerPackages(159)=""
      ServerPackages(160)=""
      ServerPackages(161)=""
      ServerPackages(162)=""
      ServerPackages(163)=""
      ServerPackages(164)=""
      ServerPackages(165)=""
      ServerPackages(166)=""
      ServerPackages(167)=""
      ServerPackages(168)=""
      ServerPackages(169)=""
      ServerPackages(170)=""
      ServerPackages(171)=""
      ServerPackages(172)=""
      ServerPackages(173)=""
      ServerPackages(174)=""
      ServerPackages(175)=""
      ServerPackages(176)=""
      ServerPackages(177)=""
      ServerPackages(178)=""
      ServerPackages(179)=""
      ServerPackages(180)=""
      ServerPackages(181)=""
      ServerPackages(182)=""
      ServerPackages(183)=""
      ServerPackages(184)=""
      ServerPackages(185)=""
      ServerPackages(186)=""
      ServerPackages(187)=""
      ServerPackages(188)=""
      ServerPackages(189)=""
      ServerPackages(190)=""
      ServerPackages(191)=""
      ServerPackages(192)=""
      ServerPackages(193)=""
      ServerPackages(194)=""
      ServerPackages(195)=""
      ServerPackages(196)=""
      ServerPackages(197)=""
      ServerPackages(198)=""
      ServerPackages(199)=""
      ServerPackages(200)=""
      ServerPackages(201)=""
      ServerPackages(202)=""
      ServerPackages(203)=""
      ServerPackages(204)=""
      ServerPackages(205)=""
      ServerPackages(206)=""
      ServerPackages(207)=""
      ServerPackages(208)=""
      ServerPackages(209)=""
      ServerPackages(210)=""
      ServerPackages(211)=""
      ServerPackages(212)=""
      ServerPackages(213)=""
      ServerPackages(214)=""
      ServerPackages(215)=""
      ServerPackages(216)=""
      ServerPackages(217)=""
      ServerPackages(218)=""
      ServerPackages(219)=""
      ServerPackages(220)=""
      ServerPackages(221)=""
      ServerPackages(222)=""
      ServerPackages(223)=""
      ServerPackages(224)=""
      ServerPackages(225)=""
      ServerPackages(226)=""
      ServerPackages(227)=""
      ServerPackages(228)=""
      ServerPackages(229)=""
      ServerPackages(230)=""
      ServerPackages(231)=""
      ServerPackages(232)=""
      ServerPackages(233)=""
      ServerPackages(234)=""
      ServerPackages(235)=""
      ServerPackages(236)=""
      ServerPackages(237)=""
      ServerPackages(238)=""
      ServerPackages(239)=""
      ServerPackages(240)=""
      ServerPackages(241)=""
      ServerPackages(242)=""
      ServerPackages(243)=""
      ServerPackages(244)=""
      ServerPackages(245)=""
      ServerPackages(246)=""
      ServerPackages(247)=""
      ServerPackages(248)=""
      ServerPackages(249)=""
      ServerPackages(250)=""
      ServerPackages(251)=""
      ServerPackages(252)=""
      ServerPackages(253)=""
      ServerPackages(254)=""
      ServerPackages(255)=""
      ServerPackages(256)=""
      ServerPackages(257)=""
      ServerPackages(258)=""
      ServerPackages(259)=""
      ServerPackages(260)=""
      ServerPackages(261)=""
      ServerPackages(262)=""
      ServerPackages(263)=""
      ServerPackages(264)=""
      ServerPackages(265)=""
      ServerPackages(266)=""
      ServerPackages(267)=""
      ServerPackages(268)=""
      ServerPackages(269)=""
      ServerPackages(270)=""
      ServerPackages(271)=""
      ServerPackages(272)=""
      ServerPackages(273)=""
      ServerPackages(274)=""
      ServerPackages(275)=""
      ServerPackages(276)=""
      ServerPackages(277)=""
      ServerPackages(278)=""
      ServerPackages(279)=""
      ServerPackages(280)=""
      ServerPackages(281)=""
      ServerPackages(282)=""
      ServerPackages(283)=""
      ServerPackages(284)=""
      ServerPackages(285)=""
      ServerPackages(286)=""
      ServerPackages(287)=""
      ServerPackages(288)=""
      ServerPackages(289)=""
      ServerPackages(290)=""
      ServerPackages(291)=""
      ServerPackages(292)=""
      ServerPackages(293)=""
      ServerPackages(294)=""
      ServerPackages(295)=""
      ServerPackages(296)=""
      ServerPackages(297)=""
      ServerPackages(298)=""
      ServerPackages(299)=""
      ServerPackages(300)=""
      ServerPackages(301)=""
      ServerPackages(302)=""
      ServerPackages(303)=""
      ServerPackages(304)=""
      ServerPackages(305)=""
      ServerPackages(306)=""
      ServerPackages(307)=""
      ServerPackages(308)=""
      ServerPackages(309)=""
      ServerPackages(310)=""
      ServerPackages(311)=""
      ServerPackages(312)=""
      ServerPackages(313)=""
      ServerPackages(314)=""
      ServerPackages(315)=""
      ServerPackages(316)=""
      ServerPackages(317)=""
      ServerPackages(318)=""
      ServerPackages(319)=""
      ServerPackages(320)=""
      ServerPackages(321)=""
      ServerPackages(322)=""
      ServerPackages(323)=""
      ServerPackages(324)=""
      ServerPackages(325)=""
      ServerPackages(326)=""
      ServerPackages(327)=""
      ServerPackages(328)=""
      ServerPackages(329)=""
      ServerPackages(330)=""
      ServerPackages(331)=""
      ServerPackages(332)=""
      ServerPackages(333)=""
      ServerPackages(334)=""
      ServerPackages(335)=""
      ServerPackages(336)=""
      ServerPackages(337)=""
      ServerPackages(338)=""
      ServerPackages(339)=""
      ServerPackages(340)=""
      ServerPackages(341)=""
      ServerPackages(342)=""
      ServerPackages(343)=""
      ServerPackages(344)=""
      ServerPackages(345)=""
      ServerPackages(346)=""
      ServerPackages(347)=""
      ServerPackages(348)=""
      ServerPackages(349)=""
      ServerPackages(350)=""
      ServerPackages(351)=""
      ServerPackages(352)=""
      ServerPackages(353)=""
      ServerPackages(354)=""
      ServerPackages(355)=""
      ServerPackages(356)=""
      ServerPackages(357)=""
      ServerPackages(358)=""
      ServerPackages(359)=""
      ServerPackages(360)=""
      ServerPackages(361)=""
      ServerPackages(362)=""
      ServerPackages(363)=""
      ServerPackages(364)=""
      ServerPackages(365)=""
      ServerPackages(366)=""
      ServerPackages(367)=""
      ServerPackages(368)=""
      ServerPackages(369)=""
      ServerPackages(370)=""
      ServerPackages(371)=""
      ServerPackages(372)=""
      ServerPackages(373)=""
      ServerPackages(374)=""
      ServerPackages(375)=""
      ServerPackages(376)=""
      ServerPackages(377)=""
      ServerPackages(378)=""
      ServerPackages(379)=""
      ServerPackages(380)=""
      ServerPackages(381)=""
      ServerPackages(382)=""
      ServerPackages(383)=""
      ServerPackages(384)=""
      ServerPackages(385)=""
      ServerPackages(386)=""
      ServerPackages(387)=""
      ServerPackages(388)=""
      ServerPackages(389)=""
      ServerPackages(390)=""
      ServerPackages(391)=""
      ServerPackages(392)=""
      ServerPackages(393)=""
      ServerPackages(394)=""
      ServerPackages(395)=""
      ServerPackages(396)=""
      ServerPackages(397)=""
      ServerPackages(398)=""
      ServerPackages(399)=""
      ServerPackages(400)=""
      ServerPackages(401)=""
      ServerPackages(402)=""
      ServerPackages(403)=""
      ServerPackages(404)=""
      ServerPackages(405)=""
      ServerPackages(406)=""
      ServerPackages(407)=""
      ServerPackages(408)=""
      ServerPackages(409)=""
      ServerPackages(410)=""
      ServerPackages(411)=""
      ServerPackages(412)=""
      ServerPackages(413)=""
      ServerPackages(414)=""
      ServerPackages(415)=""
      ServerPackages(416)=""
      ServerPackages(417)=""
      ServerPackages(418)=""
      ServerPackages(419)=""
      ServerPackages(420)=""
      ServerPackages(421)=""
      ServerPackages(422)=""
      ServerPackages(423)=""
      ServerPackages(424)=""
      ServerPackages(425)=""
      ServerPackages(426)=""
      ServerPackages(427)=""
      ServerPackages(428)=""
      ServerPackages(429)=""
      ServerPackages(430)=""
      ServerPackages(431)=""
      ServerPackages(432)=""
      ServerPackages(433)=""
      ServerPackages(434)=""
      ServerPackages(435)=""
      ServerPackages(436)=""
      ServerPackages(437)=""
      ServerPackages(438)=""
      ServerPackages(439)=""
      ServerPackages(440)=""
      ServerPackages(441)=""
      ServerPackages(442)=""
      ServerPackages(443)=""
      ServerPackages(444)=""
      ServerPackages(445)=""
      ServerPackages(446)=""
      ServerPackages(447)=""
      ServerPackages(448)=""
      ServerPackages(449)=""
      ServerPackages(450)=""
      ServerPackages(451)=""
      ServerPackages(452)=""
      ServerPackages(453)=""
      ServerPackages(454)=""
      ServerPackages(455)=""
      ServerPackages(456)=""
      ServerPackages(457)=""
      ServerPackages(458)=""
      ServerPackages(459)=""
      ServerPackages(460)=""
      ServerPackages(461)=""
      ServerPackages(462)=""
      ServerPackages(463)=""
      ServerPackages(464)=""
      ServerPackages(465)=""
      ServerPackages(466)=""
      ServerPackages(467)=""
      ServerPackages(468)=""
      ServerPackages(469)=""
      ServerPackages(470)=""
      ServerPackages(471)=""
      ServerPackages(472)=""
      ServerPackages(473)=""
      ServerPackages(474)=""
      ServerPackages(475)=""
      ServerPackages(476)=""
      ServerPackages(477)=""
      ServerPackages(478)=""
      ServerPackages(479)=""
      ServerPackages(480)=""
      ServerPackages(481)=""
      ServerPackages(482)=""
      ServerPackages(483)=""
      ServerPackages(484)=""
      ServerPackages(485)=""
      ServerPackages(486)=""
      ServerPackages(487)=""
      ServerPackages(488)=""
      ServerPackages(489)=""
      ServerPackages(490)=""
      ServerPackages(491)=""
      ServerPackages(492)=""
      ServerPackages(493)=""
      ServerPackages(494)=""
      ServerPackages(495)=""
      ServerPackages(496)=""
      ServerPackages(497)=""
      ServerPackages(498)=""
      ServerPackages(499)=""
      ServerPackages(500)=""
      ServerPackages(501)=""
      ServerPackages(502)=""
      ServerPackages(503)=""
      ServerPackages(504)=""
      ServerPackages(505)=""
      ServerPackages(506)=""
      ServerPackages(507)=""
      ServerPackages(508)=""
      ServerPackages(509)=""
      ServerPackages(510)=""
      ServerPackages(511)=""
      ServerPackages(512)=""
      ServerPackages(513)=""
      ServerPackages(514)=""
      ServerPackages(515)=""
      ServerPackages(516)=""
      ServerPackages(517)=""
      ServerPackages(518)=""
      ServerPackages(519)=""
      ServerPackages(520)=""
      ServerPackages(521)=""
      ServerPackages(522)=""
      ServerPackages(523)=""
      ServerPackages(524)=""
      ServerPackages(525)=""
      ServerPackages(526)=""
      ServerPackages(527)=""
      ServerPackages(528)=""
      ServerPackages(529)=""
      ServerPackages(530)=""
      ServerPackages(531)=""
      ServerPackages(532)=""
      ServerPackages(533)=""
      ServerPackages(534)=""
      ServerPackages(535)=""
      ServerPackages(536)=""
      ServerPackages(537)=""
      ServerPackages(538)=""
      ServerPackages(539)=""
      ServerPackages(540)=""
      ServerPackages(541)=""
      ServerPackages(542)=""
      ServerPackages(543)=""
      ServerPackages(544)=""
      ServerPackages(545)=""
      ServerPackages(546)=""
      ServerPackages(547)=""
      ServerPackages(548)=""
      ServerPackages(549)=""
      ServerPackages(550)=""
      ServerPackages(551)=""
      ServerPackages(552)=""
      ServerPackages(553)=""
      ServerPackages(554)=""
      ServerPackages(555)=""
      ServerPackages(556)=""
      ServerPackages(557)=""
      ServerPackages(558)=""
      ServerPackages(559)=""
      ServerPackages(560)=""
      ServerPackages(561)=""
      ServerPackages(562)=""
      ServerPackages(563)=""
      ServerPackages(564)=""
      ServerPackages(565)=""
      ServerPackages(566)=""
      ServerPackages(567)=""
      ServerPackages(568)=""
      ServerPackages(569)=""
      ServerPackages(570)=""
      ServerPackages(571)=""
      ServerPackages(572)=""
      ServerPackages(573)=""
      ServerPackages(574)=""
      ServerPackages(575)=""
      ServerPackages(576)=""
      ServerPackages(577)=""
      ServerPackages(578)=""
      ServerPackages(579)=""
      ServerPackages(580)=""
      ServerPackages(581)=""
      ServerPackages(582)=""
      ServerPackages(583)=""
      ServerPackages(584)=""
      ServerPackages(585)=""
      ServerPackages(586)=""
      ServerPackages(587)=""
      ServerPackages(588)=""
      ServerPackages(589)=""
      ServerPackages(590)=""
      ServerPackages(591)=""
      ServerPackages(592)=""
      ServerPackages(593)=""
      ServerPackages(594)=""
      ServerPackages(595)=""
      ServerPackages(596)=""
      ServerPackages(597)=""
      ServerPackages(598)=""
      ServerPackages(599)=""
      ServerPackages(600)=""
      ServerPackages(601)=""
      ServerPackages(602)=""
      ServerPackages(603)=""
      ServerPackages(604)=""
      ServerPackages(605)=""
      ServerPackages(606)=""
      ServerPackages(607)=""
      ServerPackages(608)=""
      ServerPackages(609)=""
      ServerPackages(610)=""
      ServerPackages(611)=""
      ServerPackages(612)=""
      ServerPackages(613)=""
      ServerPackages(614)=""
      ServerPackages(615)=""
      ServerPackages(616)=""
      ServerPackages(617)=""
      ServerPackages(618)=""
      ServerPackages(619)=""
      ServerPackages(620)=""
      ServerPackages(621)=""
      ServerPackages(622)=""
      ServerPackages(623)=""
      ServerPackages(624)=""
      ServerPackages(625)=""
      ServerPackages(626)=""
      ServerPackages(627)=""
      ServerPackages(628)=""
      ServerPackages(629)=""
      ServerPackages(630)=""
      ServerPackages(631)=""
      ServerPackages(632)=""
      ServerPackages(633)=""
      ServerPackages(634)=""
      ServerPackages(635)=""
      ServerPackages(636)=""
      ServerPackages(637)=""
      ServerPackages(638)=""
      ServerPackages(639)=""
      ServerPackages(640)=""
      ServerPackages(641)=""
      ServerPackages(642)=""
      ServerPackages(643)=""
      ServerPackages(644)=""
      ServerPackages(645)=""
      ServerPackages(646)=""
      ServerPackages(647)=""
      ServerPackages(648)=""
      ServerPackages(649)=""
      ServerPackages(650)=""
      ServerPackages(651)=""
      ServerPackages(652)=""
      ServerPackages(653)=""
      ServerPackages(654)=""
      ServerPackages(655)=""
      ServerPackages(656)=""
      ServerPackages(657)=""
      ServerPackages(658)=""
      ServerPackages(659)=""
      ServerPackages(660)=""
      ServerPackages(661)=""
      ServerPackages(662)=""
      ServerPackages(663)=""
      ServerPackages(664)=""
      ServerPackages(665)=""
      ServerPackages(666)=""
      ServerPackages(667)=""
      ServerPackages(668)=""
      ServerPackages(669)=""
      ServerPackages(670)=""
      ServerPackages(671)=""
      ServerPackages(672)=""
      ServerPackages(673)=""
      ServerPackages(674)=""
      ServerPackages(675)=""
      ServerPackages(676)=""
      ServerPackages(677)=""
      ServerPackages(678)=""
      ServerPackages(679)=""
      ServerPackages(680)=""
      ServerPackages(681)=""
      ServerPackages(682)=""
      ServerPackages(683)=""
      ServerPackages(684)=""
      ServerPackages(685)=""
      ServerPackages(686)=""
      ServerPackages(687)=""
      ServerPackages(688)=""
      ServerPackages(689)=""
      ServerPackages(690)=""
      ServerPackages(691)=""
      ServerPackages(692)=""
      ServerPackages(693)=""
      ServerPackages(694)=""
      ServerPackages(695)=""
      ServerPackages(696)=""
      ServerPackages(697)=""
      ServerPackages(698)=""
      ServerPackages(699)=""
      ServerPackages(700)=""
      ServerPackages(701)=""
      ServerPackages(702)=""
      ServerPackages(703)=""
      ServerPackages(704)=""
      ServerPackages(705)=""
      ServerPackages(706)=""
      ServerPackages(707)=""
      ServerPackages(708)=""
      ServerPackages(709)=""
      ServerPackages(710)=""
      ServerPackages(711)=""
      ServerPackages(712)=""
      ServerPackages(713)=""
      ServerPackages(714)=""
      ServerPackages(715)=""
      ServerPackages(716)=""
      ServerPackages(717)=""
      ServerPackages(718)=""
      ServerPackages(719)=""
      ServerPackages(720)=""
      ServerPackages(721)=""
      ServerPackages(722)=""
      ServerPackages(723)=""
      ServerPackages(724)=""
      ServerPackages(725)=""
      ServerPackages(726)=""
      ServerPackages(727)=""
      ServerPackages(728)=""
      ServerPackages(729)=""
      ServerPackages(730)=""
      ServerPackages(731)=""
      ServerPackages(732)=""
      ServerPackages(733)=""
      ServerPackages(734)=""
      ServerPackages(735)=""
      ServerPackages(736)=""
      ServerPackages(737)=""
      ServerPackages(738)=""
      ServerPackages(739)=""
      ServerPackages(740)=""
      ServerPackages(741)=""
      ServerPackages(742)=""
      ServerPackages(743)=""
      ServerPackages(744)=""
      ServerPackages(745)=""
      ServerPackages(746)=""
      ServerPackages(747)=""
      ServerPackages(748)=""
      ServerPackages(749)=""
      ServerPackages(750)=""
      ServerPackages(751)=""
      ServerPackages(752)=""
      ServerPackages(753)=""
      ServerPackages(754)=""
      ServerPackages(755)=""
      ServerPackages(756)=""
      ServerPackages(757)=""
      ServerPackages(758)=""
      ServerPackages(759)=""
      ServerPackages(760)=""
      ServerPackages(761)=""
      ServerPackages(762)=""
      ServerPackages(763)=""
      ServerPackages(764)=""
      ServerPackages(765)=""
      ServerPackages(766)=""
      ServerPackages(767)=""
      ServerPackages(768)=""
      ServerPackages(769)=""
      ServerPackages(770)=""
      ServerPackages(771)=""
      ServerPackages(772)=""
      ServerPackages(773)=""
      ServerPackages(774)=""
      ServerPackages(775)=""
      ServerPackages(776)=""
      ServerPackages(777)=""
      ServerPackages(778)=""
      ServerPackages(779)=""
      ServerPackages(780)=""
      ServerPackages(781)=""
      ServerPackages(782)=""
      ServerPackages(783)=""
      ServerPackages(784)=""
      ServerPackages(785)=""
      ServerPackages(786)=""
      ServerPackages(787)=""
      ServerPackages(788)=""
      ServerPackages(789)=""
      ServerPackages(790)=""
      ServerPackages(791)=""
      ServerPackages(792)=""
      ServerPackages(793)=""
      ServerPackages(794)=""
      ServerPackages(795)=""
      ServerPackages(796)=""
      ServerPackages(797)=""
      ServerPackages(798)=""
      ServerPackages(799)=""
      ServerPackages(800)=""
      ServerPackages(801)=""
      ServerPackages(802)=""
      ServerPackages(803)=""
      ServerPackages(804)=""
      ServerPackages(805)=""
      ServerPackages(806)=""
      ServerPackages(807)=""
      ServerPackages(808)=""
      ServerPackages(809)=""
      ServerPackages(810)=""
      ServerPackages(811)=""
      ServerPackages(812)=""
      ServerPackages(813)=""
      ServerPackages(814)=""
      ServerPackages(815)=""
      ServerPackages(816)=""
      ServerPackages(817)=""
      ServerPackages(818)=""
      ServerPackages(819)=""
      ServerPackages(820)=""
      ServerPackages(821)=""
      ServerPackages(822)=""
      ServerPackages(823)=""
      ServerPackages(824)=""
      ServerPackages(825)=""
      ServerPackages(826)=""
      ServerPackages(827)=""
      ServerPackages(828)=""
      ServerPackages(829)=""
      ServerPackages(830)=""
      ServerPackages(831)=""
      ServerPackages(832)=""
      ServerPackages(833)=""
      ServerPackages(834)=""
      ServerPackages(835)=""
      ServerPackages(836)=""
      ServerPackages(837)=""
      ServerPackages(838)=""
      ServerPackages(839)=""
      ServerPackages(840)=""
      ServerPackages(841)=""
      ServerPackages(842)=""
      ServerPackages(843)=""
      ServerPackages(844)=""
      ServerPackages(845)=""
      ServerPackages(846)=""
      ServerPackages(847)=""
      ServerPackages(848)=""
      ServerPackages(849)=""
      ServerPackages(850)=""
      ServerPackages(851)=""
      ServerPackages(852)=""
      ServerPackages(853)=""
      ServerPackages(854)=""
      ServerPackages(855)=""
      ServerPackages(856)=""
      ServerPackages(857)=""
      ServerPackages(858)=""
      ServerPackages(859)=""
      ServerPackages(860)=""
      ServerPackages(861)=""
      ServerPackages(862)=""
      ServerPackages(863)=""
      ServerPackages(864)=""
      ServerPackages(865)=""
      ServerPackages(866)=""
      ServerPackages(867)=""
      ServerPackages(868)=""
      ServerPackages(869)=""
      ServerPackages(870)=""
      ServerPackages(871)=""
      ServerPackages(872)=""
      ServerPackages(873)=""
      ServerPackages(874)=""
      ServerPackages(875)=""
      ServerPackages(876)=""
      ServerPackages(877)=""
      ServerPackages(878)=""
      ServerPackages(879)=""
      ServerPackages(880)=""
      ServerPackages(881)=""
      ServerPackages(882)=""
      ServerPackages(883)=""
      ServerPackages(884)=""
      ServerPackages(885)=""
      ServerPackages(886)=""
      ServerPackages(887)=""
      ServerPackages(888)=""
      ServerPackages(889)=""
      ServerPackages(890)=""
      ServerPackages(891)=""
      ServerPackages(892)=""
      ServerPackages(893)=""
      ServerPackages(894)=""
      ServerPackages(895)=""
      ServerPackages(896)=""
      ServerPackages(897)=""
      ServerPackages(898)=""
      ServerPackages(899)=""
      ServerPackages(900)=""
      ServerPackages(901)=""
      ServerPackages(902)=""
      ServerPackages(903)=""
      ServerPackages(904)=""
      ServerPackages(905)=""
      ServerPackages(906)=""
      ServerPackages(907)=""
      ServerPackages(908)=""
      ServerPackages(909)=""
      ServerPackages(910)=""
      ServerPackages(911)=""
      ServerPackages(912)=""
      ServerPackages(913)=""
      ServerPackages(914)=""
      ServerPackages(915)=""
      ServerPackages(916)=""
      ServerPackages(917)=""
      ServerPackages(918)=""
      ServerPackages(919)=""
      ServerPackages(920)=""
      ServerPackages(921)=""
      ServerPackages(922)=""
      ServerPackages(923)=""
      ServerPackages(924)=""
      ServerPackages(925)=""
      ServerPackages(926)=""
      ServerPackages(927)=""
      ServerPackages(928)=""
      ServerPackages(929)=""
      ServerPackages(930)=""
      ServerPackages(931)=""
      ServerPackages(932)=""
      ServerPackages(933)=""
      ServerPackages(934)=""
      ServerPackages(935)=""
      ServerPackages(936)=""
      ServerPackages(937)=""
      ServerPackages(938)=""
      ServerPackages(939)=""
      ServerPackages(940)=""
      ServerPackages(941)=""
      ServerPackages(942)=""
      ServerPackages(943)=""
      ServerPackages(944)=""
      ServerPackages(945)=""
      ServerPackages(946)=""
      ServerPackages(947)=""
      ServerPackages(948)=""
      ServerPackages(949)=""
      ServerPackages(950)=""
      ServerPackages(951)=""
      ServerPackages(952)=""
      ServerPackages(953)=""
      ServerPackages(954)=""
      ServerPackages(955)=""
      ServerPackages(956)=""
      ServerPackages(957)=""
      ServerPackages(958)=""
      ServerPackages(959)=""
      ServerPackages(960)=""
      ServerPackages(961)=""
      ServerPackages(962)=""
      ServerPackages(963)=""
      ServerPackages(964)=""
      ServerPackages(965)=""
      ServerPackages(966)=""
      ServerPackages(967)=""
      ServerPackages(968)=""
      ServerPackages(969)=""
      ServerPackages(970)=""
      ServerPackages(971)=""
      ServerPackages(972)=""
      ServerPackages(973)=""
      ServerPackages(974)=""
      ServerPackages(975)=""
      ServerPackages(976)=""
      ServerPackages(977)=""
      ServerPackages(978)=""
      ServerPackages(979)=""
      ServerPackages(980)=""
      ServerPackages(981)=""
      ServerPackages(982)=""
      ServerPackages(983)=""
      ServerPackages(984)=""
      ServerPackages(985)=""
      ServerPackages(986)=""
      ServerPackages(987)=""
      ServerPackages(988)=""
      ServerPackages(989)=""
      ServerPackages(990)=""
      ServerPackages(991)=""
      ServerPackages(992)=""
      ServerPackages(993)=""
      ServerPackages(994)=""
      ServerPackages(995)=""
      ServerPackages(996)=""
      ServerPackages(997)=""
      ServerPackages(998)=""
      ServerPackages(999)=""
      ServerPackages(1000)=""
      ServerPackages(1001)=""
      ServerPackages(1002)=""
      ServerPackages(1003)=""
      ServerPackages(1004)=""
      ServerPackages(1005)=""
      ServerPackages(1006)=""
      ServerPackages(1007)=""
      ServerPackages(1008)=""
      ServerPackages(1009)=""
      ServerPackages(1010)=""
      ServerPackages(1011)=""
      ServerPackages(1012)=""
      ServerPackages(1013)=""
      ServerPackages(1014)=""
      ServerPackages(1015)=""
      ServerPackages(1016)=""
      ServerPackages(1017)=""
      ServerPackages(1018)=""
      ServerPackages(1019)=""
      ServerPackages(1020)=""
      ServerPackages(1021)=""
      ServerPackages(1022)=""
      ServerPackages(1023)=""
}
