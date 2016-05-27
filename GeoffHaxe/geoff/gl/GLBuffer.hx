package geoff.gl;
import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author ...
 */

@:enum abstract GLBufferUsage(Int) from Int to Int
{
	var StreamDraw : Int = 0x88E0;
	var DynamicDraw : Int = 0x88E8;
	var StaticDraw : Int = 0x88E4;
}

@:enum abstract GLBufferTarget(Int) from Int to Int
{
	var ArrayBuffer : Int = 0x8892;
	var ElementArrayBuffer : Int = 0x8893;
	var TextureBuffer : Int = 0;
}
 
class GLBuffer extends GLObject
{

	public function new( value : UInt, context : IGLContext ) 
	{
		super( value, "Buffer", context );
	}
	
}