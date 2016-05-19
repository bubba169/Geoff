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
	
	public static function main()
	{
		trace("Main");
	}
	
	public static function create( ) : App
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
	
	public function init()
	{
		platform.gl.clearColor( 1, 1, 1, 1 );
		// Nothing to do here
	}
	
	public function render()
	{
		// Nothing to do here
		platform.gl.clear( platform.gl.COLOR_BUFFER_BIT );
	}
	
}