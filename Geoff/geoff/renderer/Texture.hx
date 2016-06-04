package geoff.renderer;

/**
 * ...
 * @author ...
 */
class Texture
{
	
	public var id : UInt = 0;
	public var width : Int = 0;
	public var height : Int = 0;
	public var resource : String;

	public function new( resource : String ) 
	{
		this.resource = resource;
	}
	
}