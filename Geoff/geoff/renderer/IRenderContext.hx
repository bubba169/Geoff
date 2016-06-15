package geoff.renderer;
import geoff.utils.Color;
import haxe.io.Bytes;

/**
 * @author Simon
 */
interface IRenderContext 
{
	public function init() : Void;
	public function clear( color : Color ) : Void;

	public function uploadShader( shader : Shader ) : Void;
	public function destroyShader( shader : Shader ) : Void;
	
	public function beginRender( width : Int, height : Int ) : Void;
	public function renderBatch( batch : RenderBatch ) : Void;
	public function endRender( ) : Void;
	
	public function createFrameBuffer( texture : Texture ) : FrameBuffer;
	public function bindFrameBuffer( buffer : FrameBuffer ) : Void;
	public function destroyFrameBuffer( buffer : FrameBuffer ) : Void;
	
	public function setBlendMode( sourceFactor : BlendFactor, destinationFactor : BlendFactor ) : Void;
	public function setBlendModeSeparate( sourceFactor : BlendFactor, destinationFactor : BlendFactor, sourceAlphaFactor : BlendFactor, destAlphaFactor : BlendFactor ) : Void;
	
	public function getError() : Int;
	
	public function createTextureFromAsset( path : String ) : Texture;
	public function createTextureFromPixels( id : String, width : Int, height : Int, pixels : Bytes ) : Texture;
	public function uploadTexture( texture : Texture ) : Void;
	public function destroyTexture( texture : Texture ) : Void;
	
	public function destroy() : Void;
	
}