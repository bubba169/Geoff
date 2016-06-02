package geoff.utils;

/**
 * ...
 * @author Simon
 */
class Assets
{

	public static function getPath( asset : String ) : String
	{
		#if windows
			return "assets/" + asset;
		#else	
			return asset;
		#end
	}
	
}