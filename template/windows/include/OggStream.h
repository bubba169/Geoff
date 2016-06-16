#ifndef GEOFF_AUDIO_OGG_INCLUDED
#define GEOFF_AUDIO_OGG_INCLUDED

#include <al/al.h>
#include <ogg/ogg.h>
#include <ogg/codec.h>
#include <ogg/vorbisenc.h>
#include <ogg/vorbisfile.h>

#define BUFFER_SIZE (4096*8);

namespace geoff
{
	class OggStream
	{
		public:
			OggStream( haxe::io::Bytes bytes );
			~OggStream();

			size_t read( void* ptr, size_t size, size_t nmemb, void* datasource )
			{
				
			}

		private:
			geoff::audio::AudioChannel _channel;
	};
};

#endif