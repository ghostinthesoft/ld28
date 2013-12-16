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

	public static inline var TITLE:Int = 5;
	public static inline var INTRO_1:Int = 6;
	public static inline var INTRO_2:Int = 7;

	public static inline var INTRO1_1:Int = 8;
	public static inline var INTRO1_2:Int = 9;
	public static inline var INTRO1_3:Int = 10;
	public static inline var INTRO1_4:Int = 11;
	public static inline var INTRO1_5:Int = 12;
	
	
	public static inline var CREDITS1:Int = 16;
	public static inline var CREDITS2:Int = 17;
	public static inline var CREDITS3:Int = 18;
	public static inline var GAME_OVER:Int = 19;
	public static inline var CONGRATULATIONS:Int = 20;

	public static inline var LOOSE_MISSED:Int = 21;
	public static inline var LOOSE_PARADE:Int = 22;
	public static inline var WIN1:Int = 23;

	public static inline var FINAL_WIN1:Int = 24;
	public static inline var FINAL_LOOSE1:Int = 25;
	

	// Stage1
	public static inline var STAGE1_HOSTILE_WALK_TEXT1:Int = 32;
	public static inline var STAGE1_HOSTILE_WALK_TEXT2:Int = 33;
	public static inline var STAGE1_HOSTILE_WALK_TEXT3:Int = 34;

	public static inline var STAGE1_HOSTILE_HOLD_TEXT1:Int = 35;
	public static inline var STAGE1_HOSTILE_HOLD_TEXT2:Int = 36;

	
	static private var m_lang:Int = 0;

	private var m_french:FlxButton;
	private var m_english:FlxButton;
	
	static inline public function getString(a_id:Int):String
	{
		switch(a_id)
		{
			case TITLE:
				return (m_lang == 0)?"c'était le jour du":"It was the day of the";
			case INTRO_1:
				return (m_lang == 0)?"Ce fut une journée très spéciale":"It was a very special day";
			case INTRO_2:
				return (m_lang == 0)?"Je m'en rappellerai toute ma vie":"I will remember it all my life";
			case INTRO1_1:
				return (m_lang == 0)?"Ca s'est passé à la cantine, à l'heure du déjeuner":"It happens at the canteen, at lunch time";
			case INTRO1_2:
				return (m_lang == 0)?"Bob voulait une tarte au citron mais il n'y en avait plus":"Bob wanted a lemon pie but there were no more";
			case INTRO1_3:
				return (m_lang == 0)?"Il était bouleversé et se saisit d'une fourchette":"He was upset and grab a fork";
			case INTRO1_4:
				return (m_lang == 0)?"Je devais intervenir, j'ai regardé autour de moi":"I had to do something, I look around me";
			case INTRO1_5:
				return (m_lang == 0)?"Je n'avais qu'un yaourt pour l'arrêter !":"I only got one Yogourt to stop him !";
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
				return (m_lang == 0)?"Créé et développé par Alain Bellenger":"Created and Developped by Alain Bellenger";
			case CREDITS2:
				return (m_lang == 0)?"lors de la Ludum Dare #28":"during Ludum Dare #28";
			case CREDITS3:
				return (m_lang == 0)?"\"You Only Get One\"":"\"You Only Get One\"";
			case GAME_OVER:
				return (m_lang == 0)?"Game Over":"Game Over";
			case CONGRATULATIONS:
				return (m_lang == 0)?"Félicitations !":"Congratulations !";
			case LOOSE_MISSED:
				return (m_lang == 0)?"Vous ne l'avez pas touché":"You didn't touch him";
			case LOOSE_PARADE:
				return (m_lang == 0)?"Vous auriez dû choisir un moment plus propice":"You didn't choose the right time";
			case WIN1:
				return (m_lang == 0)?"Bravo, vous avez réussi à l'arrêter !":"Well done, you managed to stop him !";
			case FINAL_WIN1:
				return (m_lang == 0)?"Ouch ! C'est bon, je me rends !":"Ouch ! Well, you win";
			case FINAL_LOOSE1:
				return (m_lang == 0)?"Raté ! Mais moi je ne vais pas te rater":"Missed ! But I won't miss you !";
			case STAGE1_HOSTILE_WALK_TEXT1:
				return (m_lang == 0)?"Je veux ma tarte au citron !":"I want my lemon pie !";
			case STAGE1_HOSTILE_WALK_TEXT2:
				return (m_lang == 0)?"Qui a mangé toutes les tartes ?":"Who ate all the pies ?";
			case STAGE1_HOSTILE_WALK_TEXT3:
				return (m_lang == 0)?"Qu'on me donne une tarte au citron tout de suite !":"Somebody give a lemon pie, quick !";
			case STAGE1_HOSTILE_HOLD_TEXT1:
				return (m_lang == 0)?"Je veux ma tarte au citron ou je lui donne un coup de fourchette !":"I want my lemon pie or I use my fork on him";
			case STAGE1_HOSTILE_HOLD_TEXT2:
				return (m_lang == 0)?"Attention je ne plaisante pas !":"Be careful, I am not kidding";
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
		m_english.setOnUpCallback(_onEnglish);
		m_french = new Button(2 * FlxG.width / 3, FlxG.height / 2 - 26, 2);
		m_french.setOnUpCallback(_onFrench);
		
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