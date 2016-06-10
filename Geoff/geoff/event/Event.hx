package geoff.event;

/**
 * ...
 * @author Simon
 */
@:enum abstract EventType(String) to String from String
{
	var Resize = "Resize";
	var PointerDown = "PointerDown";
	var PointerMove = "PointerMove";
	var PointerUp = "PointerUp";
	var PointerScroll = "PointerScroll";
	var KeyDown = "KeyDown";
	var KeyUp = "KeyUp";
}

class Event 
{
	public var type : String;
	public var data : Dynamic;
	
	public function new( type : String, data : Dynamic )
	{
		this.type = type;
		this.data = data;
	}
}