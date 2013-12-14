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
 * @author 
 */
class Lang extends StateFade
{
	public static inline var INTRO:Int = 0;
	public static inline var MENU_START:Int = 1;
	public static inline var MENU_CREDITS:Int = 2;
	public static inline var CREDITS:Int = 3;

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
			case INTRO:
				return (m_lang == 0)?"Ce fut une journée très spéciale\nJe m'en rappellerai toute ma vie\n":"";
			case MENU_START:
				return (m_lang == 0)?"Commencer":"Start";
			case MENU_CREDITS:
				return (m_lang == 0)?"Crédits":"Credits";
			case CREDITS:
				return (m_lang == 0)?"Créé et développé par Alain Bellenger\n\nlors de la Ludum Dare #28\n\n\"You Only Get One\"":"";
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
		
		m_english = new Button(1 * FlxG.width / 3 - 50, FlxG.height / 2 - 26);
		m_english.loadGraphic("assets/b_english.png");
		m_english.setOnDownCallback(_onEnglish);
		m_french = new Button(2 * FlxG.width / 3 - 50, FlxG.height / 2 - 26);
		m_french.loadGraphic("assets/b_french.png");
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