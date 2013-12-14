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
class FadeState extends FlxState
{
	public var m_enable:Bool = false;
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		// Set a background color
		FlxG.cameras.bgColor = 0xff000000;
		// Show the mouse (in case it hasn't been disabled)
		#if !FLX_NO_MOUSE
		FlxG.mouse.show();
		#end

		//FlxG.camera.fade(Game.FADE_COLOR, Game.FADE_DURATION, true, _enableState);
		super.create();
	}

	private function _enableState():Void
	{
		m_enable = true;
	}
	
	private function _leaveState(a_fadein:Bool, ?a_handler:Void->Void):Void
	{
		m_enable = false;
		FlxG.camera.fade(Game.FADE_COLOR, Game.FADE_DURATION, a_fadein, a_handler);
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
		if (!m_enable)
			return;
	}
}