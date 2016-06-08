package geoff.renderer;
import geoff.utils.Color;
import haxe.io.UInt8Array;

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
	
	public function pushRenderTarget( target : Texture ) : Void;
	public function popRenderTarget( ) : Void;
	
	public function getError() : Int;
	
	public function createTextureFromAsset( path : String ) : Texture;
	public function createTextureFromPixels( id : String, width : Int, height : Int, pixels : Array<Int> ) : Texture;
	public function uploadTexture( texture : Texture ) : Void;
	public function destroyTexture( texture : Texture ) : Void;
	
	public function destroy() : Void;
	
}