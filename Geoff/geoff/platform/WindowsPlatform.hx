package geoff.platform;
import geoff.event.EventManager;
import geoff.platform.assets.WindowsAssetLoader;
import geoff.platform.audio.ALCPPAudioInterface;
import geoff.platform.renderer.GLCPPRenderer;
import haxe.Timer;
import sys.FileSystem;
import sys.io.File;

/**
 * ...
 * @author Simon
 */

@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/../template/windows/include'/></files>")
 
class WindowsPlatform
{

	public var name : String = "Windows";
	
	public var assetLoader : WindowsAssetLoader;
	public var renderer : GLCPPRenderer;
	public var audio : ALCPPAudioInterface;
	public var shouldExit : Bool = false;
	public var storageDirectory : String;
	
	public function new()
	{
		renderer = new GLCPPRenderer();
		audio = new ALCPPAudioInterface();
		assetLoader = new WindowsAssetLoader();
		
		storageDirectory = "C:" + Sys.getEnv("HOMEPATH") + "/AppData/Roaming/" + Project.company + "/" + Project.name + "/";
		if ( !FileSystem.isDirectory( storageDirectory ) ) FileSystem.createDirectory( storageDirectory );		
	}
	
	public function getTime() : Float
	{
		return Timer.stamp();
	}
	
	public function exit() : Void 
	{
		shouldExit = true;
	}
	
}