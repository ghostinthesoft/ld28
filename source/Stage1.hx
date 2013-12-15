package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * Stage1 state
 * 
 * @author Al1
 */

class Stage1 extends Stage
{
	static private var HOSTILE_WALK_TALKS:Array<Int> = [Lang.STAGE1_HOSTILE_WALK_TEXT1, Lang.STAGE1_HOSTILE_WALK_TEXT2, Lang.STAGE1_HOSTILE_WALK_TEXT3];
	
	private var m_lastTalk:Int=-1;
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		// declaration of characters and bg
		m_step = new Array<Int>();
		m_char = new Array<Character>();
		
		m_char.push(new Character(Character.STAGE1_HOSTILE));
		m_char[0].setx( -Character.CHARACTER_WIDTH2 );
		
		m_char.push(new Character(Character.STAGE1_FRIENDLY));
		m_char[1].setx( FlxG.width + Character.CHARACTER_WIDTH2 );
		
		m_bg = new FlxSprite();
		m_bg.loadGraphic("assets/b_stage1.png", false, false);
		m_bg.setPosition(0, 0);
		
		// hostile is walking
		m_step.push(Stage.STEP_WALK_AND_TALK);
		m_char[0].gotox = FlxG.width*0.5;
		
		// friendly is waiting
		m_step.push(Stage.STEP_WAIT);
		
		FlxG.debugger.visible = true;
		
		super.create();
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
		
		switch(m_step[0])
		{
			case Stage.STEP_WALK_AND_TALK:

			if (m_char[0].movex == 0)
			{
				// talk
				if (!m_char[0].isTalking)
				{
					var _needTalk:Bool = (Math.random() < 0.5);
					if (_needTalk)
					{
						var _text:Int;
						while (HOSTILE_WALK_TALKS[(_text = Math.floor(Math.random() * HOSTILE_WALK_TALKS.length))] == m_lastTalk) { }
						m_lastTalk = HOSTILE_WALK_TALKS[_text];
						m_char[0].talk(m_lastTalk);
					}
				}
					
				// if friendly is outside, let come in
				/*if (m_step[1] == Stage.STEP_WAIT)
				{
					var _changeStep:Bool = (Math.random() < 0.5);
					if (_changeStep)
					{
						m_step[1] = Stage.STEP_WALK_AND_TALK;
						m_char[1].movex = 0;
					}
					
					// char 0 become targetable
					m_char[0].targetable = true;
				}*/
			}
		}
		
		super.update();
		
		
		if (FlxG.mouse.justPressed)
		{
			//m_char[0].talk(StateLang.);
			//FlxG.log.add("pressed");
			//_leaveState(false);
		}
	}
	
}