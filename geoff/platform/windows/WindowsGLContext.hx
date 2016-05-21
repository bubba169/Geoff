package geoff.platform.windows;
import geoff.platform.interfaces.IGLContext;
import geoff.utils.GL;

/**
 * ...
 * @author Simon
 */

 @:include("GL/gl.h")
 
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
		GL.glClear( mask );
	}
	
	public function clearColor(r:Float, g:Float, b:Float, a:Float):Void 
	{
		GL.glClearColor( r, g, b, a );
	}
	
}