#ifndef GEOFF_AUDIO_INCLUDED
#define GEOFF_AUDIO_INCLUDED

#include <hxcpp.h>
#include <haxe/io/Bytes.h>

#include <al/al.h>
#include <al/alc.h>
#include <ogg/ogg.h>
#include <vorbis/codec.h>
#include <vorbis/vorbisenc.h>
#include <vorbis/vorbisfile.h>

#include <geoff/App.h>
#include <geoff/event/EventManager.h>

#include <geoff/audio/AudioSource.h>
#include <geoff/audio/AudioChannel.h>

#define BUFFER_SIZE 4096
#define NUM_BUFFERS 4

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
			
			void loadOgg( geoff::audio::AudioSource source );
			void update( );
			void bufferData( haxe::io::Bytes data );

		private:

			ov_callbacks _callbacks;
			ALCdevice* _device;
			ALCcontext* _context;

			unsigned int _bufferIds[NUM_BUFFERS];
			unsigned int _source;
 
	};
};

#endif