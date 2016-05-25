package pkg;

import geoff.AppDelegate;
import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author ...
 */
class AppEngine extends AppDelegate
{

	public function new() 
	{
		super();
	}
	
	override public function init(gl:IGLContext) 
	{
		gl.clearColor( 1, 1, 0, 1 );
	}
	
	override public function render(gl:IGLContext) 
	{
		
		gl.clear( gl.COLOR_BUFFER_BIT );
		
		/*var vertexData : Array<Float> = [
			100, 0,
			0, 100,
			200, 100
		];
		
		var indexData : Array<Int> = [
			0, 1, 2
		];
		
		trace( gl.createBuffer() );
		
		*/
		
	}
	
}