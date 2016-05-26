package geoff.gl;
import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author Simon
 */
class GLShader extends GLObject
{

	public function new( value:Dynamic, context : IGLContext ) 
	{
		super(value, "Shader", context );
	}
	
}