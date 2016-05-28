package geoff.platform.windows;
import geoff.platform.windows.externs.GeoffRenderer;
import geoff.renderer.IRenderContext;
import geoff.renderer.RenderBatch;
import geoff.renderer.Texture;
import geoff.utils.Color;

/**
 * ...
 * @author Simon
 */

class WindowsRenderer implements IRenderContext
{

	public var clearColor : Color = Color.GREEN;
	public var _internalRenderer : GeoffRenderer;
	
	public function new() 
	{
	}
	
	public function clear() : Void
	{
		_internalRenderer.clear( clearColor.r / 255, clearColor.g / 255, clearColor.b / 255, clearColor.a );
	}
	
	
	/**
	 * Shader
	 */
	
	public function compileShader( vs : String, fs : String ) : Int
	{
		return _internalRenderer.compileShader( vs, fs );
	}	
	
	
	/**
	 * Render
	 */
	
	public function beginRender( width : Float, height : Float ) : Void
	{
	}
	
	public function renderBatch( batch : RenderBatch ) : Void
	{
	}
	
	public function endRender( ) : Void
	{
	}
	
	
	/**
	 * Framebuffer
	 */
	
	public function pushRenderTarget( target : Texture ) : Void 
	{
	}
	
	public function popRenderTarget( ) : Void 
	{
	}
	
	
	
}