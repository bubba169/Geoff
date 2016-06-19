package pkg;

import uk.co.mojaworks.norman.components.ui.UIDelegate;
import uk.co.mojaworks.norman.systems.ui.PointerEvent;

/**
 * ...
 * @author Simon
 */
class UIListener extends UIDelegate
{

	public function new() 
	{
		super();
		
	}
	
	override public function onMouseOver(e:PointerEvent):Void 
	{
		trace("Mouse Over");
	}
	
	override public function onMouseOut(e:PointerEvent):Void 
	{
		trace("Mouse Out");
	}
	
	override public function onMouseDown(e:PointerEvent):Void 
	{
		trace("Mouse Down");
	}
	
	override public function onMouseUp(e:PointerEvent):Void 
	{
		trace("Mouse Up");
	}
	
	override public function onMouseScroll(e:PointerEvent):Void 
	{
		trace("Scroll", core.io.pointer.get( e.pointerId ).scrollDelta );
	}
	
}