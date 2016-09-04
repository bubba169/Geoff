package geoff.platform.assets.images;
import geoff.renderer.Texture;

/**
 * ...
 * @author Simon
 */
@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/../template/common/cpp/stb_image/include'/></files>")
@:cppInclude("stb_image_loader.h")

class STBImageLoader
{

	public function new()
	{
	}

	
	@:functionCode("
		int n;
		unsigned char* data = stbi_load( texture-> asset.__CStr(), &texture->width, &texture->height, &n, 4 );

		texture->pixels = haxe::io::Bytes_obj::alloc( texture->width * texture->height * 4 );
		memcpy( (void*)&(texture-> pixels->b[0]), (void*)data, texture->pixels->length );

		stbi_image_free(data);
		
	")		
	public static function loadTexture( texture : Texture ) : Void
	{
	}

}
