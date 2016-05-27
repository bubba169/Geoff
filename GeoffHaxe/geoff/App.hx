package geoff;

/**
 * ...
 * @author Simon
 */
class App
{

	public static var current : App;
	
	public var platform : Platform;
	public var delegate : AppDelegate;
	
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
		delegate.init( platform.renderer );
	}
	
	public function update()
	{
		delegate.update( platform.renderer );
	}
	
}