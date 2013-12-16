package ;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import flixel.FlxG;
import flixel.ui.FlxButton;

/**
 * Generic Button
 * 
 * @author Al1
 */
class Button extends FlxButton
{
	public function new(a_x:Float, a_y:Float, a_type:Int, ?a_label:String) 
	{
		var _offset:Float = 0;
		if (a_type==0)
			_offset = 40;
		else if (a_type==1 || a_type==2)
			_offset = 50;
		else 
			_offset = 8;

		super(a_x-_offset, a_y, a_label);
		
		var _offset:Float = 0;
		if (a_type == 1)
			loadGraphic("assets/b_english.png");
		else if (a_type == 2)
			loadGraphic("assets/b_french.png");
		else if (a_type == 3)
			loadGraphic("assets/b_sound.png", true, false, 16, 16);
		else
			loadGraphic("assets/b_button.png", true, false, 80, 20);
		
		setOnOverCallback(_onOverCallback);
		setOnOutCallback(_onOutCallback);
		setOnDownCallback(_onDownCallback);
		
		if (a_type == 3)
			setOnUpCallback(_onSoundCallback);
	}
	
	private function _onSoundCallback():Void
	{
		FlxG.sound.muted = !FlxG.sound.muted;
	}
	
	private function _onDownCallback():Void
	{
		Game.play("assets/s_click.mp3");
	}
	
	private function _onOverCallback():Void
	{
		Mouse.cursor = MouseCursor.BUTTON; 
	}
	
	private function _onOutCallback():Void
	{
		Mouse.cursor = MouseCursor.AUTO; 
	}
}