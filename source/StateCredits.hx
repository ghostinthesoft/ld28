package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
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
		m_bgColor = 0xFFFFFFFF;
		
		m_logo = new FlxSprite();
		m_logo.loadGraphic("assets/b_logo.jpg", false, false, 200, 107);
		m_logo.setPosition(FlxG.width / 2-100, 16);
		add(m_logo);
		
		m_text = new FlxText(FlxG.width / 2-150, 128, 300, Lang.getString(Lang.CREDITS));
		m_text.setFormat(null, 12, 0xFF000000, "center", FlxText.BORDER_NONE, 0, false);
		add(m_text);

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