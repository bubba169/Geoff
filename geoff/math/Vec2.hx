package geoff.math;

/**
 * ...
 * @author ...
 */
class Vec2
{

	public var x : Float;
	public var y : Float;
	
	public function new( x : Float = 0, y : Float = 0 ) 
	{
		this.x = x;
		this.y = y;
	}
	
	public function toString( ) : String
	{
		return "($x,$y)";
	}
	
}