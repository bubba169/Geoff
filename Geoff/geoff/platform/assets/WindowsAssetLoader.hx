package geoff.platform.assets;

import geoff.assets.IAssetLoader;
import geoff.audio.AudioSource;
import geoff.platform.assets.audio.CPPOggLoader;
import geoff.platform.assets.images.ILCPPImageLoader;
import geoff.renderer.Texture;
import haxe.io.Bytes;
import sys.io.File;

/**
 * ...
 * @author Simon
 */
class WindowsAssetLoader implements IAssetLoader
{

	public function new() 
	{
		
	}

	public function loadTexture( texture : Texture ) : Void 
	{
		ILCPPImageLoader.loadTexture( texture );
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
		return File.getContent( asset );
	}
	
	public function getBytes( asset : String ) : Bytes 
	{
		return File.getBytes( asset );
	}
	
}