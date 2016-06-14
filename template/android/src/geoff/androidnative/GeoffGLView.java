package geoff.androidnative;

import android.opengl.GLSurfaceView;
import android.content.Context;
import android.view.MotionEvent;
import android.view.KeyEvent;
import android.util.Log;
import android.view.inputmethod.InputMethodManager;
import android.view.inputmethod.InputConnection;
import android.view.inputmethod.EditorInfo;
import java.lang.Runnable;

import geoff.App;

public class GeoffGLView extends GLSurfaceView
{
	private GeoffGLRenderer renderer;

	public GeoffGLView( Context context )
	{
		super( context );

		this.setFocusable(true);
		this.setFocusableInTouchMode(true);
	}

	public void init( )
	{

		setEGLContextClientVersion(2);
		
		renderer = new GeoffGLRenderer( );
		setRenderer( renderer );



	}
	
	public boolean onTouchEvent( MotionEvent originalEvent )
	{
		

		final MotionEvent event = originalEvent;
		final int pointerId = event.getActionIndex();
		final int action = event.getActionMasked();
		
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
		
		App.current.platform.eventManager.sendEventInt( "KeyDown", new int[] { keyCode, 0 } );

		return true;
	}

	public boolean onKeyUp( int keyCode, KeyEvent event )
	{
		
		App.current.platform.eventManager.sendEventInt( "KeyUp", new int[] { keyCode, 0 } );

		int uchar = event.getUnicodeChar();
		if ( uchar != 0 ) 
		{
			App.current.platform.eventManager.sendEventInt( "TextEntry", new int[] { uchar } );
		}
				
		return true;
	}

	@Override
  	public InputConnection onCreateInputConnection(EditorInfo outAttrs) {
    	InputConnection conn = super.onCreateInputConnection(outAttrs);
   		outAttrs.imeOptions = EditorInfo.IME_FLAG_NO_FULLSCREEN;
   		return conn;
	}
	
	
}