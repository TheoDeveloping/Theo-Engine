package;

import flixel.FlxG;
import lime.utils.Assets;
#if sys
import sys.io.File;
import sys.FileSystem;
#else
import openfl.utils.Assets;
#end

using StringTools;

class CoolUtil
{
	public static var difficultyArray:Array<String> = ['EASY', "NORMAL", "HARD"];

	public static function difficultyString():String
	{
		return difficultyArray[PlayState.storyDifficulty];
	}

	inline public static function boundTo(value:Float, min:Float, max:Float):Float {
		return Math.max(min, Math.min(max, value));
	}

	public static function loadFromUrl(url:String) {
		#if linux
		Sys.command('/usr/bin/xdg-open', [url]);
		#else
		FlxG.openURL(url);
		#end
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	public static function camLerpShit(ratio:Float)
	{
		return FlxG.elapsed / (1 / 60) * ratio;
	}

	public static function coolLerp(a:Float, b:Float, ratio:Float)
	{
		return a + camLerpShit(ratio) * (b - a);
	}
}
