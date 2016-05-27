package geoff.utils;

/**
 * ...
 * @author Simon
 */
class MathUtils
{
	
	public static var RAD2DEG : Float = (180 / Math.PI);
	public static var DEG2RAD : Float = (Math.PI / 180);
	
	public static function roundToNextPow2( val : Float ) : Int {
		return Std.int( Math.pow( 2, Math.ceil( Math.log( val ) / Math.log(2) ) ) );
	}
	
	static public function clamp( min:Float, max:Float, num:Float ) : Float
	{
		return Math.min( max, Math.max( min, num ) );
	}
	
	static public function clamp01( num:Float ) : Float
	{
		return Math.min( 1, Math.max( 0, num ) );
	}
	
}