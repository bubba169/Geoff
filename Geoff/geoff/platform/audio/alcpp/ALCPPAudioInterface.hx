package geoff.platform.audio.alcpp;
import geoff.assets.Assets;
import geoff.audio.AudioChannel;
import geoff.audio.AudioMixer;
import geoff.audio.AudioSource;
import geoff.audio.IAudioInterface;

/**
 * ...
 * @author Simon
 */
class ALCPPAudioInterface implements IAudioInterface
{

	public var _internalAudio : cpp.Pointer<NativeALCPP>;
	public var mixer( default, null ) : AudioMixer;
	
	public function new() 
	{
		
	}
	
	public function init() : Void 
	{
		untyped __cpp__("_internalAudio = new GeoffAudio()");
		mixer = new AudioMixer();
	}
	
	public function destroy() 
	{
		untyped __cpp__("delete _internalAudio");
	}
		
	public function update() : Void 
	{
		_internalAudio.get_ref().update( );
	}
	
	public function bufferData() : Void
	{
		_internalAudio.get_ref().bufferData( mixer.getBufferData() );
	}
	
	public function loadAsset( id : String, file : String ) : Void
	{
		trace("LoadAudioAsset", id, file );
		
		// Will always be OGG at the moment
		var source : AudioSource = new AudioSource( file, AudioSourceFormat.Ogg );
		source.id = id;
		source.assetId = file;
		source.rawBytes = Assets.getBytes( file );
			
		App.current.platform.assetLoader.loadAudio( source );
		
		mixer.addSource( source );
		
	}
	
	
	public function playOneShot( id : String, volume : Float = 1 ) : AudioChannel 
	{
		return mixer.playOneShot( id, volume );
	}
	
	public function playLooping( id : String, volume : Float = 1 ) : AudioChannel 
	{
		return mixer.playLooping( id, volume );
	}

}