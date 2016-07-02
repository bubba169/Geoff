package geoff.platform.assets.images;
import geoff.renderer.Texture;

/**
 * ...
 * @author Simon
 */
@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/../template/ios/include'/></files>")
@:cppInclude("GeoffAssetLoader.h")

class IOSImageLoader
{

	public function new()
	{
	}

	public static function loadTexture( texture : Texture ) : Void
	{

		untyped __global__.geoff_load_texture( texture );

	}

}
