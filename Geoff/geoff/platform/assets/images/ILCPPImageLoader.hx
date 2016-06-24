package geoff.platform.assets.images;
import geoff.renderer.Texture;
import haxe.io.Bytes;

/**
 * ...
 * @author Simon
 */
@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/../template/common/cpp/il_imageloader/include'/></files>")
@:cppInclude("il/il.h")

class ILCPPImageLoader
{

	public function new() 
	{
		// Added here to make sure it's included
		Bytes;
	}
	
	public static function loadTexture( texture : Texture ) : Void
	{
		
		untyped __cpp__("unsigned int imageName");
		untyped __cpp__("ilGenImages( 1, &imageName )");
		untyped __cpp__("ilBindImage( imageName )");		
		untyped __cpp__("ilLoadImage( texture->asset.__CStr() )");
		
		untyped __cpp__("texture->width = ilGetInteger( IL_IMAGE_WIDTH )");
		untyped __cpp__("texture->height = ilGetInteger( IL_IMAGE_HEIGHT )");
		untyped __cpp__("texture->pixels = haxe::io::Bytes_obj::alloc( texture->width * texture->height * 4 )");
		
		untyped __cpp__("ilCopyPixels( 0, 0, 0, texture->width, texture->height, 1, IL_RGBA, IL_UNSIGNED_BYTE, (unsigned char*)&(texture->pixels->b[0]) )");
		untyped __cpp__("ilBindImage(0)");
		untyped __cpp__("ilDeleteImages( 1, &imageName )");
		
	}
	
}