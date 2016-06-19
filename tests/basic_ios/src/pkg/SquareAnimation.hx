package pkg;

import uk.co.mojaworks.norman.components.animation.Animation;

/**
 * ...
 * @author Simon
 */
class SquareAnimation extends Animation
{

	public function new() 
	{
		super();
		
	}
	
	override public function update(seconds:Float):Void 
	{
		super.update(seconds);
		gameObject.transform.rotation += seconds * 0.5;
	}
	
}