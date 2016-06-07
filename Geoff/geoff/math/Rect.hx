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
	
	public var left( get, never ) : Float;
	public var right( get, never ) : Float;
	public var top( get, never ) : Float;
	public var bottom( get, never ) : Float;
	
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
	
	public function setTo( x : Float, y : Float, width : Float, height : Float ) 
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}
	
	private function get_left() : Float { return x; }
	private function get_right() : Float { return x + width; }
	private function get_top() : Float { return y; }
	private function get_bottom() : Float { return y + height; }
	
}