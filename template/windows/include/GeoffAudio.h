#ifndef GEOFF_AUDIO_INCLUDED
#define GEOFF_AUDIO_INCLUDED

#include <hxcpp.h>

#include <al/al.h>
#include <ogg/ogg.h>
#include <vorbis/codec.h>
#include <vorbis/vorbisenc.h>
#include <vorbis/vorbisfile.h>

#include <geoff/audio/AudioSource.h>
#include <geoff/audio/AudioChannel.h>

#define BUFFER_SIZE (4096*8);

namespace geoff
{
	class GeoffAudio
	{
		public:
			GeoffAudio();
			~GeoffAudio();
			
			void unload( geoff::audio::AudioSource source );
			void playOneShot( geoff::audio::AudioChannel channel );
			void playLooping( geoff::audio::AudioChannel channel );
			void stop( geoff::audio::AudioChannel channel );

	};
};

#endif