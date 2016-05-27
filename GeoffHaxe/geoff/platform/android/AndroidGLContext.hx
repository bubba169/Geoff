package geoff.platform.android;

import android.opengl.GLES20;
import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author Simon
 */
class AndroidGLContext implements IGLContext
{
	public var COLOR_BUFFER_BIT = GLES20.GL_COLOR_BUFFER_BIT;
	public var DEPTH_BUFFER_BIT = GLES20.GL_DEPTH_BUFFER_BIT;
	public var STENCIL_BUFFER_BIT = GLES20.GL_STENCIL_BUFFER_BIT;
	
	public function new() 
	{
		
	}
	
	
	public function clear( mask : Int ) : Void 
	{
		GLES20.glClear( mask );
	}
	
	public function clearColor( r : Float, g : Float, b : Float, a : Float ) : Void
	{
		GLES20.glClearColor( r, g, b, a );
	}
	
}