package geoff.platform.desktop.externs;
import geoff.audio.AudioChannel;
import geoff.audio.AudioSource;
import haxe.io.Bytes;

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
	public function loadOgg( source : AudioSource ) : Void;
	public function update( ) : Void;
	public function bufferData( data : Bytes ) : Void;
}