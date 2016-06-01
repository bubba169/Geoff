package geoff.platform.android;
import geoff.event.EventManager;
import geoff.platform.android.AndroidRenderer;

/**
 * This is a static class that will give access to all of the platform dependant features
 * @author Simon
 */
class AndroidPlatform
{
	public var name : String = "Android";
	
	public var renderer : AndroidRenderer;
	public var eventManager : EventManager;
	
	public function new()
	{
		renderer = new AndroidRenderer();
		eventManager = new EventManager();
	}
}