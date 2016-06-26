package geoff.platform;
import geoff.event.EventManager;
import geoff.platform.android.GeoffActivity;
import geoff.platform.assets.AndroidAssetLoader;
import geoff.platform.audio.AndroidAudioInterface;
import geoff.platform.renderer.AndroidRenderer;
import java.lang.System;


/**
 * This is a static class that will give access to all of the platform dependant features
 * @author Simon
 */
class AndroidPlatform
{
	public var name : String = "Android";
	
	public var assetLoader : AndroidAssetLoader;
	public var renderer : AndroidRenderer;
	public var audio : AndroidAudioInterface;
	public var nativeActivity : GeoffActivity;
	
	public function new()
	{
		renderer = new AndroidRenderer();
		audio = new AndroidAudioInterface();
		assetLoader = new AndroidAssetLoader();
	}
	
	public function setActivity( activity : GeoffActivity ) : Void
	{
		this.nativeActivity = activity;
	}
	
	public function getTime() : Float
	{
		return cast( System.currentTimeMillis(), Float ) / 1000.0;
	}
	
	public function showKeyboard() : Void
	{
		nativeActivity.showKeyboard();
	}
	
	public function hideKeyboard() : Void
	{
		nativeActivity.hideKeyboard();
	}
	
	public function exit() : Void
	{
		nativeActivity.finish();
		System.exit(0);
	}
}