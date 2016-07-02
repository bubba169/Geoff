package geoff.platform.assets;

import geoff.assets.IAssetLoader;
import geoff.audio.AudioSource;
import geoff.platform.assets.audio.CPPOggLoader;
import geoff.platform.assets.images.IOSImageLoader;
import geoff.renderer.Texture;
import haxe.Json;
import haxe.io.Bytes;

/**
 * ...
 * @author Simon
 */
class IOSAssetLoader implements IAssetLoader
{

	public function new()
	{

	}

	public function loadTexture( texture : Texture ) : Void
	{
		IOSImageLoader.loadTexture( texture );
	}

	public function loadAudio( source : AudioSource ) : Void
	{
		//if ( source.originalFormat == AudioSourceFormat.Ogg )
		//{
		//	CPPOggLoader.loadOgg( source );
		//}
	}

	public function getText( asset : String ) : String
	{
		return "";//File.getContent( asset );
	}

	public function getBytes( asset : String ) : Bytes
	{
		return Bytes.alloc(0);//File.getBytes( asset );
	}

	public function assetExists( asset : String ) : Bool
	{
		return false;//FileSystem.exists( asset );
	}

}
