package geoff;
import haxe.Json;
import haxe.Resource;

/**
 * ...
 * @author Simon
 */
class Project
{
	private static var _project : Dynamic;

	public static var name ( get, never ) : String;
	public static function get_name() : String { return _project.name; }
	
	public static var company ( get, never ) : String;
	public static function get_company() : String { return _project.company; }
	
	public static var packageName ( get, never ) : String;
	public static function get_packageName() : String { return _project.packagename; }
	
	public static var version ( get, never ) : String;
	public static function get_version() : String { return _project.version; }
	
	public static var windowWidth ( get, never ) : Int;
	public static function get_windowWidth() : Int { return Std.parseInt(_project.window.width); }
	
	public static var windowHeight ( get, never ) : Int;
	public static function get_windowHeight() : Int { return Std.parseInt(_project.window.height); }
	
	public static var windowOrientation ( get, never ) : String;
	public static function get_windowOrientation() : String { return _project.window.orientation; }
	
	public static var androidVersion ( get, never ) : Int;
	public static function get_androidVersion() : Int { return Std.parseInt(_project.android.version); }
	
	public static function __init__()
	{
		var projectStr = Resource.getString("project");
		_project = Json.parse( projectStr );
	}
	
}