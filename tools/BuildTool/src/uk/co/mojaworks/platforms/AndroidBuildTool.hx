package uk.co.mojaworks.platforms;
import sys.FileSystem;
import sys.io.File;
import uk.co.mojaworks.helpers.DirectoryHelper;

/**
 * ...
 * @author Simon
 */
class AndroidBuildTool
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
	
	
	public function incrementVersionCode() : String
	{
		var versionFile = projectDirectory + ".buildversion";
		var version = 0;
		if ( FileSystem.exists( versionFile ) )
			version = Std.parseInt( File.getContent( versionFile ) );
			
		version++;
		File.saveContent( versionFile, Std.string(version) );
		return Std.string(version);
	}
	
	
	public function build( ) : Void
	{
		var binDirectory = projectDirectory + "bin/android/";
		var versionCode = incrementVersionCode();
		var templateConstants = 
		[
			"Package" => config.project.project.packagename,
			"Main" => config.project.project.main,
			"VersionCode" => versionCode,
			"Version" => config.project.project.version,
			"ProjectName" => config.project.project.name,
			"AndroidSDKPath" => StringTools.replace(config.global.android.sdkpath, "\\", "\\\\" ),
			"AndroidSDKVersion" => config.project.android.version
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
		DirectoryHelper.copyDirectory( config.geoffpath + "template/android/", binDirectory + "project/" );
		DirectoryHelper.copyDirectory( config.geoffpath + "template/base/", binDirectory + "haxe/" );
		
		trace("Processing templates");
		
		//Fill in values
		processTemplates( binDirectory + "project/", templateConstants );
		processTemplates( binDirectory + "haxe/", templateConstants );
		
		//Compile project to java
		compileHaxe( binDirectory + "build/" );
		
		//Copy lib to android template
		copyJar( binDirectory );
		
		//Compile with ant
		compileAndroid();
		
	}
	
	function processTemplates( dir : String, constants : Map<String,String> ) 
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
	
	
	function compileHaxe( to : String )
	{
		
		var buildHXML = "";
		var srcArray : Array<String> = config.project.project.src;
		for ( dir in srcArray ) {
			buildHXML += "-cp " + dir + "\n";
		}
		buildHXML += "-cp bin/android/haxe\n";
		var libArray : Array<String> = config.project.project.haxelib;
		for ( lib in libArray ) {
			buildHXML += "-lib " + lib + "\n";
		}
		buildHXML += "-java bin/android/build\n";
		buildHXML += "-java-lib " + config.global.android.sdkpath + "platforms/android-" + config.project.android.version + "/android.jar\n";
		buildHXML += "-D java-android\n";
		buildHXML += "-main geoff.Boot\n";
		
		if ( isDebugBuild() ) {
			buildHXML += "-debug\n";
		}
		
		File.saveContent(  projectDirectory + "build.hxml", buildHXML );
		
		Sys.setCwd( projectDirectory );
		Sys.command( "haxe", [ "build.hxml"] );
		
	}
	
	
	function copyJar( binDirectory : String )
	{
		var jarName : String = "Boot";
		//if ( jarName.indexOf(".") > -1 ) 
		//{
		//	jarName = jarName.substr( jarName.lastIndexOf(".") + 1 );
		//}
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