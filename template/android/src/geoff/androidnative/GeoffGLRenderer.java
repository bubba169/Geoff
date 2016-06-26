package geoff.androidnative;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import android.opengl.GLES20;

import android.opengl.GLSurfaceView;
import geoff.App;
import android.util.Log;

public class GeoffGLRenderer implements GLSurfaceView.Renderer
{


	public GeoffGLRenderer( )
	{
	}

	public void onDrawFrame( GL10 glUnused )
	{
		App.current.update( );
	}

	public void onSurfaceChanged( GL10 glUnused, int width, int height )
	{
		GLES20.glViewport(0, 0, width, height);
		App.current.eventManager.sendEventInt( "Resize", new int[]{ width, height} );
	}

	public void onSurfaceCreated( GL10 glUnused, EGLConfig config )
	{
		if ( !App.current.hasInit )
		{
			App.current.init( );
		}
		
		App.current.eventManager.sendEvent( "ContextCreated" );
	}

	public void onSurfaceDestroyed( GL10 glUnused, EGLConfig config )
	{
		App.current.eventManager.sendEvent( "ContextDestroyed" );
	}

}