#include <ogg_decoder.h>


void geoff_load_ogg( geoff::audio::AudioSource source )
{

	ov_callbacks callbacks;
	callbacks.read_func = geoff_ogg_read;
	callbacks.seek_func = geoff_ogg_seek;
	callbacks.close_func = NULL;
	callbacks.tell_func = geoff_ogg_tell;

	// Load the file from memory
	OggVorbis_File file;
	void* dataSource = (void*)&(source);
	int result = ov_open_callbacks( dataSource, &file, NULL, 0, callbacks );

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

}

/**
 * Callbacks
 */

size_t geoff_ogg_read ( void* destination, size_t size, size_t nmemb, void* datasource )
{


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
		
	if ( whence == SEEK_SET ) 
	{
		source->position = offset;
	}
	else if ( whence == SEEK_CUR )
	{
		source->position += offset;
	}
	else if ( whence == SEEK_END )
	{
		source->position = source->rawBytes->length - offset;
	}

	return 0;
}

long geoff_ogg_tell ( void* datasource )
{
	geoff::audio::AudioSource source = *((geoff::audio::AudioSource*)(datasource));
	return source->position;
}