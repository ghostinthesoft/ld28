package ;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import flixel.FlxG;
import flixel.ui.FlxButton;

/**
 * Generic Button
 * 
 * @author 
 */
class Button extends FlxButton
{

	public function new(a_x:Float, a_y:Float, ?a_label:String) 
	{
		super(a_x, a_y, a_label);
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