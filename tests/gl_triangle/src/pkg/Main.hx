package pkg;
import geoff.App;
import pkg.AppEngine;

/**
 * ...
 * @author Simon
 */
class Main
{
	
	public static function main()
	{
		trace("Hello World");
		
		App.create( new AppEngine() );
	}
	
}