package geoff.gl;

import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author ...
 */

@:enum abstract GLProgramParameter(Int) from Int to Int
{
	var LinkStatus : Int = 0x8B82;
	var InfoLogLength : Int = 0x8B84;
}
 
class GLProgram extends GLObject
{

	public function new(value:Dynamic, context:IGLContext) 
	{
		super(value, "Program", context);
		
	}
	
}