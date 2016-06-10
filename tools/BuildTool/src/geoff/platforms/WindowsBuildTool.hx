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
	var binDirectory : String;
	var flags : Array<String>;
	var config : Dynamic;

	
	public function new( dir : String, flags : Array<String>, config : Dynamic )
	{
		this.projectDirectory = dir;
		this.flags = flags;
		this.config = config;
		this.binDirectory = projectDirectory + "bin/windows/";
	}
	
	
	public function clean()
	{
		if ( FileSystem.exists( projectDirectory + "build.hxml" ) ) FileSystem.deleteFile( projectDirectory + "build.hxml" );
			
		// clean any old builds
		if ( FileSystem.exists( binDirectory ) ) 
		{
			trace("Cleaning " + binDirectory );
			DirectoryHelper.removeDirectory( binDirectory );
		}
	}
	
	
	public function update( )
	{
		
		var buildHXML = "";
		var srcArray : Array<String> = config.project.src;
		for ( dir in srcArray ) {
			buildHXML += "-cp " + dir + "\n";
		}
		
		var libArray : Array<String> = config.project.haxelib;
		for ( lib in libArray ) {
			buildHXML += "-lib " + lib + "\n";
		}
		
		buildHXML += "-cpp bin/windows/build\n";
		buildHXML += "-main " + config.project.main + "\n";
		
		if ( isDebugBuild() ) {
			buildHXML += "-debug\n";
		}
		
		buildHXML += "-D windows\n";
		buildHXML += "-D static_link\n";
		buildHXML += "-D HX_WINDOWS\n";
		buildHXML += "-D ABI=-MD\n";
		buildHXML += "-D geoff_cpp\n";
		
		if ( !isDebugBuild() ) buildHXML += "-D no_console\n";
		File.saveContent(  projectDirectory + "build.hxml", buildHXML );
		
	}
	
	
	public function build( ) : Void
	{
		var templateConstants = 
		[
			"Main" => config.project.main,
			"Version" => config.project.version,
			"ProjectName" => config.project.name,
			"WindowWidth" => config.project.window.width,
			"WindowHeight" => config.project.window.height,
			"ConsoleSetting" => ""
		];	
		
		if ( !isDebugBuild() )
		{
			templateConstants.set( "ConsoleSetting", "<set name='no_console' value='true'/>" );
		}		
		
		if ( flags.indexOf( "clean" ) > -1 ) {
			clean();
		}
		
		// Make the directory
		FileSystem.createDirectory( binDirectory + "project" );
		
		//Copy template files
		DirectoryHelper.copyDirectory( config.geoffpath + "template/windows/", binDirectory + "project/" );
		
		trace("Processing templates");
		
		//Fill in values
		TemplateHelper.processTemplates( binDirectory + "project/", templateConstants );
		
		//Compile project to java
		compileHaxe( );
		
		copyLibs( );
		copyAssets( );
		
		compileCPP( );
		
	}
	
	
	function compileHaxe( )
	{
		Sys.setCwd( projectDirectory );
		Sys.command( "haxe", [ "build.hxml"] );
	}
	
	function copyAssets( )
	{		
		trace("Looking for assets in " + config.project.haxelib );
		
		var libArray : Array<String> = config.project.haxelib;
		for ( lib in libArray ) {
			var libdir_assets = new Process( "haxelib", ["path", lib] ).stdout.readLine().toString() + "assets";
			
			trace("Looking for assets in " + libdir_assets );
			
			if ( FileSystem.exists( libdir_assets ) && FileSystem.isDirectory( libdir_assets ) )
			{
				DirectoryHelper.copyDirectory( libdir_assets + "/", binDirectory + "/project/assets/" );
			}
		}
		
		if ( FileSystem.exists( projectDirectory + "assets" ) )
		{
			DirectoryHelper.copyDirectory( projectDirectory + "assets/", binDirectory + "/project/assets/" );
		}
	}
	
	function copyLibs( ) : Void
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
		
		File.copy( binDirectory + "build/" + filename, binDirectory + "/project/lib/libApp.lib" );
		
		var hxcppDir : String = new Process( "haxelib", ["path", "hxcpp"] ).stdout.readLine().toString();
		File.copy( hxcppDir + "lib/Windows/libstd-19.lib", binDirectory + "project/lib/libstd-19.lib" );
		File.copy( hxcppDir + "lib/Windows/libmysql5-19.lib", binDirectory + "project/lib/libmysql5-19.lib" );
		File.copy( hxcppDir + "lib/Windows/libregexp-19.lib", binDirectory + "project/lib/libregexp-19.lib" );
		File.copy( hxcppDir + "lib/Windows/libsqlite-19.lib", binDirectory + "project/lib/libsqlite-19.lib" );
		File.copy( hxcppDir + "lib/Windows/libzlib-19.lib", binDirectory + "project/lib/libzlib-19.lib" );
		
		DirectoryHelper.copyDirectory( binDirectory + "build/include/", binDirectory + "project/include/" );
	}
	
	function compileCPP( ) : Void 
	{
		Sys.setCwd( binDirectory + "project" );
		Sys.command( "haxelib", ["run", "hxcpp", "build.xml"] );
	}
		
	
	function isDebugBuild() : Bool
	{
		return flags.indexOf("debug") > -1;
	}
	
	
	
	
	public function run( )
	{
		Sys.command( binDirectory + "project/" + config.project.name + ".exe", [] );
	}

}