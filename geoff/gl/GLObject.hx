package geoff.gl;

/**
 * ...
 * @author ...
 */
class GLObject
{

	public var value : Dynamic;
	public var type : String = "GLObject";
	
	public function new( value : Dynamic, type : String ) 
	{
		this.value = value;
		this.type = type;
	}
	
	public function toString() : String 
	{
		return "[" + type + " " + value + "]";
	}
	
}