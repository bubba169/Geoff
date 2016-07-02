package geoff.platform;
import geoff.event.EventManager;
import geoff.platform.renderer.GLCPPRenderer;
import geoff.platform.audio.ALCPPAudioInterface;
import geoff.platform.assets.IOSAssetLoader;
import haxe.Timer;

/**
 * This is a static class that will give access to all of the platform dependant features
 * @author Simon
 */

@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/../template/ios/include'/></files>")
class IOSPlatform
{
	public var name : String = "iOS";

	public var renderer : GLCPPRenderer;
	public var audio : ALCPPAudioInterface;
	public var assetLoader : IOSAssetLoader;

	public function new()
	{
		renderer = new GLCPPRenderer();
		audio = new ALCPPAudioInterface();
	}

	public function getTime() : Float
	{
		return Timer.stamp();
	}

	public function showKeyboard() : Void
	{
		//nativeActivity.showKeyboard();
	}

	public function hideKeyboard() : Void
	{
		//nativeActivity.hideKeyboard();
	}

	public function exit() : Void
	{
		//nativeActivity.finish();
		//System.exit(0);
	}
}
