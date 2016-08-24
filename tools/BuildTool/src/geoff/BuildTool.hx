package geoff;

import geoff.helpers.DirectoryHelper;
import geoff.platforms.AndroidBuildTool;
import geoff.platforms.WindowsBuildTool;
import geoff.platforms.IOSBuildTool;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;

/**
 * ...
 * @author Simon
 */
class BuildTool
{

	public static var ACTION_CLEAN : Int = 1;
	public static var ACTION_BUILD : Int = 2;
	public static var ACTION_RUN : Int = 4;
	public static var ACTION_UPDATE : Int = 8;

	public static var actions : Map<String,Int> = [
		"clean" => ACTION_CLEAN,
		"build" => ACTION_BUILD + ACTION_UPDATE,
		"update" => ACTION_UPDATE,
		"run" => ACTION_RUN,
		"test" => ACTION_UPDATE + ACTION_BUILD + ACTION_RUN
	];

	static function main()
	{
		var tool = new BuildTool();
		var returnCode = tool.build();
		Sys.exit( returnCode );
	}

	/**
	 *
	 * @return
	 */

	function new()
	{

	}

	function parseConfig( path : String ) : Dynamic
	{
		if ( FileSystem.exists( path ) )
		{
			var configString = File.getContent( path );
			var configObject = Json.parse( configString );

			// Set up some sensible defaults
			if ( configObject.defines == null )
			{
				configObject.defines = [];
			}

			if ( configObject.haxelib == null )
			{
				configObject.haxelib = [];
			}

			return configObject;
		}
		else
		{
			return null;
		}
	}


	function loadConfig( projectDirectory : String ) : Dynamic
	{
		var config = { geoffpath: "", global: null, project: null };
		config.geoffpath = DirectoryHelper.getHaxelibDir("geoff") + "../";
		config.global = parseConfig( Sys.getEnv("APPDATA") + "/Geoff/geoff.cfg" );
		config.project = parseConfig( projectDirectory + "project.geoff" );

		// Check any directly included libs for defines
		var libArray : Array<String> = config.project.haxelib;
		for ( lib in libArray )
		{
			var libConfig = parseConfig( DirectoryHelper.getHaxelibDir( lib ) + "lib.geoff" );
			if ( libConfig != null ) {
				var libDefines : Array<String> = libConfig.defines;
				for ( define in libDefines ) {
					config.project.defines.push( define );
				}
			}
		}

		return config;
	}


	/**
	 *
	 */

	public function incrementVersionCode( projectDirectory : String ) : String
	{
		var versionFile = projectDirectory + ".buildversion";
		var version = 0;
		if ( FileSystem.exists( versionFile ) )
			version = Std.parseInt( File.getContent( versionFile ) );

		version++;
		File.saveContent( versionFile, Std.string(version) );
		return Std.string(version);
	}

	public function build() : Int
	{

		Sys.stdout().writeString("\n\nGeoff build tool. Version 0.0.1");

		if ( !actions.exists( Sys.args()[0] ) )
		{
			trace( "Please specify an action!");
			return -1;
		}

		var projectDirectory = Sys.args()[ Sys.args().length - 1 ];
		var action = actions.get( Sys.args()[0] );
		var targetPlatform = Sys.args()[1];
		var flags = [];

		for ( i in 2...Sys.args().length - 1 )
		{
			if ( i < Sys.args().length - 1 )
			{
				flags.push( Sys.args()[i] );
			}
		}

		Sys.stdout().writeString("\n\nProject Directory: " + projectDirectory );
		Sys.stdout().writeString("\nAction:            " + action );
		Sys.stdout().writeString("\nTarget:            " + targetPlatform );
		Sys.stdout().writeString("\nFlags:             " + flags + "\n\n" );

		var config = loadConfig( projectDirectory );

		var buildNumber = incrementVersionCode( projectDirectory );
		var builder : Dynamic = null;

		switch( targetPlatform.toLowerCase() )
		{
			case "android":
				builder = new AndroidBuildTool( projectDirectory, flags, config, buildNumber );

			case "windows":
				builder = new WindowsBuildTool( projectDirectory, flags, config );

			case "ios":
				builder = new IOSBuildTool( projectDirectory, flags, config );

		}

		if ( builder != null )
		{
			var error : Int = 0;
			if ( (action & ACTION_CLEAN) > 0 ) error = builder.clean();
			if ( error == 0 && ((action & ACTION_UPDATE) > 0) ) error = builder.update();
			if ( error == 0 && ((action & ACTION_BUILD) > 0) ) error = builder.build();
			if ( error == 0 && ((action & ACTION_RUN) > 0) ) error = builder.run();
			
			return error;
		}
		
		return 0;

	}

}
