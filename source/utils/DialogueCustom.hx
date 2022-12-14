package utils;

class DialogueCustom
{
    public function new(hasDialog:Bool = false)
    {
        //super();

		var dialoguePath:Array<Dynamic> = [
		['Pico'],
		['Senpai', 'Roses', 'Thorns']
		];

        for (i in 0...dialoguePath.length)
        {
			var data = dialoguePath[i];

            data[i] = PlayState.songName;
        }
    }
	override function update(elapsed:Float)
        {
            super.update(elapsed);

            if (data[i].hasDialog == true)
                trace(data[i] + " is enableded the dialogues");
        }
}