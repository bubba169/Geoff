package geoff.androidnative;

import android.opengl.GLSurfaceView;
import android.content.Context;
import android.view.MotionEvent;
import android.util.Log;

import geoff.App;

public class GeoffGLView extends GLSurfaceView
{
	private GeoffGLRenderer renderer;
	private App app;

	public GeoffGLView( Context context )
	{
		super( context );
	}

	public void init( App app )
	{
		this.app = app;

		setEGLContextClientVersion(2);
		
		renderer = new GeoffGLRenderer( app );
		setRenderer( renderer );
		
	}
	
	public boolean onTouchEvent( MotionEvent event )
	{
		switch( event.getAction() )
		{
			case MotionEvent.ACTION_DOWN:
			case MotionEvent.ACTION_POINTER_DOWN:
				
				break;
		}
	}
	
	
}