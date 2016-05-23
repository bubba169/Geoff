package geoff.platform.windows;

/**
 * Native haxe bindings for cpp on Windows
 * ...
 * @author Simon
 */

@:include("./../../../template/windows/include/glfw/glfw3.h")
 
extern class GL
{
	@:native("glClear")
	public static function clear( mask : Int ) : Void;	
	
	@:native("glClearColor")
	public static function clearColor( r : Float, g : Float, b : Float, a : Float ) : Void;
}