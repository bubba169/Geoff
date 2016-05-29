package geoff.renderer;

/**
 * @author Simon
 */
interface IRenderContext 
{
 
	public function clear() : Void;
	
	public function compileShader( vs : String, fs : String ) : Int;
	
	public function beginRender( width : Int, height : Int ) : Void;
	public function renderBatch( batch : RenderBatch ) : Void;
	public function endRender( ) : Void;
	
	public function pushRenderTarget( target : Texture ) : Void;
	public function popRenderTarget( ) : Void;
	
	public function getError() : Int;
	
}