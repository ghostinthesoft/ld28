package ;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

/**
 * Language selection
 * 
 * @author Al1
 */
class Lang extends StateFade
{
	public static inline var MENU_START:Int = 0;
	public static inline var MENU_CREDITS:Int = 1;
	public static inline var MENU_REPLAY:Int = 2;
	public static inline var MENU_TITLE:Int = 3;
	public static inline var MENU_CONTINUE:Int = 4;

	public static inline var INTRO1:Int = 5;
	public static inline var INTRO2:Int = 6;
	public static inline var INTRO3:Int = 7;
	
	public static inline var CREDITS1:Int = 16;
	public static inline var CREDITS2:Int = 17;
	public static inline var CREDITS3:Int = 18;
	public static inline var GAME_OVER:Int = 19;
	public static inline var LOOSE_MISSED:Int = 20;
	public static inline var LOOSE_PARADE:Int = 21;
	public static inline var WIN1:Int = 22;


	// Stage1
	public static inline var STAGE1_HOSTILE_WALK_TEXT1:Int = 32;
	public static inline var STAGE1_HOSTILE_WALK_TEXT2:Int = 33;
	public static inline var STAGE1_HOSTILE_WALK_TEXT3:Int = 34;
	
	static private var m_lang:Int = 0;

	private var m_french:FlxButton;
	private var m_english:FlxButton;
	
	static inline public function getString(a_id:Int):String
	{
		switch(a_id)
		{
			case INTRO1:
				return (m_lang == 0)?"c'était le jour du":"";
			case INTRO2:
				return (m_lang == 0)?"Ce fut une journée très spéciale":"";
			case INTRO3:
				return (m_lang == 0)?"Je m'en rappellerai toute ma vie":"";
			case MENU_START:
				return (m_lang == 0)?"Commencer":"Start";
			case MENU_CREDITS:
				return (m_lang == 0)?"Crédits":"Credits";
			case MENU_REPLAY:
				return (m_lang == 0)?"Rejouer":"Replay";
			case MENU_TITLE:
				return (m_lang == 0)?"Ecran titre":"Title screen";
			case MENU_CONTINUE:
				return (m_lang == 0)?"Continuer":"Continue";
			case CREDITS1:
				return (m_lang == 0)?"Créé et développé par Alain Bellenger":"";
			case CREDITS2:
				return (m_lang == 0)?"lors de la Ludum Dare #28":"";
			case CREDITS3:
				return (m_lang == 0)?"\"You Only Get One\"":"";
			case GAME_OVER:
				return (m_lang == 0)?"Game Over":"Game Over";
			case LOOSE_MISSED:
				return (m_lang == 0)?"Le yaourt n'a pas touché le forcené":"";
			case LOOSE_PARADE:
				return (m_lang == 0)?"Vous auriez dû attendre un moment plus propice":"";
			case WIN1:
				return (m_lang == 0)?"Bravo, vous avez maitrisé le forcené":"";
			case STAGE1_HOSTILE_WALK_TEXT1:
				return (m_lang == 0)?"Je veux ma tarte au citron !":"I want my lemon pie !";
			case STAGE1_HOSTILE_WALK_TEXT2:
				return (m_lang == 0)?"Pourquoi il n'y a pas de tarte au citron !":"";
			case STAGE1_HOSTILE_WALK_TEXT3:
				return (m_lang == 0)?"Qu'on me donne une tarte au citron tout de suite !":"";
			default:
				return "";
		}
	}
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		m_bgColor = 0xFFFFFFFF;
		super.create();
		
		//FlxG.debugger.visible = true;
		
		m_english = new Button(1 * FlxG.width / 3, FlxG.height / 2 - 26, 1);
		m_english.setOnDownCallback(_onEnglish);
		m_french = new Button(2 * FlxG.width / 3, FlxG.height / 2 - 26, 2);
		m_french.setOnDownCallback(_onFrench);
		
		add(m_english);
		add(m_french);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	private function _onFrench():Void
	{
		_leaveState(_goTitle);
	}

	private function _onEnglish():Void
	{
		m_lang = 1;
		_leaveState(_goTitle);
	}
	
	private function _goTitle():Void
	{
		FlxG.switchState(new StateIntro());
	}
}