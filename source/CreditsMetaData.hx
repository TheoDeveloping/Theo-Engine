package;

import flixel.util.FlxColor;

using StringTools;

class CreditsMetaData
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var creditInfo:String = "";
	public var color:FlxColor;
	public var page:String;

	public function new(song:String, week:Int, ?songCharacter:String, ?creditInfo:String, ?color:FlxColor, ?page:String)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.creditInfo = creditInfo;
		this.color = color;
		this.page = page;
	}
}
