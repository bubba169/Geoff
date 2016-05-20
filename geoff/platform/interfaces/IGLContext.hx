package geoff.platform.interfaces;

/**
 * @author Simon
 */
interface IGLContext 
{
	public var COLOR_BUFFER_BIT : Int;
	public var DEPTH_BUFFER_BIT : Int;
	public var STENCIL_BUFFER_BIT : Int;
	
	function clear( mask : Int ) : Void;
	function clearColor( r : Float, g : Float, b : Float, a : Float ) : Void;
}