package geoff;

import geoff.App;
import geoff.event.Key;
import geoff.event.PointerButton;
import geoff.renderer.IRenderContext;

/**
 * ...
 * @author ...
 */
class AppDelegate
{

	public var overrideBackButton : Bool = false;
	
	public function new() 
	{
		
	}
	
	public function init( renderer : IRenderContext ) : Void {}
	public function update( seconds : Float ) : Void {}
	public function render( renderer : IRenderContext ) : Void {}
	public function destroy() : Void {}
	public function resize( width : Int, height : Int ) : Void {}
	
	public function onPointerDown( pointerId : Int, button : PointerButton, x : Int, y : Int ) : Void {};
	public function onPointerUp( pointerId : Int, button : PointerButton, x : Int, y : Int ) : Void {};
	public function onPointerMove( pointerId : Int, x : Int, y : Int ) : Void {};
	public function onPointerScroll( pointerId : Int, x : Int, y : Int ) : Void {};
	
	public function onKeyDown( key : Int, modifiers : Int ) : Void {
		if ( !overrideBackButton && (key == Key.BACK || key == Key.ESCAPE) )
		{
			App.current.shutdown();
		}
	};
	public function onKeyUp( key : Int, modifiers : Int ) : Void {};
	public function onTextInput( character : String ) {};
	
	public function onContextCreated( context : IRenderContext ) : Void {};
	
}