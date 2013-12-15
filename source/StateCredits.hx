package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * Credits State
 * 
 * @author Al1
 */
class StateCredits extends StateFade
{
	private var m_logo:FlxSprite;
	private var m_text:FlxText;
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		m_logo = new FlxSprite();
		m_logo.loadGraphic("assets/b_logo.jpg", false, false, 200);
		m_logo.setPosition(FlxG.width / 2-100, 16);
		add(m_logo);
		
		var _credit1:FlxText = new FlxText(FlxG.width / 2 - 150, 140, 300, Lang.getString(Lang.CREDITS1));
		var _credit2:FlxText = new FlxText(FlxG.width / 2 - 150, 160, 300, Lang.getString(Lang.CREDITS2));
		var _credit3:FlxText = new FlxText(FlxG.width / 2 - 150, 180, 300, Lang.getString(Lang.CREDITS3));
		_credit1.setFormat(Game.FONT_MENU, 8, 0xFF888888, "center");
		_credit2.setFormat(Game.FONT_MENU, 8, 0xFF888888, "center");
		_credit3.setFormat(Game.FONT_MENU, 8, 0xFF888888, "center");
		
		add(_credit1);
		add(_credit2);
		add(_credit3);

		super.create();
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
		FlxG.switchState(new StateTitle());
	}
}