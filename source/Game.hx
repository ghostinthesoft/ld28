package;

import flash.Lib;
import flixel.FlxGame;
	
class Game extends FlxGame
{	
	public function new()
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		
		var ratioX:Float = stageWidth / 400;
		var ratioY:Float = stageHeight / 240;
		var ratio:Float = Math.min(ratioX, ratioY);
		
		var fps:Int = 60;

		super(Math.ceil(stageWidth / ratio), Math.ceil(stageHeight / ratio), Lang, ratio, fps, fps);
	}
}