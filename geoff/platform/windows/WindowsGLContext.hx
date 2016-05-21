package geoff.platform.windows;
import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author Simon
 */

 @:include("GL/gl.h")
 
class WindowsGLContext implements IGLContext
{

	public var COLOR_BUFFER_BIT : Int = untyped __global__.GL_COLOR_BUFFER_BIT;
	public var DEPTH_BUFFER_BIT : Int;
	public var STENCIL_BUFFER_BIT : Int;
	
	public function new() 
	{
		
	}
	
	public function clear(mask:Int):Void 
	{
		untyped __global__.glClear( mask );
	}
	
	public function clearColor(r:Float, g:Float, b:Float, a:Float):Void 
	{
		untyped __global__.glClearColor( r, g, b, a );
	}
	
}