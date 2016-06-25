package geoff.platform.audio.alcpp;
import geoff.audio.AudioChannel;
import geoff.audio.AudioSource;
import haxe.io.Bytes;

/**
 * ...
 * @author Simon
 */
@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/../template/common/cpp/al_audio/include'/></files>")
 
@:structAccess
@:unreflective
@:include("GeoffAudio.h")
@:native("geoff::GeoffAudio")

extern class NativeALCPP
{
	public function update( ) : Void;
	public function bufferData( data : Bytes ) : Void;
}