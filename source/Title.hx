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
class Title extends FlxState
{
	private var m_title:FlxSprite;
	private var m_start:FlxText;
	
	private var m_percent:Float;
	private var m_scale_step:Int;
	
	private var m_enable:Bool;

	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		// Set a background color
		FlxG.cameras.bgColor = 0xff000000;
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end
		
		FlxG.debugger.visible = true;
		
		m_enable = true;
		
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
		
		m_start = new FlxText(FlxG.width / 2, 3*FlxG.height / 4, 100, "Start");
		m_start.setFormat("assets/Designer-Notes.ttf", 25, 0x888888, "center", FlxText.BORDER_NONE, 0, true);
		m_start.offset.x = 50;
		add(m_start);

		super.create();
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
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
			m_percent += FlxG.elapsed;
			var _percent2:Float = m_percent*m_percent;
			var _percent4:Float = _percent2*_percent2;
			m_title.scale.x = m_title.scale.y = _percent4;
			m_title.setPosition(FlxG.width / 2, FlxG.height/3*m_percent);

			if (m_title.scale.x > 1)
			{
				m_scale_step++;
			}
		}

		if (FlxG.mouse.justPressed)
		{
			m_enable = false;
			FlxG.camera.fade(Game.FADE_COLOR, Game.FADE_DURATION, false, _changeState);
			FlxG.log.add("pressed");
		}
		
	}
	
	public function _changeState():Void
	{
		FlxG.switchState(new Stage1());
	}
}