package pkg;

import geoff.AppDelegate;
import geoff.gl.GLBuffer;
import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author ...
 */
class AppEngine extends AppDelegate
{

	var vertexBuffer : GLBuffer;
	var indexBuffer : GLBuffer;
	
	public function new() 
	{
		super();
	}
	
	override public function init(gl:IGLContext) 
	{
		gl.clearColor( 1, 1, 0, 1 );
		vertexBuffer = gl.createBuffer();
		indexBuffer = gl.createBuffer();
		
		
	}
	
	override public function render(gl:IGLContext) 
	{
		
		gl.clear( gl.COLOR_BUFFER_BIT );
		
		var vertexData : Array<Float> = [
			100, 0,
			0, 100,
			200, 100
		];
		
		var indexData : Array<Int> = [
			0, 1, 2
		];
		
	}
	
}