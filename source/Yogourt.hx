package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxPoint;

/**
 * Yougourt Sprite
 * 
 * @author Al1
 */
class Yogourt extends FlxSprite
{
	private static inline var SEND_DURATION:Float = 0.2;
	private static inline var TOUCH_DURATION:Float = 0.5;
	
	private var m_tween1:FlxTween;
	private var m_tween2:FlxTween;
	private var m_dest:FlxPoint;

	private var m_handler:Void->Void;

	public function new(a_handler:Void->Void) 
	{
		super(FlxG.width, 2*FlxG.height/3);
		this.loadGraphic("assets/b_yogourt.png", true, false, 32, 32, true);
		this.animation.add("launch", [0, 1, 2, 3], 6, true);
		this.animation.add("touch", [3]);
		this.animation.play("launch");
		
		m_handler = a_handler;
		
		m_dest = new FlxPoint(FlxG.mouse.screenX - 16, FlxG.mouse.screenY - 16);
		scalexy = 8;
		
		var _tween_options1:TweenOptions = { type:FlxTween.ONESHOT, ease:null };
		m_tween1 = FlxTween.multiVar(this, { scalexy: 0.5, y:m_dest.y }, SEND_DURATION, _tween_options1);		
		
		var _tween_options2:TweenOptions = { type:FlxTween.ONESHOT, complete: _complete, ease:FlxEase.quadIn };
		m_tween2 = FlxTween.multiVar(this, { x:m_dest.x }, SEND_DURATION, _tween_options2);
	}
	
	private function _complete(a_tween:FlxTween):Void
	{
		// note: the final scale should be one for good pixel collision
		// alpha doesn't care
		scalexy = 1;
		
		var _tween_options1:TweenOptions = { type:FlxTween.ONESHOT, ease:null };
		m_tween1 = FlxTween.multiVar(this, { alpha: 0 }, TOUCH_DURATION, _tween_options1);		

		this.animation.play("touch");
		m_handler();
	}
	
	public var scalexy(get_scalexy, set_scalexy):Float;
	private function set_scalexy(a_scalexy:Float):Float
	{
		scale.x = a_scalexy;
		scale.y = a_scalexy;
		return a_scalexy;
	}
	
	private function get_scalexy():Float
	{
		return scale.x;
	}
}