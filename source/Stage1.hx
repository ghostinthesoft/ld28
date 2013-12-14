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
class Stage1 extends FadeState
{
	private var m_man1:Man;
	private var m_person1:Person;
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		
		FlxG.debugger.visible = true;
		
		var _bg = new FlxSprite();
		_bg.loadGraphic("assets/b_stage1.png", false, false);
		_bg.setPosition(0, 0);
		add(_bg);				
		
		
		m_man1 = new Man(Mover.STAGE1_MAN);
		m_man1.setx( -64);
		add(m_man1);		
		
		//m_person1 = new Person(Mover.STAGE1_PERSON1);
		
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
		
		if (m_man1.move == 0)
		{
			m_man1.goto(Math.random()*FlxG.width);
		}
		
		/*if (FlxG.mouse.justPressed)
		{
			FlxG.log.add("pressed");
			_leaveState(false);
		}*/
	}
}