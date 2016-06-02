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
				
			case PointerEvent.DOWN:
				trace( "PointerDown", data[0], data[1], data[2], data[3] );
				_eventsQueue.push( new PointerEvent( PointerEvent.DOWN, data[0], data[1], data[2], data[3] ) );
				
			case PointerEvent.UP:
				trace( "PointerUp", data[0], data[1], data[2], data[3] );
				_eventsQueue.push( new PointerEvent( PointerEvent.UP, data[0], data[1], data[2], data[3] ) );
				
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
					
				case PointerEvent.DOWN:
					var pointerEvent : PointerEvent = cast event;
					delegate.onPointerDown( pointerEvent.pointerId, pointerEvent.button, pointerEvent.x, pointerEvent.y );
					
				case PointerEvent.UP:
					var pointerEvent : PointerEvent = cast event;
					delegate.onPointerUp( pointerEvent.pointerId, pointerEvent.button, pointerEvent.x, pointerEvent.y );
			}
		}
	}
	
}