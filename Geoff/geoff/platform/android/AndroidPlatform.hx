package geoff.platform.android;
import geoff.event.EventManager;
import geoff.platform.android.AndroidRenderer;

import android.app.Activity;

/**
 * This is a static class that will give access to all of the platform dependant features
 * @author Simon
 */
class AndroidPlatform
{
	public var name : String = "Android";
	
	public var renderer : AndroidRenderer;
	public var eventManager : EventManager;
	public var nativeActivity : Activity;
	
	public function new()
	{
		renderer = new AndroidRenderer();
		eventManager = new EventManager();
	}
	
	public function setActivity( activity : Activity ) : Void
	{
		this.nativeActivity = activity;
	}
}