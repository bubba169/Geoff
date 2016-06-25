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
		unsigned char bufferData[BUFFER_SIZE];
		memset( bufferData, 0, BUFFER_SIZE );
		for ( int i = 0; i < NUM_BUFFERS; ++i ) 
		{
			alBufferData( _bufferIds[i], AL_FORMAT_STEREO16, (void*)bufferData, BUFFER_SIZE, 44100 );
			alSourceQueueBuffers( _source, 1, &(_bufferIds[i]) );
		}

		alSourcePlay( _source );

	}



	GeoffAudio::~GeoffAudio( )
	{

		alDeleteBuffers( NUM_BUFFERS, _bufferIds );
		alDeleteSources( 1, &_source );

	}

	void GeoffAudio::update( )
	{

		int processed = 0;
		alGetSourcei( _source, AL_BUFFERS_PROCESSED, &processed );

		if ( processed > 0 )
		{
			geoff::App_obj::current->eventManager->sendEvent( ::String("AudioBufferEmpty") );
		}

	}

	void GeoffAudio::bufferData( haxe::io::Bytes bufferData )
	{
		unsigned int buffer;
		alSourceUnqueueBuffers( _source, 1, &buffer );

		alBufferData( buffer, AL_FORMAT_STEREO16, (void*)&(bufferData->b[0]), BUFFER_SIZE, 44100 );
		alSourceQueueBuffers( _source, 1, &buffer );

		int state;
		alGetSourcei(_source, AL_SOURCE_STATE, &state);
        if(state != AL_PLAYING)
            alSourcePlay(_source);
	}
	
};
