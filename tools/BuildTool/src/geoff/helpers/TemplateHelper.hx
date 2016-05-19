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
				if ( file.indexOf(".txt") > -1 || file.indexOf(".xml") > -1 || file.indexOf(".properties") > -1 || file.indexOf(".java") > -1 || file.indexOf(".hx") > -1 )
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