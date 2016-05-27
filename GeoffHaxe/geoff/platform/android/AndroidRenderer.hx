package geoff.platform.android;

import android.opengl.GLES20;
import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author Simon
 */
class AndroidRenderer implements IGLContext
{
	
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