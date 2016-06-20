package geoff.audio;
import haxe.io.Bytes;

/**
 * ...
 * @author Simon
 */

@:enum abstract AudioSourceFormat(Int) from Int to Int
{
	var Wav = 0;
	var Ogg = 1;
}
 
class AudioSource
{
	
	public var id : String;
	public var assetId : String;
	public var originalFormat : AudioSourceFormat;
	public var format : AudioSourceFormat;
	
	// Used when reading for decoding
	public var position : Int = 0;
	public var rawBytes : Bytes;
	
	public function new( id : String, format : AudioSourceFormat ) 
	{
		this.id = id;
		this.format = 0;
		this.originalFormat = format;
	}
	
}