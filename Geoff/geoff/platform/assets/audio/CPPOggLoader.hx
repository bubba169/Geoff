package geoff.platform.assets.audio;
import geoff.audio.AudioSource;

/**
 * ...
 * @author Simon
 */
@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/../template/common/cpp/ogg_decoder/include'/></files>")
@:cppInclude("ogg_decoder.h")
 
class CPPOggLoader
{

	public function new() 
	{
		
	}
	
	public static function loadOgg( source : AudioSource ) : Void
	{
		untyped __global__.geoff_load_ogg( source );
	}
	
}