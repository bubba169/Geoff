package geoff.androidnative;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.view.Window;
import android.view.WindowManager;
import android.view.View;
import android.view.KeyEvent;
import android.view.inputmethod.InputMethodManager;
import android.view.inputmethod.EditorInfo;
import android.view.ViewGroup;
import android.content.Context;
import android.util.Log;
import android.widget.EditText;

import geoff.App;
import geoff.platform.android.GeoffActivity;

public class MainActivity extends GeoffActivity
{

	public static GeoffActivity activity;
	GeoffGLView glView;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
		
		activity = this;
		
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
		getWindow().getDecorView().setSystemUiVisibility( View.SYSTEM_UI_FLAG_HIDE_NAVIGATION | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY );
		getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
		
		// Call the app entry point
		if ( App.current == null || !App.current.hasInit ) {
			{{Main}}.main();
		}
		
		App.current.platform.setActivity( this );
		
        glView = new GeoffGLView(this);
        glView.init();
		
        setContentView( glView );

    }

    @Override
	public void onPause() {
	    super.onPause();  // Always call the superclass method first
	    glView.onPause();

	    App.current.platform.eventManager.sendEvent("Deactivate");
	}

	@Override
	public void onResume() {
	    super.onResume();  // Always call the superclass method first
	    glView.onResume();
	    App.current.platform.eventManager.sendEvent("Activate");
	}

	@Override
	public void onStop() {
	    super.onStop();  // Always call the superclass method first
	}


	@Override 
	public void showKeyboard()
	{
		glView.requestFocus();
		
		InputMethodManager keyboard = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
		keyboard.showSoftInput( glView, 0 );
	}

	@Override
	public void hideKeyboard()
	{
		InputMethodManager keyboard = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
		keyboard.hideSoftInputFromWindow( glView.getWindowToken(), 0 );
	}


}
