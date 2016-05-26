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
	
}