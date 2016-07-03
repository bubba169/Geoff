package geoff.platform.assets;

import geoff.assets.IAssetLoader;
import geoff.audio.AudioSource;
import geoff.platform.assets.audio.CPPOggLoader;
import geoff.renderer.Texture;
import haxe.Json;
import haxe.io.Bytes;

/**
 * ...
 * @author Simon
 */
 @:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/../template/ios/include'/></files>")
 @:cppInclude("GeoffAssetLoader.h")

class IOSAssetLoader implements IAssetLoader
{

	public function new()
	{

	}

	public function loadTexture( texture : Texture ) : Void
	{
		untyped __global__.geoff_load_texture( texture, getBytes( texture.asset ) );
	}

	public function loadAudio( source : AudioSource ) : Void
	{
		if ( source.originalFormat == AudioSourceFormat.Ogg )
		{
			CPPOggLoader.loadOgg( source );
		}
	}

	public function getText( asset : String ) : String
	{
		return untyped __global__.geoff_load_text( asset );
	}

	public function getBytes( asset : String ) : Bytes
	{
		return untyped __global__.geoff_load_bytes( asset );
	}

	public function assetExists( asset : String ) : Bool
	{
		return untyped __global__.geoff_asset_exists( asset );
	}

}
