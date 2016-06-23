package geoff.audio;
import geoff.audio.AudioSource.AudioSourceFormat;
import geoff.utils.Assets;
import geoff.utils.MathUtils;
import haxe.io.Bytes;

/**
 * ...
 * @author Simon
 */
class AudioPlayer
{
	
	public var _masterVolume : Float;
	public var _activeChannels : Array<AudioChannel>;
	public var _sources : Map<String,AudioSource>;
	
	public var _bytesCache : Bytes;
	
	public function new() 
	{
		_activeChannels = [];
		_sources = new Map<String, AudioSource>();
		
		// This may change in future
		_bytesCache = Bytes.alloc( 4096 );
	}
		
	public function loadAsset( id : String, file : String ) : AudioSource
	{
		trace("LoadAudioAsset", id, file );
		
		var source : AudioSource = new AudioSource( file, AudioSourceFormat.Ogg );
		source.id = id;
		source.assetId = file;
		source.rawBytes = Assets.getBytes( file );
			
		// Will always be OGG at the moment
		if ( source.originalFormat == AudioSourceFormat.Ogg )
		{
			App.current.platform.audio.loadOgg( source );
		}
		else if ( source.originalFormat == AudioSourceFormat.Wav )
		{
			// TODO: Just copy the bytes minus the header
		}
		
		_sources.set( id, source );
		return source;
	}
	
	public function unload( id : String ) : Void 
	{
		_sources.remove( id );
	}
	
	public function playOneShot( id : String, volume : Float = 1 ) : AudioChannel
	{
		var channel : AudioChannel = new AudioChannel();
		channel.source = _sources.get(id);
		channel.position = 0;
		channel.looping = false;
		channel.volume = volume;
		_activeChannels.push( channel );
		
		return channel;
	}
	
	public function playLooping( id : String, volume : Float = 1 ) : AudioChannel
	{
		var channel : AudioChannel = new AudioChannel();
		channel.source = _sources.get(id);
		channel.position = 0;
		channel.looping = true;
		channel.volume = volume;
		_activeChannels.push( channel );
		
		return channel;
	}
	
	public function stopChannel( channel : AudioChannel ) : Void 
	{
		_activeChannels.remove( channel );
	}
	
	public function stopAllWithId( id : String ) : Void 
	{
		// Work from the end to avoid missing any after removing
		var i : Int = _activeChannels.length;
		while ( i >= 0 )
		{
			if ( _activeChannels[i].source.id == id ) _activeChannels.remove( _activeChannels[i] );
			i--;
		}
	}
	
	public function getBufferData( ) : Bytes
	{
		// Provide [Size] of mixed sound data in a byte array
		_bytesCache.fill( 0, _bytesCache.length, 0 );
		
		var workingValue : Int;
		
		for ( channel in _activeChannels )
		{
			for ( i in 0...Math.floor(_bytesCache.length/2) )
			{
				if ( channel.looping && channel.complete ) {
					channel.position = 0;
					channel.complete = false;
				}
				
				if ( channel.position < channel.source.samples.length )
				{
					if ( !channel.paused )
					{
						#if geoff_cpp
						untyped __cpp__("int16_t* dataPtr = (int16_t*)&(channel->source->samples->b[ channel->position ])");
						untyped __cpp__("int16_t* bufferPtr = (int16_t*)&(_bytesCache->b[i*2])");
						untyped __cpp__("int result = ((int)(*bufferPtr)) + (*dataPtr)");
						untyped __cpp__("if ( result > 32767 ) result = 32767");
						untyped __cpp__("if ( result < -32767 ) result = -32767");
						untyped __cpp__("*bufferPtr = (int16_t)result");
						#end
						
						channel.position += 2;
					}
				}
				else
				{
					channel.complete = true;
				}
				
			}
		}
		
		
		//trace("Raw values", _bytesCache.getUInt16( 0 ), _bytesCache.getUInt16( 2 ), _bytesCache.getUInt16( 4 ), _bytesCache.getUInt16( 6 ) );
		
		return _bytesCache;
		
	}

	
}