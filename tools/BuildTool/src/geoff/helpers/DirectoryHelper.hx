package geoff.helpers;
import sys.FileSystem;
import sys.io.File;

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
	
}