package geoff.platform.audio.alcpp;
import geoff.audio.AudioInterface;
import geoff.audio.AudioMixer;

/**
 * ...
 * @author Simon
 */
class ALCPPAudioInterface extends AudioInterface
{

	public var _internalAudio : cpp.Pointer<NativeALCPP>;
	
	public function new() 
	{
		
	}
	
	override public function init() : Void 
	{
		untyped __cpp__("_internalAudio = new GeoffAudio()");
		mixer = new AudioMixer();
	}
	
	override public function destroy() 
	{
		untyped __cpp__("delete _internalAudio");
	}
		
	override public function update( seconds : Float ) : Void 
	{
		_internalAudio.get_ref().update( );
	}
	
	override public function bufferData() : Void
	{
		_internalAudio.get_ref().bufferData( mixer.getBufferData() );
	}

}