package test.test;

import android.app.Activity;
import android.os.Bundle;
import android.os.PersistableBundle;

/**
 * 
 * 
 */

class TestActivity extends Activity
{
	
    public function new()
	{
		super();
	}
	
	@:overload
	override public function onCreate( bundle : Bundle ) : Void
	{
		super.onCreate( bundle );
	}
	
}