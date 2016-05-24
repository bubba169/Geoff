package geoff.platform.windows;
import geoff.platform.event.Event;
import geoff.platform.event.ResizeEvent;
import geoff.platform.interfaces.IEventManager;

/**
 * ...
 * @author Simon
 */
 
class WindowsEventManager implements IEventManager
{

	private var _eventsQueue : Array<Event>;
	
	public function new() 
	{
		_eventsQueue = new Array<Event>();
	}
	
	public function sendEventInt( event : String, data : Array<Int> )
	{
		switch( event )
		{
			case ResizeEvent.RESIZE:
				trace( "Resize", data[0], data[1] );
				_eventsQueue.push( new ResizeEvent( ResizeEvent.RESIZE, data[0], data[1] ) );
				
		}
	}
	
}