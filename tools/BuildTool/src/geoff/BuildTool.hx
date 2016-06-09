package geoff;

import geoff.platforms.AndroidBuildTool;
import geoff.platforms.WindowsBuildTool;
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
		tool.build();
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
			return Json.parse( configString );
		}
		else
		{
			return null;
		}
	}
	
	
	function loadConfig( projectDirectory : String ) : Dynamic
	{
		var config = { geoffpath: "", global: null, project: null };
		config.geoffpath = new Process( "haxelib", ["path", "geoff"] ).stdout.readLine().toString() + "../";
		config.global = parseConfig( Sys.getEnv("APPDATA") + "/Geoff/geoff.cfg" );
		config.project = parseConfig( projectDirectory + "project.geoff" );
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
	 
	public function build()
	{		
		
		Sys.stdout().writeString("\n\nGeoff build tool. Version 0.0.1");
		
		if ( !actions.exists( Sys.args()[0] ) )
		{
			trace( "Please specify an action!");
			return;
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
		
		switch( targetPlatform.toLowerCase() )
		{
			case "android":
				var builder = new AndroidBuildTool( projectDirectory, flags, config, buildNumber );
				builder.build();
				
			case "windows":
				var builder = new WindowsBuildTool( projectDirectory, flags, config );
					if ( (action & ACTION_CLEAN)> 0 ) builder.clean();
					if ( (action & ACTION_UPDATE) > 0 ) builder.update();
					if ( (action & ACTION_BUILD) > 0 ) builder.build();
					if ( (action & ACTION_RUN) > 0 ) builder.run();				
		}
	}
		
}