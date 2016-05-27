package geoff.gl;
import geoff.gl.GLShader.GLShaderParameter;
import geoff.platform.interfaces.IGLContext;

/**
 * ...
 * @author Simon
 */
@:enum abstract GLShaderType(Int) from Int to Int
{
	var VertexShader = 0x8B31;
	var FragmentShader = 0x8B30;
}

@:enum abstract GLShaderParameter(Int) from Int to Int
{
	var ShaderType = 0x8B4F;
	var DeleteStatus = 0x8B80;
	var CompileStatus = 0x8B81;
	var InfoLogLength = 0x8B84;
	var ShaderSourceLength = 0x8B88;
}
 
class GLShader extends GLObject
{	
	public function new( value:Dynamic, context : IGLContext ) 
	{
		super(value, "Shader", context );
	}
	
}