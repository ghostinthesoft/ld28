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
 * A FlxState which can be used for the game's menu.
 */
class StateIntro extends StateFade
{
	private var m_intro:FlxText;
	private var m_elapsed:Float;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		m_bgColor = 0xFFFFFFFF;
		super.create();

		m_elapsed = 0;
		
		m_intro = new FlxText(FlxG.width / 2 - 175, FlxG.height * 0.3, 350);
		m_intro.antialiasing = false;
		m_intro.setFormat(null, 14, 0xFF000000, "center", FlxText.BORDER_NONE, 0, false);
		m_intro.text=Lang.getString(Lang.INTRO);
		add(m_intro);
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
		
		if (m_elapsed>5 || FlxG.mouse.justPressed)
		{
			_leaveState(_changeState);
		}
		
	}
	
	public function _changeState():Void
	{
		FlxG.switchState(new StateTitle());
	}
}