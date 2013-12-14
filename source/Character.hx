package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup.FlxTypedGroup;
import flixel.util.FlxPoint;

/**
 * ...
 * @author 
 */
class Character extends FlxTypedGroup<FlxSprite>
{
	public static inline var STAGE1_MAN:Int = 0;
	public static inline var STAGE1_PERSON1:Int = 1;
	
	private static inline var GOTO_TOLERANCE:Float = 2;
	private static inline var GOTO_SPEED:Float = 100;
	
	private var m_move:Int;
	private var m_gotox:Float;
	private var m_rightspeed:FlxPoint;
	private var m_leftspeed:FlxPoint;
	private var m_idlespeed:FlxPoint;
	
	private var _x:Int = 0;
	private var _y:Int = 0;
	
	private var m_type:Int;
	private var m_body:FlxSprite;
	
	

	public function new(a_type:Int) 
	{
		m_type = a_type;

		super();
		m_rightspeed = new FlxPoint(GOTO_SPEED, 0);
		m_leftspeed = new FlxPoint(-GOTO_SPEED, 0);
		m_idlespeed = new FlxPoint(0, 0);
		m_move = 0;
		
		m_body = new FlxSprite();
		m_body.loadGraphic("assets/b_man1.png", true, false, 64, 128);
		m_body.animation.add("idle", [0], 12, false);
		m_body.animation.add("walk", [0, 1, 2, 3, 4, 5], 12, true);
		add(m_body);
	}
	
	
	/*public var x(get_x, set_x):Int;
	public function set_x(nx:Int):Int
	{
		var offset:Int = nx - _x;
		
		for (object in members) 
			object.x += offset;
		
		return _x = nx;
	}
	
	public function get_x():Int { return _x; }
	
	public var y(get_y, set_y):Int;
	public function set_y(ny:Int):Int
	{
		var offset:Int = ny - _y;
		
		for (object in members) 
			object.y += offset;
		
		return _y = ny;
	}
	
	public function get_y():Int { return _y;  }
	*/
	
	public var move(get_move, null):Int;
	private function get_move():Int
	{
		return m_move;
	}

	// go to screen position
	public function setx(a_x:Float):Void
	{
		m_body.setPosition(a_x, 50);
	}

	// go to screen position
	public function goto(a_gotox:Float):Void
	{
		m_gotox = a_gotox;
		var diff:Float = m_gotox - m_body.x;
		if (diff > 0)
			m_move = 1;
		if (diff < 0)
			m_move = -1;
	}

	
	
	override public function update():Void
	{
		super.update();
		if (m_move == 0)
			return;
			
		var _gotoIdle:Bool = false;
		var diff:Float = m_gotox - m_body.x;
		if ( diff>GOTO_TOLERANCE )
		{
			if (m_move == 1)
			{
				m_body.velocity = m_rightspeed;
				m_body.facing = FlxObject.RIGHT;
				m_body.animation.play("walk");
			}
			else
				_gotoIdle = true;
		}
		else if ( diff<-GOTO_TOLERANCE )
		{
			if (m_move == -1)
			{
				m_body.velocity = m_leftspeed;
				m_body.facing = FlxObject.LEFT;
				m_body.animation.play("walk");
			}
			else
				_gotoIdle = true;
		}
		else
			_gotoIdle = true;
			
		if (_gotoIdle)
		{
			m_move = 0;
			m_body.setPosition(m_gotox, m_body.y);
			m_body.velocity = m_idlespeed;
			m_body.animation.play("idle");
		}
	}

	
}