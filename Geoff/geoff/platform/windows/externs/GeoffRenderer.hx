package geoff.platform.windows.externs;
import geoff.renderer.RenderBatch;
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
	public function compileShader( vs : cpp.Pointer<String>, fs : cpp.Pointer<String> ) : Int;
	
	public function beginRender( width : Int, height : Int ) : Void;
	public function renderBatch( batch : RenderBatch ) : Void;
	public function endRender( ) : Void;
	
	public function pushRenderTarget( target : Texture ) : Void;
	public function popRenderTarget( ) : Void;
	
	public function getError() : Int;
	
	public function createTexture( path : cpp.Pointer<String>, texture : Texture ) : Void;
	
}