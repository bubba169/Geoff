#include <GeoffAudio.h>

namespace geoff
{
		
	GeoffAudio::GeoffAudio( )
	{		
		_callbacks.read_func = geoff_ogg_read;
		_callbacks.seek_func = geoff_ogg_seek;
		_callbacks.close_func = NULL;
		_callbacks.tell_func = NULL;
	}

	GeoffAudio::~GeoffAudio( )
	{
	}

	void GeoffAudio::load( geoff::audio::AudioSource source )
	{
		OggVorbis_File file;
		void* dataSource = (void*)&(source);
		
		int result = ov_open_callbacks( dataSource, &file, NULL, 0, _callbacks );
		source->
		printf( "Ogg open %i", result );
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
	geoff::audio::AudioSource source = *((geoff::audio::AudioSource*)(datasource));

	int len = size * nmemb;
	int pos = source->position;
	if ( pos + len > source->samples->length )
	{
		if ( pos == source->samples->length )
		{
			// End of file
			return 0;
		}
		else
		{
			len = source->samples->length - pos;
			source->position = source->samples->length;
		}
	}
	else
	{
		source->position += len;
	}

	memcpy( destination, (void*)&(source->samples->b[pos]), len );
	return len;
}

int geoff_ogg_seek ( void* datasource, ogg_int64_t offset, int whence )
{
	return -1;
}

long geoff_ogg_tell ( void* datasource )
{
	return 0;
}