package geoff.helpers;
import sys.FileSystem;
import sys.io.File;

/**
 * ...
 * @author ...
 */
class TemplateHelper
{

	public static function processTemplates( dir : String, constants : Map<String,String> )
	{
		var fileList = FileSystem.readDirectory( dir );
		for ( file in fileList )
		{
			if ( !FileSystem.isDirectory( dir + file ) )
			{
				var extensions : Array<String> = [ ".txt", ".xml", ".properties", ".java", ".cpp", ".h", ".hx", ".pbxproj" ];

				var shouldProcess = false;
				for ( extension in extensions )
				{
					if ( file.indexOf( extension ) > -1 )
					{
						shouldProcess = true;
						break;
					}
				}

				if ( shouldProcess )
				{
					var regex = new EReg( "\\{\\{([^\\}]+)\\}\\}", "g" );
					var raw = File.getContent( dir + file );
					var processed = regex.map( raw, function( regex )
					{
						return constants.get( regex.matched(1) );
					});

					File.saveContent( dir + file, processed );
				}
			}
			else
			{
				processTemplates( dir + file + "/", constants );
			}
		}
	}

}
