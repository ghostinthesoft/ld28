package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxCollision;
import flixel.util.FlxPoint;

/**
 * Character behavior
 * 
 * @author Al1
 */
class Character extends FlxTypedGroup<FlxSprite>
{
	public static inline var CHARACTER_WIDTH:Int = 64;
	public static inline var CHARACTER_WIDTH2:Int = CHARACTER_WIDTH>>1;

	
	public static inline var STAGE1_HOSTILE:Int = 0;
	public static inline var STAGE1_FRIENDLY:Int = 32;
	
	private static inline var GOTO_TOLERANCE:Float = 2;
	private static inline var GOTO_SPEED:Float = 100;
	private static inline var COME_SPEED:Float = 50;

	private static inline var BODY_WIDTH:Int = 64;
	private static inline var BODY_WIDTH2:Int = BODY_WIDTH>>1;

	
	private var m_movex:Int;
	private var m_gotox:Float;
	private var m_comey:Float;
	private var m_liney:Float;
	
	private var _x:Int = 0;
	private var _y:Int = 0;
	
	private var m_type:Int;
	private var m_talking:Float;
	
	
	private var m_talk:FlxText;
	private var m_head:FlxSprite;
	private var m_body:FlxSprite;
	
	public function new(a_type:Int, a_liney:Float=50) 
	{
		super();
		m_type = a_type;
		m_liney = a_liney;

		targetable = false;
		
		m_movex = 0;
		m_gotox = 0;
		m_comey = 0;
		
		m_body = new FlxSprite();
		m_body.loadGraphic("assets/b_man1.png", true, true, BODY_WIDTH, 128);
		m_body.animation.add("idle", [0], 12, false);
		m_body.animation.add("walk", [0, 1, 2, 3, 4, 5], 12, true);
		m_body.animation.add("come", [1, 3], 12);
		m_body.velocity = new FlxPoint(0, 0);
		add(m_body);
		
		m_head = new FlxSprite();
		m_head.loadGraphic("assets/b_head1.png", true, true, 32, 32);
		m_head.animation.add("idle", [0], 12, false);
		m_head.animation.add("talk", [1, 2], 6, true);
		add(m_head);
		
		m_talk = new FlxText(0, 0, FlxG.width >> 1);
		m_talk.setFormat(Game.FONT_TALK, 8, 0xFFFFFFFF, "center");
		m_talk.visible = false;
		add(m_talk);
		
		m_body.setPosition(-999, m_liney);
		m_head.setPosition(-999, -999);
		
		m_talking = -999;
	}
	
	public var targetable(default, default):Bool;

	public var movex(get_movex, set_movex):Int;
	private function get_movex():Int
	{
		return m_movex;
	}

	private function set_movex(a_movex:Int):Int
	{
		return m_movex = a_movex;
	}

	public function setx(a_x:Float):Void
	{
		m_body.setPosition(a_x - BODY_WIDTH2, m_liney);
		m_head.setPosition(a_x, m_liney);
	}

	public var gotox(get_gotox, set_gotox):Float;
	private function get_gotox():Float
	{
		return m_gotox;
	}

	// say if it's the man or the person
	public var isTalking(get_isTalking, null):Bool;
	private function get_isTalking():Bool
	{
		return m_talking>0;
	}
	
	
	// set destination
	public function set_gotox(a_gotox:Float):Float
	{
		//a_gotox = FlxG.width / 2;
		m_gotox = a_gotox;
		var diff:Float = m_gotox - BODY_WIDTH2 - m_body.x;
		if (diff > 0)
			m_movex = 1;
		if (diff < 0)
			m_movex = -1;
		return m_gotox;
	}

	// for coming
	public function come(a_gotox:Float):Void
	{
		m_gotox = a_gotox;
		m_comey = COME_SPEED;
	}

	// say a sentence
	public function talk(a_text:Int):Void
	{
		var _string:String = Lang.getString(a_text);
		m_talking = _string.length * 0.15;
		if (m_talking < 1)
			m_talking = 1;
		m_talk.text = _string;
		m_head.animation.play("talk");
	}

	// check collision
	public function checkCollision(a_object:FlxSprite):Bool
	{
		if (FlxCollision.pixelPerfectCheck(m_body, a_object))
			return true;
			
		if (FlxCollision.pixelPerfectCheck(m_head, a_object))
			return true;
			
		return false;
	}
	
	
	
	override public function update():Void
	{
		super.update();

		// horizontal move ?
		var diffx:Float = m_gotox - BODY_WIDTH2 - m_body.x;
		if ( diffx>GOTO_TOLERANCE )
		{
			if (m_movex == 1)
			{
				m_body.velocity.x = GOTO_SPEED;
				m_body.facing = FlxObject.RIGHT;
				m_head.facing = FlxObject.RIGHT;
			}
			else
			{
				m_movex = 0;
				m_body.velocity.x = 0;
			}
		}
		else if ( diffx<-GOTO_TOLERANCE )
		{
			if (m_movex == -1)
			{
				m_body.velocity.x = -GOTO_SPEED;
				m_body.facing = FlxObject.LEFT;
				m_head.facing = FlxObject.LEFT;
			}
			else
			{
				m_movex = 0;
				m_body.velocity.x = 0;
			}
		}

		// update body animation according to velocity
		if (m_comey > 0)
		{
			m_body.velocity.y = COME_SPEED;
			m_body.animation.play("come");
		}
		else
		{
			if (m_body.velocity.x == 0)
				m_body.animation.play("idle");
			else
				m_body.animation.play("walk");
		}

		// if no x velocity go to dest x position
		/*if (m_body.velocity.x == 0)
			m_body.setPosition(m_gotox - BODY_WIDTH2, m_body.y);*/

		// set head position
		m_head.setPosition(m_body.x + 16, m_body.y);
		
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