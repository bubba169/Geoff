package geoff.audio;
import haxe.io.Bytes;

/**
 * ...
 * @author Simon
 */

#if geoff_cpp
	typedef AudioInt16 = cpp.Int16;
#elseif geoff_java
	typedef AudioInt16 = java.StdTypes.Int16;
#end
 
class AudioMixer
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
		
	public function addSource( source : AudioSource ) : Void 
	{
		_sources.set( source.id, source );
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
		
		trace("Buffering data");
		
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
						
						var dataVal : AudioInt16 = channel.source.samples.getUInt16( channel.position );
						var bufferVal : AudioInt16 = _bytesCache.getUInt16( i * 2 );
						
						var result : Int = cast( dataVal, Int ) + cast( bufferVal, Int );
						if ( result > 32767 ) result = 32767;
						if ( result < -32767 ) result = -32767;
						_bytesCache.setUInt16( i * 2, cast result );
						
						
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
	
	public function update( seconds : Float ) : Void 
	{
		var i : Int = _activeChannels.length - 1;
		while ( i >= 0 )
		{
			if ( _activeChannels[i].complete ) _activeChannels.remove( _activeChannels[i] );
			i--;
		}
	}

	
}