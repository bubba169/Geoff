package geoff.platform.windows.externs;
import geoff.renderer.IRenderContext;
import geoff.renderer.RenderBatch;
import geoff.renderer.Texture;

import cpp.ConstCharStar;

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
	
	public function compileShader( vs : String, fs : String ) : Int;
	
	public function beginRender( width : Int, height : Int ) : Void;
	public function renderBatch( batch : RenderBatch ) : Void;
	public function endRender( ) : Void;
	
	public function pushRenderTarget( target : Texture ) : Void;
	public function popRenderTarget( ) : Void;
	
}