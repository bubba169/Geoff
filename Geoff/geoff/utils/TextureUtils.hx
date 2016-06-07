package geoff.utils;
import geoff.renderer.Texture;
import geoff.math.Rect;

/**
 * ...
 * @author Simon
 */
class TextureUtils
{

	public static function getRect( texture : Texture, subImageId : String ) : Rect {
		
		var result : Rect = null;
		
		if ( subImageId == null || subImageId == "" || texture.map == null ) {
			result = new Rect( 0, 0, texture.width, texture.height );
		}else if ( texture.map != null ) {
			var img : Dynamic = Reflect.field( texture.map.frames, subImageId );
			if ( img != null ) {
				result = new Rect( img.spriteSourceSize.x, img.spriteSourceSize.y, img.sourceSize.w, img.sourceSize.h );
			}else {
				trace("No subimage " + subImageId + " in texture " + texture.id );
				result = new Rect( 0, 0, texture.width, texture.height );
			}
		}
		
		return result;
		
	}
	
	public static function getUV( texture : Texture, subImageId : String ) : Rect {
		
		var result : Rect = null;
		if ( subImageId == null || subImageId == "" || texture.map == null ) {
			
			result = new Rect( 0, 0, 1, 1 );
			
		}else if ( texture.map != null ) {
			
			var img : Dynamic = Reflect.field( texture.map.frames, subImageId );
			if ( img != null ) {
				result = new Rect( 
					(img.frame.x / texture.width),
					(img.frame.y / texture.height),
					(img.frame.w / texture.width),
					(img.frame.h / texture.height)
				);
			}else {
				trace("No subimage " + subImageId + " in texture " + texture.id );
				result = new Rect( 0, 0, 1, 1 );
			}
		}
		
		return result;
	}
	
}