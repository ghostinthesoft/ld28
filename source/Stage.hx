package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class Stage extends StateFade
{
	public static inline var STEP_IDLE:Int = 0;
	
	public static inline var STEP_OUTSIDE_LEFT:Int = 1;
	public static inline var STEP_OUTSIDE_RIGHT:Int = 2;
	
	public static inline var STEP_WALK_AND_TALK:Int = 3;
	public static inline var STEP_STAGE1_CHAR1_ENTER:Int = 4;
	
	private var m_step:Array<Int>;
	private var m_char:Array<Character>;
	
	private var m_bg:FlxSprite;
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

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
		// process state for characters
		_processStep(0);
		_processStep(1);
		
		super.update();
	}
	
	private function _processStep(a_idx:Int):Void
	{
		// process the current step
		switch(m_step[a_idx])
		{
			case STEP_WALK_AND_TALK:
			// if walk is over, set a new walk
			if (m_char[a_idx].move == 0)
				_setNewWalk(a_idx);
			case STEP_STAGE1_CHAR1_ENTER:
			// after char1 entering, man is coming
			if (m_char[a_idx].move == 0)
			{
				
			}
			case STEP_IDLE:
			// do nothing
			m_char[a_idx].move = 0;
			
			case STEP_OUTSIDE_LEFT, STEP_OUTSIDE_RIGHT:
			// do nothing
			m_char[a_idx].move = 0;
		}
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
}