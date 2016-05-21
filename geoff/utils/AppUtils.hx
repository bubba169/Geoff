package geoff.utils;

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
	
}