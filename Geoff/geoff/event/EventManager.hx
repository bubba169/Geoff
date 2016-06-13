package geoff.event;
import geoff.AppDelegate;
import geoff.event.Event;
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
	
	public function sendEvent( event : String )
	{
		//trace( event );
		_eventsQueue.push( new Event( event, null ) );
	}
	
	public function sendEventInt( event : String, data : IntArray )
	{
		//trace( event, data );
		_eventsQueue.push( new Event( event, data ) );
	}
	
	public function handleEvents( delegate : AppDelegate ) : Void
	{
		var event : Event = null;
		
		while ( _eventsQueue.length > 0 )
		{		
			
			event = _eventsQueue.shift( );
			
			switch( event.type )
			{
				case EventType.Resize:
					trace( event.type, event.data );
					var data : IntArray = event.data;
					delegate.resize( data[0], data[1] );
					
				case EventType.PointerDown:
					trace( event.type, event.data );
					var data : IntArray = event.data;
					delegate.onPointerDown( data[0], data[1], data[2], data[3] );
					
				case EventType.PointerUp:
					trace( event.type, event.data );
					var data : IntArray = event.data;
					delegate.onPointerUp( data[0], data[1], data[2], data[3] );
					
				case EventType.PointerMove:
					trace( event.type, event.data );
					var data : IntArray = event.data;
					delegate.onPointerMove( data[0], data[1], data[2] );
				
				case EventType.PointerScroll:
					trace( event.type, event.data );
					var data : IntArray = event.data;
					delegate.onPointerScroll( data[0], data[1], data[2] );
					
				case EventType.ContextCreated:
					trace( event.type, event.data );
					App.current.platform.renderer.onContextCreated();
					delegate.onContextCreated( App.current.platform.renderer );
			}
		}
		
	}
	
}