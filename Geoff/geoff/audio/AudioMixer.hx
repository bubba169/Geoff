package geoff.audio;
import haxe.io.Bytes;

/**
 * ...
 * @author Simon
 */

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
		_bytesCache = Bytes.alloc( 8192 );
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

		var dataVal : Int = 0;
		var bufferVal : Int = 0;
		var result : Int = 0;

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

						dataVal = channel.source.samples.getUInt16( channel.position );
						bufferVal = _bytesCache.getUInt16( i * 2 );

						// Convert UInt to Int16
						if ( dataVal > 32767 ) dataVal = -65535 + dataVal;
						if ( bufferVal > 32767 ) bufferVal = -65535 + bufferVal;

						// Adjust volume
						dataVal = Std.int( dataVal * channel.volume );

						// Mix it in
						result = dataVal + bufferVal;
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
