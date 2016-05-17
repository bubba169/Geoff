package uk.co.mojaworks.geoff;

import android.app.Activity;
import android.os.Bundle;
import {{Package}}.R;

public class MainActivity extends Activity
{

	public static Activity activity;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        activity = this;
    }
}
