#ifndef GEOFF_AUDIO_INCLUDED
#define GEOFF_AUDIO_INCLUDED

#include <hxcpp.h>
#include <haxe/io/Bytes.h>

#include <al/al.h>
#include <ogg/ogg.h>
#include <vorbis/codec.h>
#include <vorbis/vorbisenc.h>
#include <vorbis/vorbisfile.h>

#include <geoff/audio/AudioSource.h>
#include <geoff/audio/AudioChannel.h>

#define BUFFER_SIZE (4096*8);

size_t geoff_ogg_read ( void* destination, size_t size, size_t nmemb, void* datasource );
int geoff_ogg_seek ( void* datasource, ogg_int64_t offset, int whence );
long geoff_ogg_tell ( void* datasource );

namespace geoff
{
	class GeoffAudio
	{
		public:
			GeoffAudio();
			~GeoffAudio();
			
			void load( geoff::audio::AudioSource source );
			void unload( geoff::audio::AudioSource source );
			void playOneShot( geoff::audio::AudioChannel channel );
			void playLooping( geoff::audio::AudioChannel channel );
			void stop( geoff::audio::AudioChannel channel );
			void update( float seconds );

		private:

			ov_callbacks _callbacks;

	};
};

#endif