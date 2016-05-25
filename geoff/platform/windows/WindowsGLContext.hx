package geoff.platform.windows;
import geoff.gl.GLBuffer;
import geoff.platform.interfaces.IGLContext;
import geoff.platform.windows.externs.GL;

/**
 * ...
 * @author Simon
 */

class WindowsGLContext implements IGLContext
{

	public var COLOR_BUFFER_BIT : Int 	= 0x00004000;
	public var DEPTH_BUFFER_BIT : Int 	= 0x00000100;
	public var STENCIL_BUFFER_BIT : Int = 0x00000400;
	
	public function new() 
	{
		
	}
	
	public function clear(mask:Int) : Void
	{
		GL.clear( mask );
	}
	
	public function clearColor(r:Float, g:Float, b:Float, a:Float) : Void
	{
		GL.clearColor( r, g, b, a );
	}
	
	public function createBuffer() : GLBuffer
	{
		return new GLBuffer( 0 );
	}
	
}