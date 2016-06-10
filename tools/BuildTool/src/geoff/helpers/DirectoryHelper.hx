package geoff.helpers;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;

/**
 * ...
 * @author Simon
 */
class DirectoryHelper
{

	public static function copyDirectory( from : String, to : String ) 
	{
		var fileList = FileSystem.readDirectory( from );
		for ( file in fileList ) 
		{
			if ( FileSystem.isDirectory( from + file ) )
			{
				FileSystem.createDirectory( to + file );
				copyDirectory( from + file + "/", to + file + "/" );
			}
			else
			{
				File.copy( from + file, to + file );
			}
		}
	}
	
	
	public static function removeDirectory( dir : String ) 
	{
		if ( FileSystem.exists( dir ) ) {
			var fileList = FileSystem.readDirectory( dir );
			for ( file in fileList ) 
			{
				if ( FileSystem.isDirectory( dir + file ) )
				{
					removeDirectory( dir + file + "/" );
				}
				else
				{
					FileSystem.deleteFile( dir + file );
				}
			}
			
			FileSystem.deleteDirectory( dir );
		}
	}
	
	
	public static function getHaxelibDir( lib : String ) 
	{
		var process : Process = new Process( "haxelib", ["path", lib] );
		var line : String = process.stdout.readLine();
		while ( line != null )
		{
			if ( !StringTools.startsWith( line, "-" ) )
			{
				return line;
			}
		}
		
		return "";
	}
	
}