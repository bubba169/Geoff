package geoff.platform.windows.externs;

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
	public static function genBuffers( n : Int, result : cpp.RawPointer<cpp.UInt32> ) : Int;
	
	@:native("::glCreateShader")
	static public function createShader( type : Int ) : Int;
}