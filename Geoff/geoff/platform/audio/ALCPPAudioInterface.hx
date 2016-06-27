package geoff.platform.audio;
import geoff.audio.AudioInterface;
import geoff.audio.AudioMixer;
import haxe.io.Bytes;

/**
 * ...
 * @author Simon
 */

@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/../template/common/cpp/al_audio/include'/></files>")
@:structAccess
@:unreflective
@:include("GeoffAudio.h")
@:native("geoff::GeoffAudio")
extern class NativeALCPP
{
	public function update( ) : Void;
	public function bufferData( data : Bytes ) : Void;
}

/**
 * 
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