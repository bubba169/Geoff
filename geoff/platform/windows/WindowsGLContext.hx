package geoff.platform.windows;
import geoff.platform.interfaces.IGLContext;
import geoff.utils.GL;

/**
 * ...
 * @author Simon
 */

class WindowsGLContext implements IGLContext
{

	public var COLOR_BUFFER_BIT : Int = 0x00004000;
	public var DEPTH_BUFFER_BIT : Int = 0x00004000;
	public var STENCIL_BUFFER_BIT : Int = 0x00000400;
	
	public function new() 
	{
		
	}
	
	public function clear(mask:Int):Void 
	{
		GL.clear( mask );
	}
	
	public function clearColor(r:Float, g:Float, b:Float, a:Float):Void 
	{
		GL.clearColor( r, g, b, a );
	}
	
}