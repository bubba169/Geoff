package geoff.androidnative;

import android.app.Activity;
import android.os.Bundle;
import android.opengl.GLSurfaceView;

import geoff.App;

public class MainActivity extends Activity
{

	public static Activity activity;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        App app = App.init();
        GeoffGLView glView = new GeoffGLView(this);
        glView.init( app );

        setContentView( glView );

    }
}
