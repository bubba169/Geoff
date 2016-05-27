package geoff.event;
import geoff.event.Event;
import geoff.event.ResizeEvent;

/**
 * ...
 * @author Simon
 */
 
class EventManager
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