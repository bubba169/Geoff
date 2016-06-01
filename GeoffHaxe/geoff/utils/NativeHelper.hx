package geoff.utils;
import haxe.io.Bytes;

/**
 * ...
 * @author ...
 */
class NativeHelper
{

	public static function toFloatBytes( array : Array<Float> ) : Bytes
	{
		var bytes : Bytes = Bytes.alloc( array.length * 4 );
		for ( i in 0...array.length ) 
		{
			bytes.setFloat( i * 4, array[i] );
		}
		
		return bytes;
	}
	
	public static function toIntBytes( array : Array<Int> ) : Bytes
	{
		var bytes : Bytes = Bytes.alloc( array.length * 2 );
		for ( i in 0...array.length ) 
		{
			bytes.setUInt16( i * 2, array[i] );
		}
		
		return bytes;
	}
	
	#if geoff_java 
	
	static public function toFloatBuffer( array : Array<Float> ) : java.nio.FloatBuffer
	{
		var buffer = java.nio.FloatBuffer.allocate( array.length );
		for ( i in 0...array.length ) 
		{
			buffer.put( i, array[i] );
		} 
		return buffer;
	}
	
	static public function toShortBuffer( array : Array<Int> ) : java.nio.ShortBuffer
	{
		var buffer = java.nio.ShortBuffer.allocate( array.length );
		for ( i in 0...array.length ) 
		{
			buffer.put( i, array[i] );
		}
		return buffer;
	}
	
	#end
}