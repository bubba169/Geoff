package geoff.renderer;
import geoff.utils.NativeHelper;
import haxe.io.Bytes;
import haxe.io.BytesData;
import haxe.io.UInt8Array;

/**
 * ...
 * @author ...
 */
class Texture
{
	
	public var id : String;
	public var textureId : UInt = 0;
	public var width : Int = 0;
	public var height : Int = 0;
	public var asset : String;
	public var pixels : Array<Int>;
	public var map : Dynamic;
	public var useCount : Int = 0;
	public var isValid : Bool = true;
	public var smoothing : Bool = true;

	public function new( id : String ) 
	{
		this.id = id;
	}
	
	#if geoff_cpp
		public function getRawPixels( ) : BytesData
		{
			return NativeHelper.toUInt8Bytes( pixels ).getData();
		}
	#end
	
	
	#if geoff_java
		public function getRawPixels( ) : java.nio.ByteBuffer
		{
			return NativeHelper.toByteBuffer( pixels );
		}
	#end
}