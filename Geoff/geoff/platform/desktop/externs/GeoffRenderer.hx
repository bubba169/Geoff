package geoff.platform.desktop.externs;
import geoff.renderer.FrameBuffer;
import geoff.renderer.RenderBatch;
import geoff.renderer.Shader;
import geoff.renderer.Texture;


/**
 * ...
 * @author Simon
 */
@:structAccess
@:unreflective
@:include("GeoffRenderer.h")
@:native("geoff::GeoffRenderer")

extern class GeoffRenderer
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