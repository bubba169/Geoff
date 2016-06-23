#include <GeoffAudio.h>

namespace geoff
{
		
	GeoffAudio::GeoffAudio( )
	{		
		// Set up ogg callbacks for reading ogg files
		_callbacks.read_func = geoff_ogg_read;
		_callbacks.seek_func = geoff_ogg_seek;
		_callbacks.close_func = NULL;
		_callbacks.tell_func = geoff_ogg_tell;

		// Set up default device
		_device = alcOpenDevice(NULL);
		_context = alcCreateContext( _device, NULL );
		alcMakeContextCurrent( _context );

		// Set up a listener
		alListener3f( AL_POSITION, 0, 0, 0 );
		alListener3f( AL_VELOCITY, 0, 0, 0 );
		float orientation[6] = {0, 0, -1, 0, 1, 0};
		alListenerfv( AL_ORIENTATION, orientation );

		// Set up a single source that will be fed with data
		alGenSources( 1, &_source );
		alSourcef( _source, AL_PITCH, 1 );
		alSourcef( _source, AL_GAIN, 1 );
		alSource3f( _source, AL_POSITION, 0, 0, 0 );
		alSource3f( _source, AL_VELOCITY, 0, 0, 0 );
		alSourcei( _source, AL_LOOPING, AL_FALSE );

		// Set up the buffers
		alGenBuffers( NUM_BUFFERS, _bufferIds );
		memset( &(_bufferData[0]), 0, BUFFER_SIZE );
		for ( int i = 0; i < NUM_BUFFERS; ++i ) 
		{
			alBufferData( _bufferIds[i], AL_FORMAT_STEREO16, (void*)_bufferData, BUFFER_SIZE, 44100 );
			alSourceQueueBuffers( _source, 1, &(_bufferIds[i]) );
		}

		alSourcePlay( _source );

	}



	GeoffAudio::~GeoffAudio( )
	{

		alDeleteBuffers( NUM_BUFFERS, _bufferIds );
		alDeleteSources( 1, &_source );

	}



	void GeoffAudio::load( geoff::audio::AudioSource source )
	{

		// Load the file from memory
		OggVorbis_File file;
		void* dataSource = (void*)&(source);
		int result = ov_open_callbacks( dataSource, &file, NULL, 0, _callbacks );

		// Get info from file
		source->rate = file.vi->rate;
		source->channels = file.vi->channels;

		// Setup the buffer
		size_t pcm_length = ov_pcm_total( &file, -1 ) * 2 * source->channels;
		source->samples = haxe::io::Bytes_obj::alloc( pcm_length );
		
		// Decompress into the buffer
		bool eof = false;
		int filePos = 0;
		int current_section(0);
		while ( !eof ) 
		{
			int readLength = ov_read( &file, (char*)&(source->samples->b[filePos]), pcm_length, 0, 2, 1, &current_section );
			filePos += readLength;
			if ( readLength == 0 ) eof = true;
		} 

		return;

		// This crashes the app, do we need it?
		/*ov_clear( &file );

		printf("\nStarting %i", alGetError() );

		alListener3f( AL_POSITION, 0, 0, 0 );
		alListener3f( AL_VELOCITY, 0, 0, 0 );
		float orientation[6] = {0, 0, -1, 0, 1, 0};
		alListenerfv( AL_ORIENTATION, orientation );

		printf("\nSet Listener properties %i", alGetError() );

		unsigned int al_source;
		alGenSources( 1, &al_source );
		alSourcef( al_source, AL_PITCH, 1 );
		alSourcef( al_source, AL_GAIN, 1 );
		alSource3f( al_source, AL_POSITION, 0, 0, 0 );
		alSource3f( al_source, AL_VELOCITY, 0, 0, 0 );
		alSourcei( al_source, AL_LOOPING, AL_TRUE );

		printf("\nSet source properties %i", alGetError() );

		unsigned int buffer;
		alGenBuffers( 1, &buffer );

		int format = ( source->channels == 2 ) ? AL_FORMAT_STEREO16 : AL_FORMAT_MONO16;
		alBufferData( buffer, format, (void*)&(source->samples->b[0]), pcm_length, source->rate );

		alSourceQueueBuffers( al_source, 1, &buffer );

		printf("\nBuffered %i", alGetError() );
		alSourcePlay( al_source );

		printf("\nPlayed %i", alGetError() );

		printf( "\nLoaded OGG %i, length %i", result, pcm_length );*/

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

	void GeoffAudio::update( Array<geoff::audio::AudioChannel> channels )
	{

		int processed = 0;
		alGetSourcei( _source, AL_BUFFERS_PROCESSED, &processed );

		printf( "\nProcessed %i", processed );

		if ( processed > 0 )
		{

			unsigned int buffer;
			alSourceUnqueueBuffers( _source, 1, &buffer );

			printf( "\nQueueing buffer %u", buffer );

			memset( &(_bufferData[0]), 0, BUFFER_SIZE );

			for ( int c = 0; c < channels->length; ++c )
			{
				for ( int i = 0; i < BUFFER_SIZE / 2; ++i )
				{
					if ( channels[c]->looping || channels[c]->position < channels[c]->source->samples->length ) 
					{

						// Sort out looping around
						if ( channels[c]->position >= channels[c]->source->samples->length ) channels[c]->position = 0;

						if ( !channels[c]->paused )
						{
							// Read some of the challen data into the buffer
							int16_t* dataPtr = (int16_t*)&(channels[c]->source->samples->b[ channels[c]->position ]);
							int16_t* bufferPtr = (int16_t*)&(_bufferData[i*2]);
							int result = ((int)(*bufferPtr)) + (*dataPtr);
							if ( result > 32767 ) result = 32767;
							if ( result < -32767 ) result = -32767;
							*bufferPtr = (int16_t)result;
							channels[c]->position += 2;
						}
					}
					else
					{
						channels[c]->complete = true;
					}
				}
			}
			
			//int format = ( source->channels == 2 ) ? AL_FORMAT_STEREO16 : AL_FORMAT_MONO16;
			alBufferData( buffer, AL_FORMAT_STEREO16, (void*)_bufferData, BUFFER_SIZE, 44100 );
			alSourceQueueBuffers( _source, 1, &buffer );

			int state;
			alGetSourcei(_source, AL_SOURCE_STATE, &state);
            if(state != AL_PLAYING)
                alSourcePlay(_source);

			printf("\nQueued again %i", alGetError() );

		}
	}
	
};

/**
 *	Global callbacks
 **/

size_t geoff_ogg_read ( void* destination, size_t size, size_t nmemb, void* datasource )
{


	geoff::audio::AudioSource source = *((geoff::audio::AudioSource*)(datasource));
	printf( "\nReading %i, %i from %i", size, nmemb, source->position );

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