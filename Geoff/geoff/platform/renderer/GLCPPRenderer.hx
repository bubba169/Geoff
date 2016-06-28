package geoff.platform.renderer;
import geoff.renderer.BlendFactor;
import geoff.renderer.FrameBuffer;
import geoff.renderer.IRenderContext;
import geoff.renderer.RenderBatch;
import geoff.renderer.Shader;
import geoff.renderer.Texture;
import geoff.utils.Color;
import haxe.io.Bytes;

/**
 * ...
 * @author Simon
 */

@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/../template/common/cpp/gl_renderer/include'/></files>")
@:structAccess
@:unreflective
@:include("GeoffRenderer.h")
@:native("geoff::GeoffRenderer")
extern class NativeGLCPP
{
	public function clear( r : Float, g : Float, b : Float, a : Float ) : Void;
	
	public function compileShader( shader : Shader ) : Int;
	public function destroyShader( shader : Shader ) : Void;
	
	public function beginRender( width : Int, height : Int ) : Void;
	public function renderBatch( batch : RenderBatch ) : Void;
	public function endRender( ) : Void;
	
	public function createFrameBuffer( target : FrameBuffer ) : Void;
	public function bindFrameBuffer( target : FrameBuffer ) : Void;
	public function destroyFrameBuffer( target : FrameBuffer ) : Void;
	
	public function setBlendMode( sourceFactor : Int, destinationFactor : Int ) : Void;
	public function setBlendModeSeparate( sourceFactor : Int, destinationFactor : Int, sourceAlphaFactor : Int, destAlphaFactor : Int ) : Void;
	
	public function getError() : Int;
	
	public function createTextureFromAsset( texture : Texture ) : Void;
	public function createTexture( texture : Texture ) : Void;
	public function uploadTexture( texture : Texture ) : Void;
	public function destroyTexture( texture : Texture ) : Void;
	
}
 
/**
 * 
 */

class GLCPPRenderer implements IRenderContext
{

	public var _internalRenderer : cpp.Pointer<NativeGLCPP>;

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

	public function onContextCreated() : Void
	{

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
		var result : Int = _internalRenderer.get_ref().compileShader( shader );
		trace("Shader compile status: " + result );
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
		
		App.current.platform.assetLoader.loadTexture( texture );
		_internalRenderer.get_ref().createTexture( texture );
		
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


	/**
	 * Blending
	 */

	public function setBlendMode( sourceFactor : BlendFactor, destinationFactor : BlendFactor ) : Void
	{
		_internalRenderer.get_ref().setBlendMode( sourceFactor, destinationFactor );
	}

	public function setBlendModeSeparate( sourceFactor : BlendFactor, destinationFactor : BlendFactor, sourceAlphaFactor : BlendFactor, destAlphaFactor : BlendFactor ) : Void
	{
		_internalRenderer.get_ref().setBlendModeSeparate( sourceFactor, destinationFactor, sourceAlphaFactor, destAlphaFactor );
	}



}
