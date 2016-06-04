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
		
		var projectDirectory = Sys.args()[ Sys.args().length - 1 ];
		var targetPlatform = Sys.args()[0];
		var flags = [];
		
		for ( i in 1...Sys.args().length - 1 )
		{
			if ( i < Sys.args().length - 1 )
			{
				flags.push( Sys.args()[i] );
			}			
		}
		
		Sys.stdout().writeString("\n\nProject Directory: " + projectDirectory );
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
				builder.build();
				
		}
	}
		
}