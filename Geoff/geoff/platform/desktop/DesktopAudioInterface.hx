package geoff.platform.desktop;
import geoff.audio.AudioPlayer;
import geoff.audio.AudioSource;
import geoff.audio.IAudioInterface;
import geoff.platform.desktop.externs.GeoffAudio;

/**
 * ...
 * @author Simon
 */
class DesktopAudioInterface implements IAudioInterface
{

	public var _internalAudio : cpp.Pointer<GeoffAudio>;
	public var player( default, null ) : AudioPlayer;
	
	public function new() 
	{
		
	}
	
	public function init() : Void 
	{
		untyped __cpp__("_internalAudio = new GeoffAudio()");
		player = new AudioPlayer();
	}
	
	public function destroy() 
	{
		untyped __cpp__("delete _internalAudio");
	}
	
	public function loadOgg( source : AudioSource ) : Void 
	{
		_internalAudio.get_ref().loadOgg( source );
	}
		
	public function update() : Void 
	{
		_internalAudio.get_ref().update( );
	}
	
	public function bufferData() : Void
	{
		_internalAudio.get_ref().bufferData( player.getBufferData() );
	}

}