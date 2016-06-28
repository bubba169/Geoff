package geoff.audio;
import geoff.assets.Assets;
import geoff.audio.AudioSource.AudioSourceFormat;

/**
 * @author Simon
 */
class AudioInterface 
{
	
	var mixer( default, null ) : AudioMixer;
		
	function init() : Void
	{
		// Platform specific
		mixer = new AudioMixer();
	}
	
	function destroy() : Void
	{
		// Platform specific
	}
	
	function update( seconds : Float ) : Void
	{
		mixer.update( seconds );
		// Platform specific
	}
	
	function bufferData( ) : Void
	{
		// Platform specific
	}
	
	public function loadAsset( id : String, path : String):Void 
	{
		// Will always be OGG at the moment
		var source : AudioSource = new AudioSource( path, AudioSourceFormat.Ogg );
		source.id = id;
		source.assetId = path;
		source.rawBytes = Assets.getBytes( path );
			
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
	
	public function stopAllWithId( id : String ) : Void
	{
		mixer.stopAllWithId( id );
	}
	
	public function stopChannel( channel : AudioChannel ) : Void
	{
		mixer.stopChannel( channel );
	}
}