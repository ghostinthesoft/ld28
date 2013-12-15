package;

import flash.Lib;
import flixel.FlxGame;
import flixel.system.FlxAssets;
	
/**
 * The Game
 * 
 * @author Al1
 */

class Game extends FlxGame
{	
	// use default flixel embed font
	public static inline var FONT_MAIN:String = null;

	public static inline var FONT_BEAUTIFUL:String = "assets/tangerine.ttf";
	public static inline var FONT_MENU:String = FONT_MAIN;
	public static inline var FONT_TALK:String = FONT_MAIN;
	
	
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