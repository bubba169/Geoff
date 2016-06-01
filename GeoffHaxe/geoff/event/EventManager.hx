package geoff.event;
import geoff.AppDelegate;
import geoff.event.Event;
import geoff.event.ResizeEvent;

/**
 * ...
 * @author Simon
 */
 
#if geoff_java
	typedef IntArray = java.NativeArray<Int>;
#else
	typedef IntArray = Array<Int>;
#end
 
class EventManager
{

	private var _eventsQueue : Array<Event>;
	
	public function new() 
	{
		_eventsQueue = new Array<Event>();
	}
	
	public function sendEventInt( event : String, data : IntArray )
	{
		switch( event )
		{
			case ResizeEvent.RESIZE:
				trace( "Resize", data[0], data[1] );
				_eventsQueue.push( new ResizeEvent( ResizeEvent.RESIZE, data[0], data[1] ) );
				
		}
	}
	
	public function handleEvents( delegate : AppDelegate ) : Void
	{
		for ( event in _eventsQueue )
		{
			switch( event.type )
			{
				case ResizeEvent.RESIZE:
					var resizeEvent : ResizeEvent = cast event;
					delegate.resize( resizeEvent.width, resizeEvent.height );
			}
		}
	}
	
}