package geoff.event;

/**
 * ...
 * @author Simon
 */
class ResizeEvent extends Event
{
	
	public static var RESIZE : String = "Resize";
	
	public var width : Int;
	public var height : Int;

	public function new(type : String, width : Int, height : Int ) 
	{
		super(type);
		this.width = width;
		this.height = height;
		
	}
	
}