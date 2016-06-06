package geoff.utils;
import geoff.renderer.Texture;
import hxmath.geom.Rect;

/**
 * ...
 * @author Simon
 */
class TextureUtils
{

	public function getRect( texture : Texture, subImageId : String ) : Rect {
		
		var result : Rect = null;
		
		if ( subImageId == null || subImageId == "" || map == null ) {
			result = new Rect( 0, 0, sourceImage.width, sourceImage.height );
		}else if ( map != null ) {
			var img : Dynamic = Reflect.field( map.frames, subImageId );
			if ( img != null ) {
				result = new Rect( img.spriteSourceSize.x, img.spriteSourceSize.y, img.sourceSize.w, img.sourceSize.h );
			}else {
				trace("No subimage " + subImageId + " in texture " + id );
				result = new Rect( 0, 0, sourceImage.width, sourceImage.height );
			}
		}
		
		return result;
		
	}
	
	public function getUV( texture : Texture, subImageId : String ) : Rect {
		
		var result : Rect = null;
		if ( subImageId == null || subImageId == "" || map == null ) {
			
			result = new Rect( 0, 0, 1, 1 );
			
		}else if ( map != null ) {
			
			var img : Dynamic = Reflect.field( map.frames, subImageId );
			if ( img != null ) {
				result = new Rect( 
					(img.frame.x / sourceImage.width),
					(img.frame.y / sourceImage.height),
					(img.frame.w / sourceImage.width),
					(img.frame.h / sourceImage.height)
				);
			}else {
				trace("No subimage " + subImageId + " in texture " + id );
				result = new Rect( 0, 0, 1, 1 );
			}
		}
		
		return result;
	}
	
}