package geoff.assets;
import haxe.io.BufferInput;
import haxe.io.Bytes;
import haxe.io.Path;
import sys.io.File;

/**
 * ...
 * @author Simon
 */
class Assets
{

	public static function getPath( asset : String ) : String
	{
		#if windows
			return StringTools.replace( Path.directory(Sys.executablePath()), "\\", "/") + "/assets/" + asset;
		#else	
			return asset;
		#end
	}
	
	
	public static function exists( asset : String ) : Bool
	{
		return App.current.platform.assetLoader.assetExists( asset );
	}
	
	
	public static function getText( asset : String ) : String
	{
		// Reads a text file
		return App.current.platform.assetLoader.getText( asset );
	}
	
	
	public static function getBytes( asset : String ) : Bytes
	{
		// Reads a binary file
		return App.current.platform.assetLoader.getBytes( asset );
	}
	
}