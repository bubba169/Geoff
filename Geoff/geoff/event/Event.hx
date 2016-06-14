package geoff.event;

/**
 * ...
 * @author Simon
 */
@:enum abstract EventType(String) to String from String
{
	var Resize = "Resize";
	
	var Deactivate = "Deactivate";
	var Activate = "Activate";
	var ContextCreated = "ContextCreated";
	
	var PointerDown = "PointerDown";
	var PointerMove = "PointerMove";
	var PointerUp = "PointerUp";
	var PointerScroll = "PointerScroll";
	
	var KeyDown = "KeyDown";
	var KeyUp = "KeyUp";
	var TextEntry = "TextEntry";
	
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