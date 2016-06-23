package geoff.platform.desktop.externs;
import geoff.audio.AudioChannel;
import geoff.audio.AudioSource;

/**
 * ...
 * @author Simon
 */
@:structAccess
@:unreflective
@:include("GeoffAudio.h")
@:native("geoff::GeoffAudio")

extern class GeoffAudio
{
	public function load( source : AudioSource ) : Void;
	public function unload( source : AudioSource ) : Void;
	public function playOneShot( channel : AudioChannel ) : Void;
	public function playLooping( channel : AudioChannel ) : Void;
	public function stop( channel : AudioChannel ) : Void;
	public function update( channels : Array<AudioChannel> ) : Void;
}