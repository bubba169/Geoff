package;
import haxe.io.Bytes;
import haxe.io.Float32Array;

/**
 * ...
 * @author ...
 */
class Mat4
{
	var _data : Bytes;
	
	public function new() 
	{
		_data = Bytes.alloc( 4 * 16 );
		for ( i in 0...16 )
		{
			_data.setFloat( i * 4, 0 );
		}
	}
	
	public function get( i : Int ) : Float
	{
		_data.getFloat( i * 4 );
	}
	
	public function set( i : Int, v : Float ) : Float
	{
		_data.setFloat( i * 4, v );
	}
	
	public function copyFrom( other : Mat4 ) : Float
	{
		for ( i in 0...16 )
		{
			_data.setFloat( i * 4, other.get( i * 4 ) );
		}
	}
	
}