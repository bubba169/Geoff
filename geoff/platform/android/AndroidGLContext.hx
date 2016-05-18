package geoff.platform.android;

import android.opengl.GLES20;
import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author Simon
 */
class AndroidGLContext implements IGLContext
{

	public function new() 
	{
		
	}
	
	public function color( r : Float, g : Float, b : Float, a : Float ) : Void
	{
		GLES20.glClearColor( r, g, b, a );
	}
	
}