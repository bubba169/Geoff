package geoff.platform.windows.externs;

import cpp.*;

/**
 * Native haxe bindings for cpp on Windows
 * ...
 * @author Simon
 */
@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/template/windows/include'/></files>")
@:include("GLBindings.h")

extern class GL
{
	@:native("::glClear") 
	public static function clear( mask : Int ) : Void;	
	
	@:native("::glClearColor") 
	public static function clearColor( r : Float, g : Float, b : Float, a : Float ) : Void;
	
	@:native("::glGenBuffers") 
	public static function genBuffers( n : Int, result : RawPointer<UInt32> ) : Int;
	
	@:native("::glCreateShader")
	static public function createShader( type : Int ) : Int;
	
	@:native("::glShaderSource")
	static public function shaderSource( shader : Int, count : Int, sources : RawPointer<ConstCharStar>, lengths : RawPointer<Int> ) : Void;
	
	@:native("::glCompileShader")
	static public function compileShader( shader : Int ) : Void;
}