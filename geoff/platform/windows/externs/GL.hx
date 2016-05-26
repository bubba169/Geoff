package geoff.platform.windows.externs;

import cpp.*;
import geoff.gl.GLShader.GLShaderParameter;
import haxe.io.UInt32Array;
import haxe.xml.Check.Attrib;

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
	
	/**
	 * Buffers
	 */	
	
	@:native("::glGenBuffers") 
	public static function genBuffers( n : Int, result : RawPointer<UInt32> ) : Int;
	
	@:native("::glBindBuffer")
	public static function bindBuffer( target : Int, buffer : Int ) : Void;
	
	@:native("::glBufferData")
	public static function bufferData( target : Int, size : Int, data : RawPointer<Char>, usage : Int ) : Void;
	
	/**
	 * Shaders
	 */
	
	@:native("::glCreateShader")
	static public function createShader( type : Int ) : Int;
	
	@:native("::glShaderSource")
	static public function shaderSource( shader : Int, count : Int, sources : RawPointer<ConstCharStar>, lengths : RawPointer<Int> ) : Void;
	
	@:native("::glCompileShader")
	static public function compileShader( shader : Int ) : Void;
	
	@:native("::glGetShaderiv")
	static public function getShaderiv( shader : Int, param : Int, result : RawPointer<Int> ) : Void; 
	
	@:native("::glGetShaderInfoLog")
	static public function getShaderInfoLog( shader : Int, max : Int, sizeResult : RawPointer<Int>, result : RawPointer<Char> ) : Void;
	
	
	
	@:native("::glCreateProgram")
	static public function createProgram( ) : Int;
	
	@:native("::glAttachShader")
	static public function attachShader( program : Int, shader : Int ) : Int;
	
	@:native("::glLinkProgram")
	static public function linkProgram( program : Int ) : Int;
	
	@:native("::glGetProgramiv")
	static public function getProgramiv( program : Int, param : Int, result : RawPointer<Int> ) : Int;
	
	@:native("::glGetProgramInfoLog")
	static public function getProgramInfoLog( shader : Int, max : Int, sizeResult : RawPointer<Int>, result : RawPointer<Char> ) : Void;
	
	
}