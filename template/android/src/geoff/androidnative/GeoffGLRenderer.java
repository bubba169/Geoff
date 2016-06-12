package geoff.androidnative;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import android.opengl.GLES20;

import android.opengl.GLSurfaceView;
import geoff.App;
import android.util.Log;

public class GeoffGLRenderer implements GLSurfaceView.Renderer
{

	private App app;

	public GeoffGLRenderer( App app )
	{
		this.app = app;
	}

	public void onDrawFrame( GL10 glUnused )
	{
		app.update( );
	}

	public void onSurfaceChanged( GL10 glUnused, int width, int height )
	{
		GLES20.glViewport(0, 0, width, height);
		app.platform.eventManager.sendEventInt( "Resize", new int[]{ width, height} );
	}

	public void onSurfaceCreated( GL10 glUnused, EGLConfig config )
	{

		Log.v("Renderer", "SurfaceCreated " + App.current.hasInit );

		if ( !App.current.hasInit )
		{
			app.init( );
		}
		else
		{
			app.platform.eventManager.sendEvent( "ContextCreated" );
		}
	}

	public void onSurfaceDestroyed( GL10 glUnused, EGLConfig config )
	{

		Log.v("Renderer", "SurfaceDestroyed " + App.current.hasInit );

		if ( !App.current.hasInit )
		{
			app.init( );
		}
		else
		{
			app.platform.eventManager.sendEvent( "ContextDestroyed" );
		}
	}
}