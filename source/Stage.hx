package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxCollision;
import flixel.util.FlxMath;

/**
 * Stage behavior
 * 
 * @author Al1
 */

class Stage extends StateFade
{
	public static inline var STEP_IDLE:Int = 0;
	public static inline var STEP_WAIT:Int = 1;
	
	public static inline var STEP_FINAL:Int = 13;
	
	public static inline var STEP_WALK_AND_TALK:Int = 20;
	public static inline var STEP_STAGE1_CHAR0_ENTER:Int = 21;
	public static inline var STEP_STAGE1_CHAR1_ENTER:Int = 22;
	public static inline var STEP_GO_RIGHT:Int = 23;
	public static inline var STEP_GO_LEFT:Int = 24;

	public static inline var STEP_FOLLOW:Int = 32;
	public static inline var STEP_HOLD:Int = 33;
	
	
	// private
	static private var WIN_TALKS:Array<Int> = [Lang.FINAL_WIN1];
	static private var LOOSE_TALKS:Array<Int> = [Lang.FINAL_LOOSE1];
	
	private static inline var FINAL_WAIT:Float = 3;
	private static inline var PARADE_OVER:Float = 2;

	private static inline var RIGHT_MARGIN:Int = 64;
	private static inline var LEFT_MARGIN:Int = 256;
	
	
	private var m_num:Int = 1;
	
	private var m_step:Array<Int>;
	private var m_char:Array<Character>;
	
	private var m_bg:FlxSprite;
	private var m_launch:FlxSprite;

	private var m_wait_talk:Int = 0;
	private var m_wait:Float = 0;

	private var m_missed:Int=0;
	private var m_lastTalk:Int=-1;

	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

		// init launch
		m_launch = null;
		
		// add elements
		add(m_bg);				
		add(m_char[0]);
		add(m_char[1]);
		
		// process state for characters
		_processStep(0);
		_processStep(1);
		
		m_sound = new Button(FlxG.width - 8-4, 4, 3);
		add(m_sound);
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		m_wait -= FlxG.elapsed;
		
		if (!m_enable)
		{
			super.update();
			return;
		}
		
		if (m_launch==null && FlxG.mouse.justPressed && FlxG.mouse.screenY>32)
		{
			Game.play("assets/s_launch.mp3", true);
			m_launch = new Yogourt(_launchComplete);
			add(m_launch);
		}
		
		// process state for characters
		_processStep(0);
		_processStep(1);
		
		super.update();
	}
	
	private function _launchComplete():Void
	{
		// final step for hostile
		m_step[0] = STEP_FINAL;
		m_char[0].movex = 0;
		
		var _touched:Bool = m_char[0].checkCollision(m_launch);
		if (!_touched)
			m_missed = 1;
		else 
		{
			if (m_char[0].targetable)
				m_missed = 0;
			else
				m_missed = 2;
		}

		if (_touched && !m_char[0].targetable)
		{
			m_char[0].arms = true;
			var _vecx:Float = FlxG.mouse.screenX - m_char[0].posx;
			var _vecy:Float = FlxG.mouse.screenY - m_char[0].posy;
			var _armangle:Float = 180*Math.atan2(_vecy, _vecx)/Math.PI-90;
			m_char[0].armsangle = _armangle;
		}

		m_wait = FINAL_WAIT;
		if (m_missed == 0)
			_talk(WIN_TALKS, 1);
		else
			_talk(LOOSE_TALKS, 1);
		
		// friendly go out
		m_step[1] = STEP_GO_RIGHT;
		m_char[1].speed = Character.SPEED_RUN1;
	}
	
	private function _processStep(a_idx:Int):Void
	{
		// reset holding & following if not valid anymore
		if (m_char[a_idx].holding != null && m_step[a_idx]!=STEP_HOLD)
			m_char[a_idx].holding = null;
					
		if (m_char[a_idx].following != null && m_step[a_idx] != STEP_FOLLOW)
		{
			m_char[a_idx].following = null;
			m_char[a_idx].arms = false;
		}
					
		// process the current step
		switch(m_step[a_idx])
		{
			case STEP_FINAL:
				if (m_wait < PARADE_OVER)
				{
					m_char[0].arms = false;
				}
				if (m_wait < 0 && m_wait>-999)
				{
					m_wait = -999;
					// coming if not touched
					if (m_missed!=0)
						_setComing(0);
					_leaveState(_end);
				}
			case STEP_FOLLOW:
				// taken in hostage
				m_char[a_idx].following = m_char[0];
				m_char[a_idx].arms = true;
			case STEP_HOLD:
				// taking in hostage
				m_char[a_idx].holding = m_char[1];
				if (m_char[a_idx].movex == 0)
					_setNewWalk(a_idx);
			case STEP_WALK_AND_TALK:
			// if walk is over, set a new walk
			if (m_char[a_idx].movex == 0)
				_setNewWalk(a_idx);
			case STEP_STAGE1_CHAR0_ENTER, STEP_STAGE1_CHAR1_ENTER:
				// go to the center
				m_char[a_idx].gotox = FlxG.width / 2;
				if (a_idx == 0)
					m_char[0].wearing = false;
				else
					m_char[1].wearing = true;
			case STEP_GO_LEFT:
				m_char[a_idx].gotox = - LEFT_MARGIN;
			case STEP_GO_RIGHT:
				m_char[a_idx].gotox = FlxG.width + RIGHT_MARGIN;

			case STEP_IDLE:
			m_char[a_idx].movex = 0;
			default:
			m_char[a_idx].movex = 0;
		}
	}
	
	private function _end():Void
	{
		FlxG.camera.stopFX();
		remove(m_sound);
		remove(m_bg);
		remove(m_char[0]);
		remove(m_char[1]);
		if (m_missed == 0)
		{
			_finalScreen();
		}
		else
		{
			FlxG.camera.flash(0xFFFF0000, 2, _finalScreen);
			FlxG.camera.shake(0.1,2);
		}
	}
	
	private function _finalScreen():Void
	{
		Game.stopAll();
		
		var _title:FlxText = new FlxText(20, 50, FlxG.width - 40);
		_title.setFormat(Game.FONT_BEAUTIFUL, 32, 0x000000, "center");
		if (m_missed == 0)
			_title.text = Lang.getString(Lang.CONGRATULATIONS);
		else
			_title.text = Lang.getString(Lang.GAME_OVER);
		add(_title);
		
		var _end:FlxText = new FlxText(20, 100, FlxG.width - 40);
		_end.setFormat(Game.Game.FONT_BEAUTIFUL, 24, 0x000000, "center");
		add(_end);
		
		if (m_missed==0)
		{
			if (m_num==1)
				_end.text = Lang.getString(Lang.WIN1);
		}
		else if (m_missed==1)
		{
			_end.text = Lang.getString(Lang.LOOSE_MISSED);
		}
		else
		{
			_end.text = Lang.getString(Lang.LOOSE_PARADE);
		}
		var _btn1:Button = new Button(FlxG.width / 2, 2 * FlxG.height / 3, 0, Lang.getString(Lang.MENU_REPLAY));
		_btn1.setOnUpCallback(_onBtnReplay);
		var _btn2:Button = new Button(FlxG.width / 2, 2*FlxG.height / 3+30, 0, Lang.getString(Lang.MENU_TITLE));
		_btn2.setOnUpCallback(_onBtnTitle);
		add(_btn1);
		add(_btn2);
	}
	
	private function _onBtnReplay():Void
	{
		_leaveState(_goReplay);
	}

	private function _onBtnTitle():Void
	{
		_leaveState(_goTitle);
	}

	private function _goReplay():Void
	{
		if (m_num==1)
			FlxG.switchState(new Stage1());
	}

	private function _goTitle():Void
	{
		FlxG.switchState(new StateTitle());
	}

	private function _setNewWalk(a_idx:Int):Void
	{
		var _newgotox:Float = 0;
		var _checkx:Float = 0;
		while ( _checkx < 100 )
		{
			_newgotox = Math.random() * (FlxG.width - 128) + 64;
			_checkx = _newgotox - m_char[a_idx].gotox;
			if (_checkx < 0) _checkx = -_checkx;
		}
		m_char[a_idx].gotox = _newgotox;
	}
	
	private function _setComing(a_idx:Int):Void
	{
		// hide arms
		m_char[0].arms = false;
		m_char[a_idx].come(FlxG.width/2);
	}
	
	private function _talk(a_talks:Array<Int>, a_probability:Float):Void
	{
		// talk
		var _needTalk:Bool = (Math.random() < a_probability);
		if (_needTalk)
		{
			m_wait_talk--;
			var _text:Int;
			while (a_talks[(_text = Math.floor(Math.random() * a_talks.length))] == m_lastTalk) { if (a_talks.length == 1) break; }
			m_lastTalk = a_talks[_text];
			m_char[0].talk(m_lastTalk);
		}
	}
	
}