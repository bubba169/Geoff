package geoff.gl;
import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author ...
 */
class GLObject
{

	public var value : Dynamic;
	public var type : String = "GLObject";
	public var context : IGLContext;
	
	public function new( value : Dynamic, type : String, context : IGLContext ) 
	{
		this.value = value;
		this.type = type;
	}
	
	public function toString() : String 
	{
		return "[" + type + " " + value + "]";
	}
	
}