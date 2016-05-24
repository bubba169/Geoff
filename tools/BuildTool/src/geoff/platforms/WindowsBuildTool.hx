package geoff.platforms;
import geoff.helpers.TemplateHelper;
import sys.FileSystem;
import sys.io.File;
import geoff.helpers.DirectoryHelper;
import sys.io.Process;

/**
 * ...
 * @author Simon
 */
class WindowsBuildTool
{
	var projectDirectory : String;
	var flags : Array<String>;
	var config : Dynamic;

	public function new( dir : String, flags : Array<String>, config : Dynamic )
	{
		this.projectDirectory = dir;
		this.flags = flags;
		this.config = config;
	}
	
	
	public function build( ) : Void
	{
		var binDirectory = projectDirectory + "bin/windows/";
		var templateConstants = 
		[
			"Main" => config.project.main,
			"Version" => config.project.version,
			"ProjectName" => config.project.name
		];	
		
		if ( flags.indexOf( "clean" ) > -1 ) {
		
			if ( FileSystem.exists( projectDirectory + "build.hxml" ) ) FileSystem.deleteFile( projectDirectory + "build.hxml" );
			
			// clean any old builds
			if ( FileSystem.exists( binDirectory ) ) 
			{
				trace("Cleaning " + binDirectory );
				DirectoryHelper.removeDirectory( binDirectory );
			}
			
		}
		
		// Make the directory
		FileSystem.createDirectory( binDirectory + "project" );
		
		//Copy template files
		DirectoryHelper.copyDirectory( config.geoffpath + "template/windows/", binDirectory + "project/" );
		
		trace("Processing templates");
		
		//Fill in values
		TemplateHelper.processTemplates( binDirectory + "project/", templateConstants );
		
		//Compile project to java
		compileHaxe( binDirectory + "build/" );
		
		copyLibs( binDirectory );
		
		compileCPP( binDirectory );
		
	}
	
	
	function compileHaxe( to : String )
	{
		
		var buildHXML = "";
		var srcArray : Array<String> = config.project.src;
		for ( dir in srcArray ) {
			buildHXML += "-cp " + dir + "\n";
		}
		buildHXML += "-cp " + config.geoffpath + "\n";
		var libArray : Array<String> = config.project.haxelib;
		for ( lib in libArray ) {
			buildHXML += "-lib " + lib + "\n";
		}
		buildHXML += "-cpp bin/windows/build\n";
		buildHXML += "-main " + config.project.main + "\n";// geoff.App\n";
		//buildHXML += "-D no-compilation\n";
		
		if ( isDebugBuild() ) {
			buildHXML += "-debug\n";
		}
		
		buildHXML += "-D windows\n";
		buildHXML += "-D static_link\n";
		buildHXML += "-D HX_WINDOWS\n";
		buildHXML += "-D ABI=-MD\n";
		buildHXML += "-dce no\n";
		
		File.saveContent(  projectDirectory + "build.hxml", buildHXML );
		
		Sys.setCwd( projectDirectory );
		Sys.command( "haxe", [ "build.hxml"] );
		
	}
	
	function copyLibs( dir : String ) : Void
	{
		var filename : String = "lib";
		var libName : String = config.project.main;
		if ( libName.indexOf(".") > -1 ) 
		{
			libName = libName.substr( libName.lastIndexOf(".") + 1 );
		}
		filename += libName;
		if ( isDebugBuild() ) filename += "-debug";
		filename += ".lib";
		
		File.copy( dir + "build/" + filename, dir + "/project/lib/libApp.lib" );
		
		var hxcppDir : String = new Process( "haxelib", ["path", "hxcpp"] ).stdout.readLine().toString();
		File.copy( hxcppDir + "lib/Windows/libstd-19.lib", dir + "project/lib/libstd-19.lib" );
		File.copy( hxcppDir + "lib/Windows/libmysql5-19.lib", dir + "project/lib/libmysql5-19.lib" );
		File.copy( hxcppDir + "lib/Windows/libregexp-19.lib", dir + "project/lib/libregexp-19.lib" );
		File.copy( hxcppDir + "lib/Windows/libsqlite-19.lib", dir + "project/lib/libsqlite-19.lib" );
		File.copy( hxcppDir + "lib/Windows/libzlib-19.lib", dir + "project/lib/libzlib-19.lib" );
		
		DirectoryHelper.copyDirectory( dir + "build/include/", dir + "project/include/" );
	}
	
	function compileCPP( dir : String ) : Void 
	{
		Sys.setCwd( dir + "project" );
		Sys.command( "haxelib", ["run", "hxcpp", "build.xml"] );
	}
	
	
	function isDebugBuild() : Bool
	{
		return flags.indexOf("debug") > -1;
	}
}