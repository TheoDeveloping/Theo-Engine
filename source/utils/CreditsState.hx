package utils;

import haxe.rtti.CType.Abstractdef;
#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import CreditsMetaData;
import CreditsTitleData;

using StringTools;

class CreditsState extends MusicBeatState
{
	var songs:Array<CreditsMetaData> = [];

	var titles:Array<CreditsTitleData> = [];

	var selector:FlxText;
	var curSelected:Int = 0;

	var creditText:String;

	var charText:Alphabet;

	var bg:FlxSprite;

	private var grpCredits:FlxTypedGroup<Alphabet>;

	private var grpText:FlxTypedGroup<Alphabet>;

	private var creditsInfo:Array<Array<String>> = [];

	private var coolColors = [];

	private var curPlaying:Bool = false;

	private var iconArray:Array<IconState> = [];

	public var description:String = 'null';

	var text:FlxText;

	override function create()
	{
		if (FlxG.sound.music != null)
		{
			if (!FlxG.sound.music.playing)
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		creditText = '';

		#if desktop
		DiscordClient.changePresence("TESTING THE FUCKING CREDIT MENU, MAKING A MENU OF FNF ITS A HELL", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		var creditsThing:Array<Array<String>> = [
			['Theo Engine Team', 'true'],
			['TheoDev', 'theo', 'Creator of theo engine', '0xFF1565C0', 'https://www.youtube.com/c/TheoDeveloper'],
			['EstoyAburridow', 'aburridow', 'A great code helper', '0xFF80CEE8', 'https://www.youtube.com/channel/UC9Z5udAzJhXako8CoAd2okA'],
			['Konull', 'kunno', 'Main animator, artist', '0xFFBDBDBD', 'https://www.youtube.com/channel/UCi_xw_cLbN_T6xoFYqKlAeA']
		];

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);

		grpCredits = new FlxTypedGroup<Alphabet>();
		add(grpCredits);

		for (i in creditsThing) {
			creditsInfo.push(i);
		}

		for (i in 0...creditsInfo.length) {
			var isTitle:Bool = isTitleCheck(i);

			charText = new Alphabet(0, (70 * i) + 30, creditsInfo[i][0], isTitle, false);
			charText.isMenuItem = true;
			charText.isCentered = true;
			charText.targetY = i;
			grpCredits.add(charText);

			if (!isTitle) {
				charText.x -= 70;
			}

			var icon:IconState = new IconState(creditsInfo[i][1]);
			icon.sprTracker = charText;

			iconArray.push(icon);
			add(icon);
		}

		changeSelection();

		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";

		var textBG:FlxSprite = new FlxSprite(0, 650).makeGraphic(FlxG.width, 26, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

		text = new FlxText(textBG.x - 1, textBG.y + 4, FlxG.width, description, 18);
		text.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT);
		text.scrollFactor.set();
		text.alignment = CENTER;
		text.x += 15;
		add(text);

		#if mobileC
		addVirtualPad(UP_DOWN, A_B);
		#end

		super.create();
	}

	override function update(elapsed:Float)
	{	
		for (i in 0...creditsInfo.length) {
			var isTitle:Bool = isTitleCheck(i);

			if (!isTitle)
				description = creditsInfo[curSelected][2];
		}


		super.update(elapsed);


		if (FlxG.sound.music != null && FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		bg.color = FlxColor.interpolate(bg.color, FlxColor.fromString(creditsInfo[curSelected][3]), CoolUtil.camLerpShit(0.045));

		if (controls.UI_UP_P)
		{
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound("cancelMenu"));
			FlxG.switchState(new ui.OptionsState());
		}

		if (controls.ACCEPT)
		{
			for (i in 0...creditsInfo.length) {
				var isTitle:Bool = isTitleCheck(i);
			if (!isTitle)
				CoolUtil.loadFromUrl(creditsInfo[i][3]);
			}

		}
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		//iconArray[curSelected].alpha = 1;

		for (item in grpCredits.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
			{
				item.alpha = 1;
			}
		}
	}

	function isTitleCheck(char:Int):Bool {
		return creditsInfo[char].length <= 1;
	}
}