package geoff.math;

/**
 * ...
 * @author ...
 */
class Vec4
{

	public var x : Float;
	public var y : Float;
	public var z : Float;
	public var w : Float;
	
	public function new( x : Float = 0, y : Float = 0, z : Float = 0, w : Float = 0 ) 
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}
	
	public function toString( ) : String
	{
		return "($x,$y,$z,$w)";
	}
	
}