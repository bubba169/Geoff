package geoff.androidnative;

import android.opengl.GLSurfaceView;
import android.content.Context;
import android.view.MotionEvent;
import android.view.KeyEvent;
import android.util.Log;
import android.view.inputmethod.InputMethodManager;

import geoff.App;

public class GeoffGLView extends GLSurfaceView
{
	private GeoffGLRenderer renderer;

	public GeoffGLView( Context context )
	{
		super( context );
	}

	public void init( )
	{

		setEGLContextClientVersion(2);
		
		renderer = new GeoffGLRenderer( );
		setRenderer( renderer );

	}
	
	public boolean onTouchEvent( MotionEvent event )
	{
		

		int pointerId = event.getActionIndex();
		int action = event.getActionMasked();
		
		switch( action )
		{
			case MotionEvent.ACTION_DOWN:
			case MotionEvent.ACTION_POINTER_DOWN:
				App.current.platform.eventManager.sendEventInt( "PointerDown", new int[] {pointerId, 0, (int)event.getX( pointerId ), (int)event.getY( pointerId )} ); 
				break;
				
			case MotionEvent.ACTION_UP:
			case MotionEvent.ACTION_POINTER_UP:
				App.current.platform.eventManager.sendEventInt( "PointerUp", new int[] {pointerId, 0, (int)event.getX( pointerId ), (int)event.getY( pointerId )} ); 
				break;
				
			case MotionEvent.ACTION_MOVE:
				for ( int i = 0; i < event.getPointerCount(); ++i ) {
					App.current.platform.eventManager.sendEventInt( "PointerMove", new int[] { event.getPointerId( i ), (int)event.getX( i ), (int)event.getY( i )} );
				}
				break;
		}
		
		return true;
	}

	public boolean onKeyDown( int keyCode, KeyEvent event )
	{
		Log.v( "Hello", "" + keyCode );
		Log.v( "Hello", "" + event );
		return false;
	}
	
	
}