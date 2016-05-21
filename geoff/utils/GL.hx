package geoff.utils;

/**
 * Native haxe bindings for cpp on Windows
 * ...
 * @author Simon
 */

@:buildXml("<target id='haxe'><lib name='opengl32.lib'/></target>")
@include("gl/GL.h")
 
extern class GL
{
	@:native("glClear")
	static function clear( mask : Int ) : Void;	
	
	@:native("glClearColor")
	static function clearColor( r : Float, g : Float, b : Float, a : Float ) : Void;	
}