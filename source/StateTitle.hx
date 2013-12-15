package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * Main Title State
 * 
 * @author Al1
 */
class StateTitle extends StateFade
{
	public static inline var TITLE_SPEED:Float = 2;
	
	private var m_title:FlxSprite;
	private var m_start:Button;
	private var m_credits:Button;
	
	private var m_percent:Float;
	private var m_scale_step:Int;
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		m_bgColor = 0xFF000000;
		
		var _intro1:FlxText = new FlxText(FlxG.width / 2 - 200, 10, 400, Lang.getString(Lang.INTRO1));
		_intro1.setFormat(Game.FONT_BEAUTIFUL, 24, 0xFFFFFFFF, "center");
		add(_intro1);
		
		m_title = new FlxSprite();
		m_title.loadGraphic("assets/b_title.png", false, false, 256, 64);
		m_title.setPosition(FlxG.width / 2, 0);
		m_title.offset.x = 128;
		m_title.offset.y = 32;
		m_percent = 0;
		m_title.scale.x = m_title.scale.y = m_percent;
		m_title.antialiasing = false;
		m_scale_step = 0;
		add(m_title);
		
		m_start = new Button(FlxG.width / 2, 3 * FlxG.height / 4 - 30, 0, Lang.getString(Lang.MENU_START));
		m_start.setOnDownCallback(_onStart);
		//m_start.setFormat("assets/Designer-Notes.ttf", 25, 0x888888, "center", FlxText.BORDER_NONE, 0, true);
		add(m_start);

		m_credits = new Button(FlxG.width / 2, 3 * FlxG.height / 4, 0, Lang.getString(Lang.MENU_CREDITS));
		m_credits.setOnDownCallback(_onCredits);
		//m_credits.setFormat("assets/Designer-Notes.ttf", 25, 0x888888, "center", FlxText.BORDER_NONE, 0, true);
		add(m_credits);

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
		
		if (m_scale_step==0)
		{
			m_percent += FlxG.elapsed*TITLE_SPEED;
			var _percent2:Float = m_percent*m_percent;
			var _percent4:Float = _percent2*_percent2;
			m_title.scale.x = m_title.scale.y = _percent4;
			m_title.setPosition(FlxG.width / 2, FlxG.height/3*m_percent);

			if (m_title.scale.x > 1)
			{
				m_scale_step++;
			}
		}
		
	}
	
	private function _onStart():Void
	{
		_leaveState(_onStartReady);
	}
	
	private function _onCredits():Void
	{
		_leaveState(_onCreditsReady);
	}
	
	private function _onStartReady():Void
	{
		FlxG.switchState(new Stage1());
	}

	private function _onCreditsReady():Void
	{
		FlxG.switchState(new StateCredits());
	}
}