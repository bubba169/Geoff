#ifndef GEOFF_OGG_INCLUDED
#define GEOFF_OGG_INCLUDED

#include <ogg/ogg.h>
#include <vorbis/codec.h>
#include <vorbis/vorbisfile.h>

#include <haxe/io/Bytes.h>

#include <geoff/audio/AudioSource.h>

void geoff_load_ogg( geoff::audio::AudioSource source );

// Callbacks
size_t geoff_ogg_read ( void* destination, size_t size, size_t nmemb, void* datasource );
int geoff_ogg_seek ( void* datasource, ogg_int64_t offset, int whence );
long geoff_ogg_tell ( void* datasource );

#endif