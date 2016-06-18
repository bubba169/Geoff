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
class IOSBuildTool
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
		this.binDirectory = projectDirectory + "bin/ios/";
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

		buildHXML += "-main " + config.project.main + "\n";

		if ( isDebugBuild() ) {
			buildHXML += "-debug\n";
		}

		buildHXML += "-D ios\n";
		buildHXML += "-D static_link\n";
		buildHXML += "-D IPHONE_VER=9.2\n";
		buildHXML += "-D geoff_cpp\n";
		buildHXML += "-dce no\n";

		var defineArray : Array<String> = config.project.defines;
		for ( define in defineArray )
		{
			buildHXML += "-D " + define + "\n";
		}

		buildHXML += "--each\n";
		buildHXML += "-cpp bin/ios/build/arm64\n";
		buildHXML += "-D HXCPP_ARM64\n";

		buildHXML += "--next\n";
		buildHXML += "-cpp bin/ios/build/armv7\n";
		buildHXML += "-D HXCPP_ARMV7\n";

		buildHXML += "--next\n";
		buildHXML += "-cpp bin/ios/build/sim\n";
		buildHXML += "-D simulator\n";

		File.saveContent(  projectDirectory + "build.hxml", buildHXML );

	}


	public function build( ) : Void
	{
		var templateConstants =
		[
			"Main" => config.project.main,
			"HxcppIncludePath" => DirectoryHelper.getHaxelibDir("hxcpp") + "/include",
			"Version" => config.project.version,
			"ProjectName" => config.project.name,
			"Package" => config.project.packagename,
			"Orientation" => "sensor"
		];

		if ( flags.indexOf( "clean" ) > -1 ) {
			clean();
		}

		// Make the directory
		FileSystem.createDirectory( binDirectory + "project" );

		//Copy template files
		DirectoryHelper.copyDirectory( config.geoffpath + "template/ios/", binDirectory + "project/" );

		trace("Processing templates");

		//Fill in values
		TemplateHelper.processTemplates( binDirectory + "project/", templateConstants );

		//Compile project to java
		if ( compileHaxe( ) != 0 )
		{
			trace("Haxe Compilation could not be completed!");
			return;
		}

		copyLibs( );
		//copyAssets( );

		//compileCPP( );

	}


	function compileHaxe( ) : Int
	{
		Sys.setCwd( projectDirectory );
		return Sys.command( "haxe", [ "build.hxml"] );
	}

	function copyAssets( )
	{
		trace("Looking for assets in " + config.project.haxelib );

		var libArray : Array<String> = config.project.haxelib;
		for ( lib in libArray ) {
			var libdir_assets = DirectoryHelper.getHaxelibDir(lib) + "assets";

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
		FileSystem.createDirectory( binDirectory + "project/lib" );

		var libName : String = config.project.main;
		if ( libName.indexOf(".") > -1 )
		{
			libName = libName.substr( libName.lastIndexOf(".") + 1 );
		}

		var filename : String;

		filename = "lib" + libName;
		filename += ".iphoneos-v7";
		if ( isDebugBuild() ) filename += "-debug";
		filename += ".a";
		File.copy( binDirectory + "build/armv7/" + filename, binDirectory + "/project/lib/libApp-v7.a" );

		filename = "lib" + libName;
		filename += ".iphoneos-64";
		if ( isDebugBuild() ) filename += "-debug";
		filename += ".a";
		File.copy( binDirectory + "build/arm64/" + filename, binDirectory + "/project/lib/libApp-64.a" );

		filename = "lib" + libName;
		filename += ".iphonesim";
		if ( isDebugBuild() ) filename += "-debug";
		filename += ".a";
		File.copy( binDirectory + "build/sim/" + filename, binDirectory + "/project/lib/libApp-sim.a" );

		var hxcppDir : String = DirectoryHelper.getHaxelibDir("hxcpp");
		DirectoryHelper.copyDirectory( hxcppDir + "lib/iPhone/", binDirectory + "project/lib/" );

		DirectoryHelper.copyDirectory( binDirectory + "build/armv7/include/", binDirectory + "project/include/" );
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
