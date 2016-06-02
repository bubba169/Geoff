package geoff;

import geoff.event.PointerEvent.PointerButton;
import geoff.renderer.IRenderContext;

/**
 * ...
 * @author ...
 */
class AppDelegate
{

	public function new() 
	{
		
	}
	
	public function init( renderer : IRenderContext ) : Void {}
	public function update( renderer : IRenderContext ) : Void {}
	public function destroy() : Void {}
	public function resize( width : Int, height : Int ) : Void {}
	
	public function onPointerDown( pointerId : Int, button : PointerButton, x : Int, y : Int ) : Void {};
	public function onPointerUp( pointerId : Int, button : PointerButton, x : Int, y : Int ) : Void {};
	public function onPointerMove( pointerId : Int, x : Int, y : Int ) : Void {};
}