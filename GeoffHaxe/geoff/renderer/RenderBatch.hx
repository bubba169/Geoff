package geoff.renderer;

/**
 * ...
 * @author ...
 */
class RenderBatch
{

	public var vertices : Array<Float>;
	public var indices : Array<Int>;
	public var shader : Shader;
	public var textures : Array<Texture>;
	public var started : Bool = false;
	
	public function new() 
	{
		reset();
	}
	
	public function reset() : Void 
	{
		vertices = [];
		indices = [];
		textures = null;
		shader = null;
	}
	
	public function isCompatible( shader : Shader, textures : Array<Texture> ) : Bool 
	{
		if ( this.shader != shader ) return false;
		if ( (this.textures != null && textures == null) || (this.textures == null && textures != null) ) return false;
		
		if ( this.textures != null ) {
			
			if ( this.textures.length != textures.length ) return false;
			for ( i in 0...textures.length ) {
				if ( this.textures[i] != textures[i] ) return false;
			}
			
		}
		
		return true;
	}
	
}