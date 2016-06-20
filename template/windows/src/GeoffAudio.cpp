#include <GeoffAudio.h>

namespace geoff
{
		
	GeoffAudio::GeoffAudio( )
	{		
		_callbacks.read_func = geoff_ogg_read;
		_callbacks.seek_func = geoff_ogg_seek;
		_callbacks.close_func = NULL;
		_callbacks.tell_func = geoff_ogg_tell;

		_device = alcOpenDevice(NULL);
		_context = alcCreateContext( _device, NULL );
		alcMakeContextCurrent( _context );
	}

	GeoffAudio::~GeoffAudio( )
	{
	}

	void GeoffAudio::load( geoff::audio::AudioSource source )
	{
		OggVorbis_File file;
		void* dataSource = (void*)&(source);
		int result = ov_open_callbacks( dataSource, &file, NULL, 0, _callbacks );
		
		size_t pcm_length = ov_pcm_total( &file, -1 ) * 4;
		int current_section(0);
		source->samples = haxe::io::Bytes_obj::alloc( pcm_length );
		size_t length = ov_read( &file, (char*)&(source->samples->b[0]), pcm_length, 0, 2, 1, &current_section );

		printf("\nVORBIS INFO. Channels: %i, Rate: %i", file.vi->channels, file.vi->rate );

		// This crashes the app, do we need it?
		//ov_clear( &file );

		printf("\nStarting %i", alGetError() );

		alListener3f( AL_POSITION, 0, 0, 0 );
		alListener3f( AL_VELOCITY, 0, 0, 0 );
		float orientation[6] = {0, 0, -1, 0, 1, 0};
		alListenerfv( AL_ORIENTATION, orientation );

		printf("\nSet Listener properties %i", alGetError() );

		unsigned int al_source;
		alGenSources( 1, &al_source );
		alSourcef( al_source, AL_PITCH, 1 );
		alSourcef( al_source, AL_GAIN, 0 );
		alSource3f( al_source, AL_POSITION, 0, 0, 0 );
		alSource3f( al_source, AL_VELOCITY, 0, 0, 0 );
		alSourcei( al_source, AL_LOOPING, AL_FALSE );

		printf("\nSet source properties %i", alGetError() );

		unsigned int buffer;
		alGenBuffers( 1, &buffer );

		alBufferData( buffer, AL_FORMAT_STEREO16, (void*)&(source->samples->b[0]), pcm_length, 44100 );
		alSourceQueueBuffers( al_source, 1, &buffer );

		printf("\nBuffered %i", alGetError() );
		alSourcePlay( al_source );

		printf("\nPlayed %i", alGetError() );

		printf( "\nLoaded OGG %i, length %i", result, pcm_length );
	}

	void GeoffAudio::unload( geoff::audio::AudioSource source )
	{
	}

	void GeoffAudio::playOneShot( geoff::audio::AudioChannel channel )
	{

	}

	void GeoffAudio::playLooping( geoff::audio::AudioChannel channel )
	{

	}

	void GeoffAudio::stop( geoff::audio::AudioChannel channel )
	{

	}

	void GeoffAudio::update( float seconds )
	{

	}
	
};

/**
 *	Global callbacks
 **/

size_t geoff_ogg_read ( void* destination, size_t size, size_t nmemb, void* datasource )
{

	printf( "\nReading %i, %i", size, nmemb );

	geoff::audio::AudioSource source = *((geoff::audio::AudioSource*)(datasource));

	size_t len = size * nmemb;
	size_t pos = source->position;
	if ( pos + len > source->rawBytes->length )
	{
		if ( pos == source->rawBytes->length )
		{
			// End of file
			return 0;
		}
		else
		{
			len = source->rawBytes->length - pos;
			source->position = source->rawBytes->length;
		}
	}
	else
	{
		source->position += len;
	}

	memcpy( destination, (void*)&(source->rawBytes->b[pos]), len );
	return len;
}

int geoff_ogg_seek ( void* datasource, ogg_int64_t offset, int whence )
{


	geoff::audio::AudioSource source = *((geoff::audio::AudioSource*)(datasource));
	printf( "\nSeeking to %i from %i current %i", (int)offset, whence, source->position );
	
	if ( whence == SEEK_SET ) 
	{
		printf( "\nSeeking from the top" );
		source->position = offset;
	}
	else if ( whence == SEEK_CUR )
	{
		printf( "\nSeeking from current" );
		source->position += offset;
	}
	else if ( whence == SEEK_END )
	{
		printf( "\nSeeking from the end" );
		source->position = source->rawBytes->length - offset;
	}

	printf( "\nSuccess in seek to %i", source->position );

	return 0;
}

long geoff_ogg_tell ( void* datasource )
{
	geoff::audio::AudioSource source = *((geoff::audio::AudioSource*)(datasource));

	printf( "\nTell: ", source->position );

	return source->position;
}