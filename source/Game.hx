package;

import flash.Lib;
import flixel.FlxGame;
	
class Game extends FlxGame
{	
	public static inline var FADE_COLOR:Int = 0xFFFFFFFF;
	public static inline var FADE_DURATION:Float = 0.5;
	
	public function new()
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		
		var ratioX:Float = stageWidth / 400;
		var ratioY:Float = stageHeight / 240;
		var ratio:Float = Math.min(ratioX, ratioY);
		
		var fps:Int = 60;

		super(Math.ceil(stageWidth / ratio), Math.ceil(stageHeight / ratio), Stage1, ratio, fps, fps);
	}
}