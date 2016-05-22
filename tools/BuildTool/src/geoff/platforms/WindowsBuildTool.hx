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
		
		writeBuildXml( binDirectory );
		
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
		buildHXML += "-main geoff.App\n";
		buildHXML += "-D no-compilation\n";
		
		if ( isDebugBuild() ) {
			buildHXML += "-debug\n";
		}
		
		buildHXML += "-D windows\n";
		//buildHXML += "-D static_link\n";
		buildHXML += "-D HX_WINDOWS\n";
		buildHXML += "-D ABI=-MD\n";
		buildHXML += "-dce no\n";
		
		File.saveContent(  projectDirectory + "build.hxml", buildHXML );
		
		Sys.setCwd( projectDirectory );
		Sys.command( "haxe", [ "build.hxml"] );
		
	}
	
	
	function writeBuildXml( dir : String ) : Void 
	{
		var buildXml : String = "";
		buildXml += "<xml>\n";
		buildXml += "	<include name='Build.xml'/>\n";
		buildXml += "	<flag value='-I../project/GeoffApp/include'/>\n";
		buildXml += "</xml>";
		
		File.saveContent( dir + "build/build_master.xml", buildXml );
	}
	
	function compileCPP( dir : String ) : Void 
	{
		Sys.setCwd( dir + "build" );
		Sys.command( "haxelib", ["run", "hxcpp", "build_master.xml", "haxe"] );
	}
	
	
	function isDebugBuild() : Bool
	{
		return flags.indexOf("debug") > -1;
	}
}