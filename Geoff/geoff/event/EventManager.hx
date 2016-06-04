package geoff.event;
import geoff.AppDelegate;
import geoff.event.Event.EventType;
import geoff.event.EventManager.IntArray;

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
		trace( event, data );
		_eventsQueue.push( new Event( event, data ) );
	}
	
	public function handleEvents( delegate : AppDelegate ) : Void
	{
		for ( event in _eventsQueue )
		{
			switch( event.type )
			{
				case EventType.Resize:
					var data : IntArray = event.data;
					delegate.resize( data[0], data[1] );
					
				case EventType.PointerDown:
					var data : IntArray = event.data;
					delegate.onPointerDown( data[0], data[1], data[2], data[3] );
					
				case EventType.PointerUp:
					var data : IntArray = event.data;
					delegate.onPointerUp( data[0], data[1], data[2], data[3] );
					
				case EventType.PointerMove:
					var data : IntArray = event.data;
					delegate.onPointerMove( data[0], data[1], data[2] );
			}
		}
	}
	
}