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
class StateIntro1 extends StateFade
{
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		m_bgColor = 0xFFFFFFFF;
		super.create();

		var _intro:FlxText;
		
		_intro = new FlxText(FlxG.width / 2 - 200, (1)*FlxG.height / 8, 400, Lang.getString(Lang.INTRO1_1));
		_intro.setFormat(Game.FONT_BEAUTIFUL, 28, 0xFF000000, "center");
		add(_intro);
		_intro = new FlxText(FlxG.width / 2 - 200, (2)*FlxG.height / 8, 400, Lang.getString(Lang.INTRO1_2));
		_intro.setFormat(Game.FONT_BEAUTIFUL, 28, 0xFF000000, "center");
		add(_intro);
		_intro = new FlxText(FlxG.width / 2 - 200, (3)*FlxG.height / 8, 400, Lang.getString(Lang.INTRO1_3));
		_intro.setFormat(Game.FONT_BEAUTIFUL, 28, 0xFF000000, "center");
		add(_intro);
		_intro = new FlxText(FlxG.width / 2 - 200, (4)*FlxG.height / 8, 400, Lang.getString(Lang.INTRO1_4));
		_intro.setFormat(Game.FONT_BEAUTIFUL, 28, 0xFF000000, "center");
		add(_intro);
		_intro = new FlxText(FlxG.width / 2 - 200, (5)*FlxG.height / 8, 400, Lang.getString(Lang.INTRO1_5));
		_intro.setFormat(Game.FONT_BEAUTIFUL, 28, 0xFF000000, "center");
		add(_intro);
	}


	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		if (!m_enable)
			return;
			
		if (FlxG.mouse.justPressed)
		{
			_leaveState(_changeState);
		}
		
	}
	
	public function _changeState():Void
	{
		FlxG.switchState(new Stage1());
	}
}