package geoff.utils;
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
			trace( StringTools.replace( Path.directory(Sys.executablePath()), "\\", "/") + "/assets/" + asset );
			return StringTools.replace( Path.directory(Sys.executablePath()), "\\", "/") + "/assets/" + asset;
		#else	
			return asset;
		#end
	}
	
	public static function getText( asset : String ) : String
	{
		// Reads a text file
		#if android
			var asset = App.current.platform.nativeActivity.getAssets().open( getPath( asset ) );
			var stream = new java.io.InputStreamReader( asset );
			var buffer = new java.io.BufferedReader( stream );
			
			var result : String = "";
			var line : String = buffer.readLine();
			while ( line != null ) 
			{
				result += line;
				line = buffer.readLine();
				if ( line != null ) result += "\n";
			}
			
			buffer.close();
			stream.close();
			asset.close();
			
			return result;
			
		#else
			return File.getContent( getPath( asset ) );
		#end
	}
	
	
	public static function getBytes( asset : String ) : Bytes
	{
		// Reads a binary file
		#if android
			var buffer = App.current.platform.nativeActivity.getAssets().open( getPath( asset ) );
			var bytes = Bytes.alloc( buffer.available() );
			
			buffer.read( bytes.getData() );
			buffer.close();
			
			return bytes;
		#else
			return File.getBytes( getPath( asset ) );
		#end
	}
	
}