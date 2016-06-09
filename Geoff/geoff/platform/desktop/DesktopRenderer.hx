package geoff.platform.desktop;
import geoff.platform.desktop.externs.GeoffRenderer;
import geoff.renderer.FrameBuffer;
import geoff.renderer.IRenderContext;
import geoff.renderer.RenderBatch;
import geoff.renderer.Shader;
import geoff.renderer.Texture;
import geoff.utils.Color;
import haxe.io.Bytes;
import haxe.io.UInt8Array;

/**
 * ...
 * @author Simon
 */

class DesktopRenderer implements IRenderContext
{

	public var _internalRenderer : cpp.Pointer<GeoffRenderer>;
	
	public function new() 
	{
	}
	
	public function init() : Void 
	{
		untyped __cpp__("_internalRenderer = new GeoffRenderer()");
	}
	
	public function destroy() 
	{
		untyped __cpp__("delete _internalRenderer");
	}

	
	public function clear( clearColor : Color ) : Void
	{
		_internalRenderer.get_ref().clear( clearColor.r / 255, clearColor.g / 255, clearColor.b / 255, clearColor.a );
	}
	
	
	/**
	 * Shader
	 */
	
	public function uploadShader( shader : Shader ) : Void
	{
		_internalRenderer.get_ref().compileShader( shader );
	}	
	
	public function destroyShader( shader : Shader ) : Void
	{
		_internalRenderer.get_ref().destroyShader( shader );
	}	
	
	
	/**
	 * Render
	 */
	
	public function beginRender( width : Int, height : Int ) : Void
	{
		_internalRenderer.get_ref().beginRender( width, height );
	}
	
	public function renderBatch( batch : RenderBatch ) : Void
	{
		_internalRenderer.get_ref().renderBatch( batch );
	}
	
	public function endRender( ) : Void
	{
	}
	
	public function getError() : Int
	{
		return _internalRenderer.get_ref().getError();
	}
	
	
	/**
	 * Framebuffer
	 */
	
	public function createFrameBuffer( texture : Texture ) : FrameBuffer 
	{
		var frameBuffer = new FrameBuffer( );
		frameBuffer.texture = texture;
		_internalRenderer.get_ref().createFrameBuffer( frameBuffer );
		return frameBuffer;
	}
	
	public function bindFrameBuffer( target : FrameBuffer ) : Void 
	{
		_internalRenderer.get_ref().bindFrameBuffer( target );
	}
	
	public function destroyFrameBuffer( target : FrameBuffer ) : Void 
	{
		_internalRenderer.get_ref().destroyFrameBuffer( target );
	}
	
	
	
	/**
	 * Texture
	 */
	
	public function createTextureFromAsset( path : String ) : Texture 
	{
		var texture : Texture = new Texture( path );
		texture.asset = path;
		_internalRenderer.get_ref().createTextureFromAsset( texture );
		return texture;
	}
	
	public function createTextureFromPixels( id : String, width : Int, height : Int, pixels : Bytes ) : Texture
	{
		var texture : Texture = new Texture( id );
		texture.width = width;
		texture.height = height;
		texture.pixels = pixels;
		_internalRenderer.get_ref().createTexture( texture );
		return texture;
	}
	
	public function uploadTexture( texture : Texture ) : Void 
	{
		_internalRenderer.get_ref().uploadTexture( texture );
	}
	
	public function destroyTexture( texture : Texture ) : Void 
	{
		_internalRenderer.get_ref().destroyTexture( texture );
	}
	
	
	
	
}