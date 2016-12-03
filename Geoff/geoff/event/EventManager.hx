package geoff.event;
import geoff.AppDelegate;
import geoff.event.Event;
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

	private var _updateEventsQueue : Array<Event>;
	private var _renderEventsQueue : Array<Event>;

	public function new()
	{
		_updateEventsQueue = new Array<Event>();
		_renderEventsQueue = new Array<Event>();
	}

	public function sendEvent( event : String, stage : EventStage = EventStage.Update )
	{
		switch( stage ) {
			case Update:
				_updateEventsQueue.push( new Event( event, null ) );
			case Render:
				_renderEventsQueue.push( new Event( event, null ) );
				
		}
	}

	public function sendEventInt( event : String, data : IntArray, stage : EventStage = EventStage.Update )
	{
		switch( stage ) {
			case Update:
				_updateEventsQueue.push( new Event( event, data ) );
			case Render:
				_renderEventsQueue.push( new Event( event, data ) );
				
		}
	}

	public function handleUpdateEvents( delegate : AppDelegate ) : Void
	{
		var event : Event = null;

		while ( _updateEventsQueue.length > 0 )
		{

			event = _updateEventsQueue.shift( );

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

				case EventType.PointerScroll:
					var data : IntArray = event.data;
					delegate.onPointerScroll( data[0], data[1], data[2] );

				case EventType.KeyDown:
					var data : IntArray = event.data;
					delegate.onKeyDown( data[0], data[1] );

				case EventType.KeyUp:
					var data : IntArray = event.data;
					delegate.onKeyUp( data[0], data[1] );

				case EventType.TextEntry:
					var data : IntArray = event.data;
					delegate.onTextInput( String.fromCharCode( data[0] ) );

				/*case EventType.ContextCreated:
					App.current.platform.renderer.onContextCreated();
					delegate.onContextCreated( App.current.platform.renderer );*/
					
				case EventType.AudioBufferEmpty:
					App.current.platform.audio.bufferData();
			}
		}

	}
	
	public function handleRenderEvents( delegate : AppDelegate ) : Void
	{
		var event : Event = null;

		while ( _renderEventsQueue.length > 0 )
		{

			event = _renderEventsQueue.shift( );

			switch( event.type )
			{
				case EventType.ContextCreated:
					App.current.platform.renderer.onContextCreated();
					delegate.onContextCreated( App.current.platform.renderer );
			}
		}

	}


}
