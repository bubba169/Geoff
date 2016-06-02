package geoff.event;

/**
 * ...
 * @author Simon
 */
@:enum abstract PointerButton(Int) from Int to Int
{
	var None = 0;
	var Left = 1;
	var Middle = 2;
	var Right = 3;
	var Button4 = 4;
	var Button5 = 5;
}
 
class PointerEvent extends Event
{

	public static var DOWN : String = "PointerDown";
	public static var UP : String = "PointerUp";
	public static var MOVE : String = "PointerMove";
	
	public var y:Int;
	public var x:Int;
	public var pointerId:Int;
	public var button:PointerButton;
	
	public function new( type : String, x : Int, y : Int, button : PointerButton, pointerId : Int ) 
	{
		super(type);
		this.x = x;
		this.y = y;
		this.pointerId = pointerId;
		this.button = button;
	}
	
}