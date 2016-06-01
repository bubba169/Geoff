package geoff.androidnative;

import javax.microedition.khronos.egl.EGLConfig;
import javax.microedition.khronos.opengles.GL10;

import android.opengl.GLES20;

import android.opengl.GLSurfaceView;
import geoff.App;

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
		app.init( );
	}
}