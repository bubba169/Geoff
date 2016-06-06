package pkg;

import geoff.event.Key;
import geoff.event.PointerButton.PointerButton;
import geoff.renderer.IRenderContext;
import geoff.renderer.RenderBatch;
import geoff.utils.Assets;
import uk.co.mojaworks.norman.NormanApp;

/**
 * ...
 * @author ...
 */
class AppEngine extends NormanApp
{
	var shader : Int;
	var batch:RenderBatch;
	
	var _width : Int = 640;
	var _height : Int = 480;

	public function new() 
	{
		super();
	}
	
	override public function init( renderer : IRenderContext ) 
	{
		trace( Assets.getText( "test/hello.txt" ) );
		
		trace( Key.SPACE );
	}
	
	override public function update( renderer : IRenderContext, seconds : Float ) 
	{
		renderer.clear();
	}
	
	override public function resize(width:Int, height:Int) 
	{
		_width = width;
		_height = height;
	}
	
	override public function onPointerDown(pointerId:Int, button : PointerButton, x:Int, y:Int):Void 
	{
		
	}
	
	
	
}