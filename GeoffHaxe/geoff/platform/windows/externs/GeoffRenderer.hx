package geoff.platform.windows.externs;
import geoff.renderer.IRenderContext;
import geoff.renderer.RenderBatch;
import geoff.renderer.Texture;

import cpp.ConstCharStar;

/**
 * ...
 * @author Simon
 */
@:include("GeoffRenderer.h")
 
extern class GeoffRenderer
{

	public static function clear( r : Float, g : Float, b : Float, a : Float ) : Void;
	
	public static function compileShader( vs : String, fs : String ) : Int;
	
	public static function beginRender( width : Float, height : Float ) : Void;
	public static function renderBatch( batch : RenderBatch ) : Void;
	public static function endRender( ) : Void;
	
	public static function pushRenderTarget( target : Texture ) : Void;
	public static function popRenderTarget( ) : Void;
	
}