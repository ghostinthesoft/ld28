package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;

/**
 * ...
 * @author 
 */
class Character extends FlxTypedGroup<FlxSprite>
{
	public static inline var CHARACTER_WIDTH:Int = 64;
	public static inline var CHARACTER_WIDTH2:Int = CHARACTER_WIDTH>>1;

	
	public static inline var STAGE1_HOSTILE:Int = 0;
	public static inline var STAGE1_FRIENDLY:Int = 32;
	
	private static inline var GOTO_TOLERANCE:Float = 2;
	private static inline var GOTO_SPEED:Float = 100;

	private static inline var BODY_WIDTH:Int = 64;
	private static inline var BODY_WIDTH2:Int = BODY_WIDTH>>1;

	
	private var m_move:Int;
	private var m_gotox:Float;
	private var m_rightspeed:FlxPoint;
	private var m_leftspeed:FlxPoint;
	private var m_idlespeed:FlxPoint;
	
	private var _x:Int = 0;
	private var _y:Int = 0;
	
	private var m_type:Int;
	private var m_talking:Float;
	
	
	private var m_talk:FlxText;
	private var m_head:FlxSprite;
	private var m_body:FlxSprite;
	
	

	public function new(a_type:Int) 
	{
		m_type = a_type;

		super();
		m_rightspeed = new FlxPoint(GOTO_SPEED, 0);
		m_leftspeed = new FlxPoint(-GOTO_SPEED, 0);
		m_idlespeed = new FlxPoint(0, 0);
		
		m_move = 0;
		m_gotox = 0;
		
		m_body = new FlxSprite();
		m_body.loadGraphic("assets/b_man1.png", true, true, BODY_WIDTH, 128);
		m_body.animation.add("idle", [0], 12, false);
		m_body.animation.add("walk", [0, 1, 2, 3, 4, 5], 12, true);
		add(m_body);
		
		m_head = new FlxSprite();
		m_head.loadGraphic("assets/b_head1.png", true, true, 32, 32);
		m_head.animation.add("idle", [0], 12, false);
		m_head.animation.add("talk", [1, 2], 6, true);
		add(m_head);
		
		m_talk = new FlxText(0, 0, FlxG.width >> 1);
		m_talk.setFormat(null, 8, 0xFFFFFFFF, "center");
		m_talk.visible = false;
		add(m_talk);
		
		m_body.setPosition(-999, 50);
		m_head.setPosition(-999, 50 - 96);
		
		m_talking = -999;
	}
	
	// say if it's the man or the person
	public var isTalking(get_isTalking, null):Bool;
	private function get_isTalking():Bool
	{
		return m_talking>0;
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
	
	public function get_y():Int { return _y;  }*/
	
	
	public var move(get_move, set_move):Int;
	private function get_move():Int
	{
		return m_move;
	}

	private function set_move(a_move:Int):Int
	{
		return m_move = a_move;
	}

	public function talk(a_text:Int):Void
	{
		var _string:String = Lang.getString(a_text);
		m_talking = _string.length * 0.15;
		if (m_talking < 1)
			m_talking = 1;
		m_talk.text = _string;
		m_head.animation.play("talk");
	}

	public function setx(a_x:Float):Void
	{
		m_body.setPosition(a_x - BODY_WIDTH2, 50);
		m_head.setPosition(a_x, 50);
	}

	public var gotox(get_gotox, set_gotox):Float;
	private function get_gotox():Float
	{
		return m_gotox;
	}

	public function set_gotox(a_gotox:Float):Float
	{
		m_gotox = a_gotox;
		var diff:Float = m_gotox - BODY_WIDTH2 - m_body.x;
		if (diff > 0)
			m_move = 1;
		if (diff < 0)
			m_move = -1;
		return m_gotox;
	}

	
	
	override public function update():Void
	{
		super.update();
		if (m_move == 0)
			return;
			
		var _gotoIdle:Bool = false;
		var diff:Float = m_gotox -BODY_WIDTH2 - m_body.x;

		if ( diff>GOTO_TOLERANCE )
		{
			if (m_move == 1)
			{
				m_body.velocity = m_rightspeed;
				m_body.facing = FlxObject.RIGHT;
				m_head.facing = FlxObject.RIGHT;
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
				m_head.facing = FlxObject.LEFT;
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
			m_body.setPosition(m_gotox - BODY_WIDTH2, m_body.y);
			m_body.velocity = m_idlespeed;
			m_body.animation.play("idle");
		}
		
		m_head.setPosition(m_body.x + 16, m_head.y);
		
		// talking
		if (m_talking > 0)
		{
			m_talk.visible = true;
			m_talk.setPosition(m_body.x - m_talk.width * 0.5 + BODY_WIDTH2, m_body.y - 32);
			m_talking -= FlxG.elapsed;
		}
		else if (m_talking<0 && m_talking>-999)
		{
			m_talk.visible = false;
			m_talking = -999;
			m_head.animation.play("idle");
		}
	}

	
}