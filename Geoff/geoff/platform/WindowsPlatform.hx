package geoff.platform;
import geoff.event.EventManager;
import geoff.platform.assets.WindowsAssetLoader;
import geoff.platform.audio.alcpp.ALCPPAudioInterface;
import geoff.platform.renderer.glcpp.GLCPPRenderer;
import haxe.Timer;

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
	
	public function new()
	{
		renderer = new GLCPPRenderer();
		audio = new ALCPPAudioInterface();
		assetLoader = new WindowsAssetLoader();
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