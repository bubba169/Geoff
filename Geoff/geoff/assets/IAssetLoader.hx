package geoff.assets;
import geoff.audio.AudioSource;
import geoff.renderer.Texture;
import haxe.io.Bytes;

/**
 * @author Simon
 */
interface IAssetLoader 
{
	public function loadTexture( texture : Texture ) : Void;
	public function loadAudio( source : AudioSource ) : Void; 
	public function getText( path : String ) : String;
	public function getBytes( path : String ) : Bytes;
}