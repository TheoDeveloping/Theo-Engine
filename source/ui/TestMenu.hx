package ui;

import flixel.text.FlxText;
import flixel.FlxG;

class TestMenu extends MusicBeatState
{
    var changeSelection:Int;

    override function create()
    {
        var text:FlxText = new FlxText();

        super.create();
    }
    function changeSelect(change:Int)
    {
        changeSelection += change;
    }
}