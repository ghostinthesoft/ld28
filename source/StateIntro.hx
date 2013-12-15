package ;

import flash.ui.Mouse;
import flash.ui.MouseCursor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * Main Intro State
 * 
 * @author Al1
 */
class StateIntro extends StateFade
{
	private var m_elapsed:Float;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		m_bgColor = 0xFFFFFFFF;
		super.create();

		m_elapsed = 0;
		
		var _intro2:FlxText = new FlxText(FlxG.width / 2 - 200, FlxG.height/2-70, 400, Lang.getString(Lang.INTRO2));
		_intro2.setFormat(Game.FONT_BEAUTIFUL, 32, 0xFF000000, "center");

		var _intro3:FlxText = new FlxText(FlxG.width / 2 - 200, FlxG.height/2-30, 400, Lang.getString(Lang.INTRO3));
		_intro3.setFormat(Game.FONT_BEAUTIFUL, 32, 0xFF000000, "center");

		add(_intro2);
		add(_intro3);
	}


	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		if (!m_enable)
			return;
			
		m_elapsed += FlxG.elapsed;
		
		if (m_elapsed>3 || FlxG.mouse.justPressed)
		{
			_leaveState(_changeState);
		}
		
	}
	
	public function _changeState():Void
	{
		FlxG.switchState(new StateTitle());
	}
}