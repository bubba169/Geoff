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
	
}