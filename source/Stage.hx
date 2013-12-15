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
	
	public static inline var STEP_MISS:Int = 10;
	public static inline var STEP_PARADE:Int = 11;
	public static inline var STEP_TOUCHED:Int = 12;
	
	public static inline var STEP_WALK_AND_TALK:Int = 20;
	public static inline var STEP_STAGE1_CHAR1_ENTER:Int = 21;
	public static inline var STEP_GO_RIGHT:Int = 22;
	
	private var m_num:Int = 1;
	
	private var m_step:Array<Int>;
	private var m_char:Array<Character>;
	
	private var m_bg:FlxSprite;
	private var m_launch:FlxSprite;
	
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
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		if (!m_enable)
		{
			super.update();
			return;
		}
		
		if (/*m_launch==null && */FlxG.mouse.justPressed)
		{
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
		var _touched:Bool = m_char[0].checkCollision(m_launch);
		if (m_char[0].targetable)
		{
			// missed ?
			if (_touched)
			{
				FlxG.log.add("touched");
				m_step[0] = STEP_TOUCHED;
			}
			else
			{
				FlxG.log.add("missed");
				m_step[0] = STEP_MISS;
			}
		}
		else
		{
			FlxG.log.add("parade");
			m_step[0] = STEP_PARADE;
		}
		
		// friendly go out
		m_step[1] = STEP_GO_RIGHT;
	}
	
	private function _processStep(a_idx:Int):Void
	{
		// process the current step
		switch(m_step[a_idx])
		{
			case STEP_MISS:
			// the shot was missed, the guy is coming
				_setComing(0);
				_leaveState(_end);
			case STEP_PARADE:
			// the shot was ok but guy use parade
				_setComing(0);
				_leaveState(_end);
			case STEP_TOUCHED:
			// the shot was ok !
				_leaveState(_end);
			case STEP_WALK_AND_TALK:
			// if walk is over, set a new walk
			if (m_char[a_idx].movex == 0)
				_setNewWalk(a_idx);
			case STEP_STAGE1_CHAR1_ENTER:
			// after char1 entering, man is coming
			if (m_char[a_idx].movex == 0)
			{
				
			}
			case STEP_IDLE:
			// do nothing
			m_char[a_idx].movex = 0;
			
			default:
			// do nothing
			m_char[a_idx].movex = 0;
		}
	}
	
	private function _end():Void
	{
		FlxG.camera.stopFX();
		remove(m_bg);
		remove(m_char[0]);
		remove(m_char[1]);
		if (m_step[0] == STEP_TOUCHED)
		{
			FlxG.camera.flash(0xFFFFFFFF, 1, _finalScreen);
		}
		else
		{
			FlxG.camera.flash(0xFFFF0000, 1, _finalScreen);
			FlxG.camera.shake();
		}
	}
	
	private function _finalScreen():Void
	{
		var _gameover:FlxText = new FlxText(20, 50, FlxG.width - 40);
		_gameover.setFormat(Game.FONT_BEAUTIFUL, 32, 0x000000, "center");
		_gameover.text = Lang.getString(Lang.GAME_OVER);
		add(_gameover);
		
		var _end:FlxText = new FlxText(20, 100, FlxG.width - 40);
		_end.setFormat(Game.Game.FONT_BEAUTIFUL, 24, 0x000000, "center");
		add(_end);
		
		if (m_step[0] == STEP_TOUCHED)
		{
			if (m_num==1)
				_end.text = Lang.getString(Lang.WIN1);
		}
		else if (m_step[0] == STEP_PARADE)
		{
			_end.text = Lang.getString(Lang.LOOSE_PARADE);
		}
		else
		{
			_end.text = Lang.getString(Lang.LOOSE_MISSED);
		}
		var _btn1:Button = new Button(FlxG.width / 2, 2 * FlxG.height / 3, 0, Lang.getString(Lang.MENU_REPLAY));
		_btn1.setOnDownCallback(_onBtnReplay);
		var _btn2:Button = new Button(FlxG.width / 2, 2*FlxG.height / 3+30, 0, Lang.getString(Lang.MENU_TITLE));
		_btn2.setOnDownCallback(_onBtnTitle);
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
		m_char[a_idx].come(FlxG.width/2);
	}
}