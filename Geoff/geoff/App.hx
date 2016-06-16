package geoff;
import haxe.Timer;

/**
 * ...
 * @author Simon
 */
class App
{

	public static var current : App;
	
	public var platform : Platform;
	public var delegate : AppDelegate;
	public var fps : Int = 60;
	public var hasInit : Bool = false;
	
	var _timeOfLastUpdate : Float = 0;
	var _timeSinceLastTick : Float = 0;
	var _updateTime : Float = 0;
	
	public static function main()
	{
		trace("Main");
	}
	
	public static function create( delegate : AppDelegate ) : App
	{
		var app : App = new App( );
		app.platform = new Platform();
		app.delegate = delegate;
		return app;
	}
		
	/**
	 * 
	 */
	
	public function new( ) 
	{
		current = this;
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
		_updateTime = platform.getTime();
		_timeSinceLastTick = _updateTime - _timeOfLastUpdate;
		_timeOfLastUpdate = _updateTime;
		
		platform.eventManager.handleEvents( delegate );
		delegate.update( platform.renderer, _timeSinceLastTick );
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