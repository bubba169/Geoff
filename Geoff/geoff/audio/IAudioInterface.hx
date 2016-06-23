package geoff.audio;

/**
 * @author Simon
 */
interface IAudioInterface 
{
	
	var player( default, null ) : AudioPlayer;
	
	function init() : Void;
	function destroy() : Void;
	function update() : Void;
	function loadOgg( source : AudioSource ) : Void;
	function bufferData( ) : Void;
}