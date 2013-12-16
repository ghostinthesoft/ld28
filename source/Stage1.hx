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
	static private var HOSTILE_HOLD_TALKS:Array<Int> = [Lang.STAGE1_HOSTILE_HOLD_TEXT1, Lang.STAGE1_HOSTILE_HOLD_TEXT2];
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		// declaration of characters and bg
		m_step = new Array<Int>();
		m_char = new Array<Character>();
		
		m_char.push(new Character(Character.STAGE1_HOSTILE));
		
		m_char.push(new Character(Character.STAGE1_FRIENDLY));
		
		m_bg = new FlxSprite();
		m_bg.loadGraphic("assets/b_stage1.png", false, false);
		m_bg.setPosition(0, 0);
		
		// hostile is walking
		m_step.push(Stage.STEP_HOLD);
		m_char[0].posx = FlxG.width*0.5 ;
		m_char[0].gotox = FlxG.width*0.5;
		
		// friendly is waiting
		m_step.push(Stage.STEP_FOLLOW);
		m_char[1].posx = FlxG.width*0.5 ;
		m_char[1].gotox = FlxG.width*0.5;
		
		// waiting at least 3 talks before changing step
		m_wait_talk = 3;
		
		//FlxG.debugger.visible = true;
		
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
			case Stage.STEP_GO_LEFT:
			if (m_char[0].movex == 0)
			{
				m_step[0] = Stage.STEP_STAGE1_CHAR0_ENTER;
				m_char[0].speed = Character.SPEED_DEFAULT;
				m_char[0].targetable = true;
				m_step[1] = Stage.STEP_STAGE1_CHAR1_ENTER;
				m_char[1].speed = Character.SPEED_DEFAULT;
			}
			case Stage.STEP_STAGE1_CHAR0_ENTER:
			if (m_char[0].movex == 0)
			{
				m_char[0].targetable = false;
				m_step[0] = Stage.STEP_HOLD;
				m_step[1] = Stage.STEP_FOLLOW;
				m_wait_talk = 3;				
			}
			case Stage.STEP_WALK_AND_TALK:
			if (m_char[0].movex == 0)
			{
				if (!m_char[0].isTalking)
				{
					if (m_wait_talk>0)
						_talk(HOSTILE_WALK_TALKS, 0.5);
					else
					{
						m_step[0] = Stage.STEP_GO_LEFT;
					}
				}
			}
			case Stage.STEP_HOLD:
			if (m_char[0].movex == 0)
			{
				if (!m_char[0].isTalking)
				{
					if (m_wait_talk>0)
						_talk(HOSTILE_HOLD_TALKS, 0.8);
					else if (Math.random() < 0.5)
					{
						m_step[0] = Stage.STEP_WALK_AND_TALK;
						m_char[0].wearing = true;
						m_step[1] = Stage.STEP_GO_RIGHT;
						m_char[1].wearing = false;
						m_char[1].speed = Character.SPEED_RUN1;
						m_wait_talk = 2;
					}
				}
			}
		}
		

		super.update();
	}

}