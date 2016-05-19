package geoff.platforms;
import geoff.helpers.TemplateHelper;
import sys.FileSystem;
import sys.io.File;
import geoff.helpers.DirectoryHelper;

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
		
		if ( FileSystem.exists( projectDirectory + "build.hxml" ) ) FileSystem.deleteFile( projectDirectory + "build.hxml" );
		
		// clean any old builds
		if ( FileSystem.exists( binDirectory ) ) 
		{
			trace("Cleaning " + binDirectory );
			DirectoryHelper.removeDirectory( binDirectory );
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
		buildHXML += "-java-lib " + config.global.android.sdkpath + "platforms/android-" + config.project.android.version + "/android.jar\n";
		buildHXML += "-D java-android\n";
		buildHXML += "-main geoff.App\n";
		
		if ( isDebugBuild() ) {
			buildHXML += "-debug\n";
		}
		
		buildHXML += "-D android\n";
		
		File.saveContent(  projectDirectory + "build.hxml", buildHXML );
		
		Sys.setCwd( projectDirectory );
		Sys.command( "haxe", [ "build.hxml"] );
		
	}
	
	
	function copyJar( binDirectory : String )
	{
		var jarName : String = "App";
		if ( jarName.indexOf(".") > -1 ) 
		{
			jarName = jarName.substr( jarName.lastIndexOf(".") + 1 );
		}
		if ( isDebugBuild() ) jarName += "-Debug";
		jarName += ".jar";
		FileSystem.createDirectory( binDirectory + "project/libs" );
		File.copy( binDirectory + "build/" + jarName, binDirectory + "/project/libs/" + jarName );
	}
	
	
	function compileAndroid( )
	{
		var antDirectory = projectDirectory + "bin/android/project";
		trace("Running ant in " + antDirectory );
		
		Sys.setCwd( antDirectory );
		if ( isDebugBuild() )
		{
			Sys.command( config.global.android.antpath + "/bin/ant", [ "debug", "install" ] );
		}
		else
		{
			Sys.command( config.global.android.antpath + "/bin/ant", [ "release", "install" ] );
		}
		
	}
	
	function isDebugBuild() : Bool
	{
		return flags.indexOf("debug") > -1;
	}
}