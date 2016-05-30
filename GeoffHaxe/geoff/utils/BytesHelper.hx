package geoff.utils;
import haxe.io.Bytes;

/**
 * ...
 * @author ...
 */
class BytesHelper
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
	
}