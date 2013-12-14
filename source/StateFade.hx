package ;

import flash.ui.Mouse;
import flash.ui.MouseCursor;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class StateFade extends FlxState
{
	public static inline var COLOR_BLACK:Int = 0xFF000000;
	public static inline var FADE_DURATION:Float = 0.5;
	
	public var m_enable:Bool = false;
	public var m_bgColor:Int = COLOR_BLACK;
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		// curseur normal
		Mouse.cursor = MouseCursor.AUTO; 
		
		// Set a background color
		FlxG.cameras.bgColor = m_bgColor;
			
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end

		FlxG.camera.fade(m_bgColor, FADE_DURATION, true, _enableState);
		super.create();
	}

	private function _enableState():Void
	{
		m_enable = true;
	}
	
	private function _leaveState(?a_handler:Void->Void):Void
	{
		m_enable = false;
		FlxG.camera.fade(m_bgColor, FADE_DURATION, false, a_handler);
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
	}
}