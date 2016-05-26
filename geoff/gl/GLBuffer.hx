package geoff.gl;
import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author ...
 */
class GLBuffer extends GLObject
{

	public function new( value : UInt, context : IGLContext ) 
	{
		super( value, "Buffer", context );
	}
	
}