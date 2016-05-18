package geoff;
import geoff.platform.android.AndroidPlatform;
import geoff.platform.interfaces.IGLContext;
import msignal.Signal.Signal1;

/**
 * ...
 * @author Simon
 */
class App
{

	public static var current : App;
	
	public var platform : Platform;
	
	public var rendererReady : Signal1<IGLContext>;
	public var render : Signal1<IGLContext>;
	
	public static function main()
	{
		trace("Main");
	}
	
	public static function init( ) : App
	{
		var app : App = new App( );
		app.platform = new Platform();
		return app;
	}
		
	/**
	 * 
	 */
	
	public function new( ) 
	{
		current = this;
	}
	
	public function initRenderer()
	{
		// Nothing to do here
		rendererReady.dispatch( platform.gl );
	}
	
	public function render()
	{
		// Nothing to do here
		render.dispatch( platform.gl );
	}
	
}