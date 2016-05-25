package geoff.platform.windows.externs;

/**
 * Native haxe bindings for cpp on Windows
 * ...
 * @author Simon
 */
@:include("./../../../../template/windows/include/GLBindings.h")

extern class GL
{
	@:native("geoff::GLBindings::clear") 
	public static function clear( mask : Int ) : Void;	
	
	@:native("geoff::GLBindings::clearColor") 
	public static function clearColor( r : Float, g : Float, b : Float, a : Float ) : Void;
	
	@:native("geoff::GLBindings::createBuffer") 
	public static function createBuffer( ) : Int;
}