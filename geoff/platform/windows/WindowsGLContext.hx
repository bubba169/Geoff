package geoff.platform.windows;
import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author Simon
 */

class WindowsGLContext implements IGLContext
{

	public var COLOR_BUFFER_BIT : Int;
	public var DEPTH_BUFFER_BIT : Int;
	public var STENCIL_BUFFER_BIT : Int;
	
	public function new() 
	{
		
	}
	
	public function clear(mask:Int):Void 
	{
		//GL.clear( mask );
	}
	
	public function clearColor(r:Float, g:Float, b:Float, a:Float):Void 
	{
		//GL.clearColor( r, g, b, a );
	}
	
}