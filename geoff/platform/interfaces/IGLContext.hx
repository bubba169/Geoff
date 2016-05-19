package geoff.platform.interfaces;

/**
 * @author Simon
 */
interface IGLContext 
{
	function clear( mask : Int ) : Void;
	function clearColor( r : Float, g : Float, b : Float, a : Float ) : Void;
}