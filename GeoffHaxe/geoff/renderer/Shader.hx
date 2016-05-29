package geoff.renderer;

/**
 * ...
 * @author ...
 */

class ShaderAttribute
{
	public var size : Int;
	public var start : Int;
	public var name : String;
	
	
	public function new( name : String, start : Int, size : Int ) 
	{
		this.name = name;
		this.start = start;
		this.size = size;
	}
}
 

class Shader
{

	public var attributes : Array<ShaderAttribute>;
	public var fragmentSource : String;
	public var vertexSource : String;
	public var program : Int;
	public var vertexSize : Int;
	
	
	public function new( vs : String, fs : String, atts : Array<ShaderAttribute> ) 
	{
		vertexSource = vs;
		fragmentSource = fs;
		attributes = atts;
		
		vertexSize = 0;
		for ( att in atts ) {
			vertexSize += att.size;
		}
	}
	
}