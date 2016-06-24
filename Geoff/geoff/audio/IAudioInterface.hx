package geoff.audio;

/**
 * @author Simon
 */
interface IAudioInterface 
{
	
	var mixer( default, null ) : AudioMixer;
	
	function loadAsset( assetId : String, audioId : String ) : Void;
	//function loadOgg( source : AudioSource ) : Void;	
	function init() : Void;
	function destroy() : Void;
	function update() : Void;
	function bufferData( ) : Void;
	
	function playOneShot( id : String, volume : Float = 1 ) : AudioChannel;
	function playLooping( id : String, volume : Float = 1 ) : AudioChannel;
}