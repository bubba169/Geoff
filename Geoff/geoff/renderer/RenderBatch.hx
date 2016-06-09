package geoff.renderer;
import geoff.utils.NativeHelper;
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
		started = false;
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
	
	
	#if geoff_cpp
		public function getRawVertices( ) : BytesData
		{
			return NativeHelper.toFloatBytes( vertices ).getData();
		}
		
		public function getRawIndexes( ) : BytesData
		{
			return NativeHelper.toUInt16Bytes( indexes ).getData();
		}
	#end
	
	
	#if geoff_java
		public function getRawVertices( ) : java.nio.FloatBuffer
		{
			return NativeHelper.toFloatBuffer( vertices );
		}
		
		public function getRawIndexes( ) : java.nio.ShortBuffer
		{
			return NativeHelper.toShortBuffer( indexes );
		}
	#end
	
}