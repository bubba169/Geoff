package geoff.utils;
import geoff.App;
import cpp.Pointer;

/**
 * C++ code struggles to communicate using anything but static functions so...
 * ...
 * @author Simon
 */
class AppUtils
{

	public static function init()
	{
		App.current.init();
	}
	
	public static function render()
	{
		App.current.render();
	}
	
	public static function create() : Pointer<App>
	{
		App.create();
		return Pointer.addressOf( App.current );
	}
	
}