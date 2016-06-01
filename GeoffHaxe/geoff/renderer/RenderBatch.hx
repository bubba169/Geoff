package geoff.renderer;
import geoff.utils.BytesHelper;
import haxe.io.BytesData;

/**
 * ...
 * @author ...
 */
class RenderBatch
{

	public var vertices : Array<Float>;
	public var indexes : Array<Int>;
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
		indexes = [];
		textures = [];
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
	
	
	#if cplusplus
	public function getRawVertices( ) : BytesData
	{
		return BytesHelper.toFloatBytes( vertices ).getData();
	}
	
	public function getRawIndexes( ) : BytesData
	{
		return BytesHelper.toIntBytes( indexes ).getData();
	}
	#end
	
}