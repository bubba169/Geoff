package;
import geoff.audio.AudioMixer;
import geoff.audio.IAudioInterface;

/**
 * ...
 * @author Simon
 */
class AndroidAudioInterface implements IAudioInterface
{

	public function new() 
	{
		
	}
	
	
	/* INTERFACE geoff.audio.IAudioInterface */
	
	public var mixer(default, null):AudioMixer;
	
	public function loadAsset(assetId:String, audioId:String):Void 
	{
		
	}
	
	public function init():Void 
	{
		
	}
	
	public function destroy():Void 
	{
		
	}
	
	public function update():Void 
	{
		
	}
	
	public function bufferData():Void 
	{
		
	}
	
}