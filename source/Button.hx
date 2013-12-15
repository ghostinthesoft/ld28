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
		super(a_x, a_y, a_label);
		
		var _offset:Float = 0;
		if (a_type == 1)
		{
			_offset = 50;
			loadGraphic("assets/b_english.png");
		}
		else if (a_type == 2)
		{
			_offset = 50;
			loadGraphic("assets/b_french.png");
		}
		else
		{
			_offset = 40;
			loadGraphic("assets/b_button.png", true, false, 80, 20);
		}
		x = x - _offset;
		
		setOnOverCallback(_onOverCallback);
		setOnOutCallback(_onOutCallback);
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