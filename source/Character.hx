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

	public static inline var SPEED_DEFAULT:Float = 100;
	public static inline var SPEED_RUN1:Float = 130;
	
	public static inline var STAGE1_HOSTILE:Int = 0;
	public static inline var STAGE1_FRIENDLY:Int = 32;

	// private
	private static inline var GOTO_TOLERANCE:Float = 2;
	private static inline var COME_SPEED:Float = 50;

	private static inline var BODY_WIDTH:Int = 64;
	private static inline var BODY_WIDTH2:Int = BODY_WIDTH>>1;
	private static inline var BODY_HEIGHT:Int = 96;
	private static inline var BODY_HEIGHT2:Int = BODY_HEIGHT>>1;

	private static inline var HEAD_WIDTH:Int = 32;
	private static inline var HEAD_HEIGHT:Int = 96;
	private static inline var HEAD_WIDTH2:Int = HEAD_WIDTH>>1;
	private static inline var HEAD_OFFSETY:Int = -20;

	private static inline var HEAD_PARADE_OFFSETX:Int = 8;
	private static inline var HEAD_PARADE_OFFSETY:Int = 30;

	private static inline var ARMS_WIDTH:Int = 64;
	private static inline var ARMS_WIDTH2:Int = ARMS_WIDTH >> 1;
	private static inline var ARMS_HEIGHT:Int = 96;
	
	private static inline var ARMS_OFFSETY_FRIENDLY:Int = 0;
	private static inline var ARMS_OFFSETY_HOSTILE:Int = 0;

	private static inline var TEXT_OFFSETY:Int = -64;
	
	private static inline var FOLLOWING_OFFSET:Int = 10;
	
	private var m_movex:Int;
	private var m_gotox:Float;
	private var m_comey:Float;
	private var m_liney:Float;
	
	private var _x:Int = 0;
	private var _y:Int = 0;
	
	private var m_type:Int;
	private var m_talking:Float;
	private var m_front:Bool;

	
	private var m_talk:FlxText;
	private var m_head:FlxSprite;
	private var m_body:FlxSprite;
	private var m_arms:FlxSprite;

	private var m_body_anim:String;
	private var m_head_anim:String;

	
	
	public function new(a_type:Int, a_liney:Float=90) 
	{
		super();
		m_type = a_type;
		m_liney = a_liney;

		targetable = false;
		
		m_movex = 0;
		m_gotox = 0;
		m_comey = 0;
		
		speed = SPEED_DEFAULT;
		
		m_front = true;
		
		m_body = new FlxSprite();
		if (isHostile)
			m_body.loadGraphic("assets/b_hostile_body.png", true, true, BODY_WIDTH, BODY_HEIGHT);
		else
			m_body.loadGraphic("assets/b_friendly_body.png", true, true, BODY_WIDTH, BODY_HEIGHT);
			
		m_body.animation.add("walk", [0, 1, 2, 3, 4, 5], 12, true);
		m_body.animation.add("walk_wearing", [6, 7, 8, 9, 10, 11], 12, true);
		m_body.animation.add("idle", [12], 12, false);
		m_body.animation.add("idle_wearing", [13], 12, true);
		if (isHostile)
		{
			m_body.animation.add("come", [14, 15], 12);
			m_body.animation.add("come_wearing", [16, 17], 12, true);
			m_body.animation.add("holding", [18, 19], 12);
			m_body.animation.add("parade", [20], 12, true);
		}
		else
		{
			m_body.animation.add("following", [14, 15], 12);
		}
		m_body.velocity = new FlxPoint(0, 0);
		add(m_body);
		
		m_head = new FlxSprite();
		if (isHostile)
			m_head.loadGraphic("assets/b_hostile_head.png", true, true, HEAD_WIDTH, HEAD_WIDTH);
		else
			m_head.loadGraphic("assets/b_friendly_head.png", true, true, HEAD_WIDTH, HEAD_WIDTH);

		m_head.animation.add("front", [0], 12, false);
		m_head.animation.add("front_talk", [1, 2], 6, true);
		m_head.animation.add("side", [3], 12, false);
		m_head.animation.add("side_talk", [4, 5], 6, true);
		add(m_head);
		
		// load arms for holding or parade
		m_arms = new FlxSprite();
		if (isHostile)
			m_arms.loadGraphic("assets/b_hostile_arms.png", true, true, ARMS_WIDTH, ARMS_HEIGHT);
		else
			m_arms.loadGraphic("assets/b_friendly_arms.png", true, true, ARMS_WIDTH, ARMS_HEIGHT);
		m_arms.visible = false;
		add(m_arms);
		
		m_talk = new FlxText(0, 0, FlxG.width >> 1);
		var _talkColor:Int = 0xFF000000;
		m_talk.setFormat(Game.FONT_TALK, 8, _talkColor, "center");
		m_talk.visible = false;
		add(m_talk);
		
		
		posx = -999;
		m_talking = -999;
	}
	
	// is the character targetable ?
	public var targetable(default, default):Bool;
	
	// hold another character
	public var holding(default, default):Character;

	// no move, just following another char
	public var following(default, default):Character;

	// wearing an object
	public var wearing(default, default):Bool;

	// wearing an object
	public var speed(default, default):Float;

	public var movex(get_movex, set_movex):Int;
	private function get_movex():Int
	{
		return m_movex;
	}

	private function set_movex(a_movex:Int):Int
	{
		return m_movex = a_movex;
	}


	public var isHostile(get_isHostile, null):Bool;
	private function get_isHostile():Bool
	{
		return m_type<32;
	}

	// say if it's the man or the person
	public var arms(get_arms, set_arms):Bool;
	private function get_arms():Bool
	{
		return m_arms!=null && m_arms.visible;
	}
	
	private function set_arms(a_arms:Bool):Bool
	{
		if (m_arms!=null && m_arms.visible!=a_arms)
			m_arms.visible = a_arms;
		return a_arms;
	}

	// arm rotation
	public var armsangle(null, set_armsangle):Float;
	private function set_armsangle(a_armsangle:Float):Float
	{
		if (m_arms!=null && m_arms.visible)
			m_arms.angle = a_armsangle;
		return a_armsangle;
	}
	

	// say if it's the man or the person
	public var isTalking(get_isTalking, null):Bool;
	private function get_isTalking():Bool
	{
		return m_talking>0;
	}
	
	public var posx(get_posx, set_posx):Float;
	private function set_posx(a_x:Float):Float
	{
		m_body.setPosition(a_x - BODY_WIDTH2, m_liney);
		m_head.setPosition(a_x - HEAD_WIDTH2, m_liney+HEAD_OFFSETY);
		if (m_arms != null)
		{
			if (isHostile)
				m_arms.setPosition(a_x - ARMS_WIDTH2, m_liney + ARMS_OFFSETY_HOSTILE);
			else
				m_arms.setPosition(a_x - ARMS_WIDTH2, m_liney + ARMS_OFFSETY_FRIENDLY);
		}
		return a_x;
	}
	private function get_posx():Float
	{
		return m_body.x + BODY_WIDTH2;
	}
	
	public var posy(get_posy, null):Float;
	private function get_posy():Float
	{
		return m_body.y + BODY_HEIGHT2;
	}

	
	public var gotox(get_gotox, set_gotox):Float;
	private function get_gotox():Float
	{
		return m_gotox;
	}
	
	// set destination
	public function set_gotox(a_gotox:Float):Float
	{
		//a_gotox = FlxG.width / 2;
		if (m_gotox == a_gotox)
			return m_gotox;
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
		gotox = a_gotox;
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

		// check if orientation change
		var _parade:Bool = (isHostile && arms);
		var _front:Bool = holding != null || following != null || (m_body.velocity.x == 0 && m_body.velocity.y == 0) || m_comey>0;
		if (_parade)
			_front = false;
		m_front = _front;
		
		// horizontal move only if not following
		if (following == null)
		{
			var diffx:Float = m_gotox - BODY_WIDTH2 - m_body.x;
			if ( diffx>GOTO_TOLERANCE )
			{
				if (m_movex == 1)
				{
					m_body.velocity.x = speed;
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
					m_body.velocity.x = -speed;
					m_body.facing = FlxObject.LEFT;
					m_head.facing = FlxObject.LEFT;
				}
				else
				{
					m_movex = 0;
					m_body.velocity.x = 0;
				}
			}
		}

		var _body_anim:String = m_body_anim;
		var _head_anim:String = m_head_anim;
		
		// if following set following body animations
		if (following != null)
			_body_anim = "following";
		// if holding set holding body animations
		else if (holding != null)
			_body_anim = "holding";
		// else update body animation according to velocity
		else if (m_comey > 0)
		{
			m_body.velocity.y = COME_SPEED;
			_body_anim = "come";
			if (wearing)
				_body_anim += "_wearing";
		}
		else
		{
			if (m_body.velocity.x == 0)
				_body_anim = "idle";
			else
				_body_anim = "walk";
			if (wearing)
				_body_anim += "_wearing";
		}
		
		// hostile+arm = parade
		if (_parade)
		{
			m_movex = 0;
			m_body.facing = FlxObject.RIGHT;
			m_head.facing = FlxObject.RIGHT;
			_body_anim = "parade";
		}
		
		// update positions if not following
		var _posx:Float = m_body.x + BODY_WIDTH2;
		if (following == null)
		{
			// set head position
			var _headOffsetX:Float = _posx - HEAD_WIDTH2;
			var _headOffsetY:Float = m_body.y + HEAD_OFFSETY;
			if (_parade) 
			{
				_headOffsetX += HEAD_PARADE_OFFSETX;
				_headOffsetY += HEAD_PARADE_OFFSETY;
			}
			m_head.setPosition(_headOffsetX, _headOffsetY);
			
			// and arms eventually
			if (m_arms != null)
			{
				if (isHostile)
					m_arms.setPosition(_posx - ARMS_WIDTH2, m_liney + ARMS_OFFSETY_HOSTILE);
				else
					m_arms.setPosition(_posx - ARMS_WIDTH2, m_liney + ARMS_OFFSETY_FRIENDLY);
			}
		}
		
		if (holding != null)
		{
			// set following position
			holding.posx = _posx+FOLLOWING_OFFSET;
		}
		
		
		// head animation
		if (m_talking > 0)
		{
			m_talk.visible = true;
			m_talk.setPosition(_posx - m_talk.width * 0.5, m_body.y +TEXT_OFFSETY);
			m_talking -= FlxG.elapsed;
			if (m_front)
				_head_anim = "front_talk";
			else
				_head_anim = "side_talk";
			
			Game.talk();
		}
		else 
		{
			// step sound
			/*if (isHostile && m_body.velocity.x != 0)
			{
				Game.play("assets/s_step.mp3");
			}*/
			
			if (m_talking<0 && m_talking>-999)
			{
				m_talk.visible = false;
				m_talking = -999;
			}
			if (m_front)
				_head_anim = "front";
			else
				_head_anim = "side";
				
		}
		
		// update body anim if needed
		if (_body_anim != m_body_anim)
		{
			m_body_anim = _body_anim;
			m_body.animation.play(m_body_anim);
		}
		
		// update head anim if needed
		if (_head_anim != m_head_anim)
		{
			m_head_anim = _head_anim;
			m_head.animation.play(m_head_anim);
		}

			
	}

	
}