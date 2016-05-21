package geoff.utils;

/**
 * Native haxe bindings for cpp on Windows
 * ...
 * @author Simon
 */

@:include("./../../GL.h")
@:native("GL")
 
extern class GL
{
	public static function glClear( mask : Int ) : Void;	
	public static function glClearColor( r : Float, g : Float, b : Float, a : Float ) : Void;	
}