package geoff.audio;
import haxe.io.Bytes;

/**
 * ...
 * @author Simon
 */
class AudioSource
{
	
	public var id : String;
	public var assetId : String;
	public var samples : Bytes;

	public function new( id : String ) 
	{
		this.id = id;
	}
	
}