package geoff.math;

/**
 * ...
 * @author Simon
 */
class Rect
{

	public var x : Float;
	public var y : Float;
	public var width : Float;
	public var height : Float;
	
	public function new( x : Float = 0, y : Float = 0, width : Float = 0, height : Float = 0 )
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}
	
	public function setEmpty() 
	{
		this.x = 0;
		this.y = 0;
		this.width = 0;
		this.height = 0;
	}
	
}