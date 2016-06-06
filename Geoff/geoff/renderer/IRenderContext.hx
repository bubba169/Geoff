package geoff.renderer;
import geoff.utils.Color;

/**
 * @author Simon
 */
interface IRenderContext 
{
	public var clearColor : Color;
	
	public function init() : Void;
	public function clear( color : Color ) : Void;

	public function createShader( vs : String, fs : String ) : Shader;
	public function uploadShader( shader : Shader ) : Void;
	public function destroyShader( shader : Shader ) : Void;
	
	public function beginRender( width : Int, height : Int ) : Void;
	public function renderBatch( batch : RenderBatch ) : Void;
	public function endRender( ) : Void;
	
	public function pushRenderTarget( target : Texture ) : Void;
	public function popRenderTarget( ) : Void;
	
	public function getError() : Int;
	
	public function createTexture( path : String ) : Texture;
	public function uploadTexture( texture : Texture ) : Void;
	public function destroyTexture( texture : Texture ) : Void;
	
	public function destroy() : Void;
	
}