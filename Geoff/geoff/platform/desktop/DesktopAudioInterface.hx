package geoff.platform.desktop;
import geoff.audio.AudioChannel;
import geoff.audio.AudioSource;
import geoff.audio.IAudioInterface;
import geoff.platform.desktop.externs.GeoffAudio;
import geoff.utils.Assets;

/**
 * ...
 * @author Simon
 */
class DesktopAudioInterface implements IAudioInterface
{

	public var _internalAudio : cpp.Pointer<GeoffAudio>;
	
	public function new() 
	{
		
	}
	
	public function init() : Void 
	{
		untyped __cpp__("_internalAudio = new GeoffAudio()");
	}
	
	public function destroy() 
	{
		untyped __cpp__("delete _internalAudio");
	}
	
	public function load( file : String ) : AudioSource 
	{
		var source : AudioSource = new AudioSource( file );
		source.assetId = file;
		source.samples = Assets.getBytes( file );
		return source;
	}
	
	public function unload( source : AudioSource ) : Void 
	{
		_internalAudio.get_ref().unload( source );
	}
	
	public function playOneShot( source : AudioSource, volume : Float = 1 ) : AudioChannel
	{
		var channel : AudioChannel = new AudioChannel();
		channel.source = source;
		channel.position = 0;
		channel.size = source.samples.length;
		channel.looping = false;
		channel.volume = volume;
		_internalAudio.get_ref().playOneShot( channel );
		
		return channel;
	}
	
	public function playLooping( source : AudioSource, volume : Float = 1 ) : AudioChannel
	{
		var channel : AudioChannel = new AudioChannel();
		channel.source = source;
		channel.position = 0;
		channel.size = source.samples.length;
		channel.looping = true;
		channel.volume = volume;
		_internalAudio.get_ref().playLooping( channel );
		
		return channel;
	}
	
	public function stop( channel : AudioChannel ) : Void 
	{
		_internalAudio.get_ref().stop( channel );
	}

}