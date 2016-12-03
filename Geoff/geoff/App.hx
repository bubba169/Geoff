package geoff;
import geoff.event.EventManager;
import haxe.Timer;

/**
 * ...
 * @author Simon
 */
class App
{

	public static var current : App;
	
	public var appId : Int;
	public var isFirstUpdate : Bool = true;
	
	public var platform : Platform;
	public var eventManager : EventManager;
	public var delegate : AppDelegate;
	
	public var fps : Int = 60;
	public var hasInit : Bool = false;
	
	var _timeOfLastUpdate : Float = 0;
	var _timeSinceLastTick : Float = 0;
	var _updateTime : Float = 0;
		
	public static function create( delegate : AppDelegate ) : App
	{	
		var app : App = new App( );
		app.platform = new Platform();
		app.delegate = delegate;
		app.eventManager = new EventManager();
		return app;
	}
		
	/**
	 * 
	 */
	
	public function new( ) 
	{
		current = this;
		appId = Math.floor(Math.random() * 1000);
	}
	
	public function init()
	{
		platform.renderer.init();
		platform.audio.init();
		delegate.init( platform.renderer );
		
		_timeOfLastUpdate = Timer.stamp();
		_timeSinceLastTick = 0;
		
		hasInit = true;
	}
	
	public function update()
	{
		trace("update");
		_updateTime = platform.getTime();
		_timeSinceLastTick = _updateTime - _timeOfLastUpdate;
		_timeOfLastUpdate = _updateTime;
		
		platform.audio.update( _timeSinceLastTick );
		eventManager.handleUpdateEvents( delegate );
		delegate.update( _timeSinceLastTick );
		
		// The other platforms are not threaded yet
		#if !android
			render();
		#end
	}
	
	public function render()
	{
		trace("render");
		eventManager.handleRenderEvents( delegate );
		delegate.render( platform.renderer );
	}
	
	public function destroy()
	{
		delegate.destroy( );
		platform.renderer.destroy();
		platform.audio.destroy();
	}
	
	public function shutdown()
	{
		trace("Shutdown");
		platform.exit();
	}
	
	
}