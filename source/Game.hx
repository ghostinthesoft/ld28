package;

import flash.Lib;
import flixel.FlxG;
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

		super(Math.ceil(stageWidth / ratio), Math.ceil(stageHeight / ratio), Lang, ratio, fps, fps);
	}
	
	static public function playMusic():Void
	{
		FlxG.sound.playMusic("assets/s_theme.mp3");
	}
	
	static public function stopAll():Void
	{
		m_talking_sound = -1;
		FlxG.sound.destroySounds();
	}
	
	static private var m_readyToPlay:Bool = true;
	static public function play(a_sound:String, a_force:Bool=false):Void
	{
		if (!a_force)
		{
			if (m_readyToPlay)
			{
				m_readyToPlay = false;
				FlxG.sound.play(a_sound, 1, false, true, _onSoundComplete);
			}
		}
		else
		{
			FlxG.sound.play(a_sound, 1, false, true);
		}
	}
	
	static private var m_talking_sound:Int = -1;
	static public function talk():Void
	{
		if (m_readyToPlay)
		{
			var _talkmax:Int = 7;
			var _talknum:Int = Std.int(Math.floor(Math.random() * _talkmax));
			if ( _talknum == m_talking_sound )
				_talknum = (_talknum + 1) % _talkmax;
			m_talking_sound = _talknum;
			m_readyToPlay = false;
			FlxG.sound.play("assets/s_talk" + m_talking_sound + ".mp3", 1, false, true, _onSoundComplete);
		}
	}
	
	static public function _onSoundComplete():Void
	{
		m_readyToPlay = true;
	}
}