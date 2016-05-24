package geoff;

import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author ...
 */
class AppDelegate
{

	public function new() 
	{
		
	}
	
	public function init( gl : IGLContext )
	{
		gl.clearColor( 1, 1, 1, 1 );
	}
	
	public function render( gl : IGLContext )
	{
		gl.clear( gl.COLOR_BUFFER_BIT );
	}
}