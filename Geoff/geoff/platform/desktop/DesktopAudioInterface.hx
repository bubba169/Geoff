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
	public var _activeChannels : Array<AudioChannel>;
	
	public function new() 
	{
		
	}
	
	public function init() : Void 
	{
		untyped __cpp__("_internalAudio = new GeoffAudio()");
		_activeChannels = [];
	}
	
	public function destroy() 
	{
		untyped __cpp__("delete _internalAudio");
	}
	
	public function load( file : String ) : AudioSource 
	{
		var source : AudioSource = new AudioSource( file, AudioSourceFormat.Ogg );
		source.assetId = file;
		source.rawBytes = Assets.getBytes( file );
				
		_internalAudio.get_ref().load( source );
		
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
		channel.looping = false;
		channel.volume = volume;
		//_internalAudio.get_ref().playOneShot( channel );
		_activeChannels.push( channel );
		
		return channel;
	}
	
	public function playLooping( source : AudioSource, volume : Float = 1 ) : AudioChannel
	{
		var channel : AudioChannel = new AudioChannel();
		channel.source = source;
		channel.position = 0;
		channel.looping = true;
		channel.volume = volume;
		_internalAudio.get_ref().playLooping( channel );
		
		_activeChannels.push( channel );
		
		return channel;
	}
	
	public function stop( channel : AudioChannel ) : Void 
	{
		_internalAudio.get_ref().stop( channel );
	}
	
	public function update( seconds : Float ) : Void 
	{
		_internalAudio.get_ref().update( _activeChannels );
	}

}