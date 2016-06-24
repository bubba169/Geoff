package geoff.assets;
import geoff.audio.AudioSource;
import haxe.io.Bytes;

/**
 * @author Simon
 */
interface IAssetLoader 
{
	/**
	 * Loads a png and returns the pixel data in a byte array
	 */
	public function loadPngAsset( path : String ) : Bytes;
	public function loadPng( bytes : Bytes ) : Bytes;
	
	public function loadJpgAsset( path : String ) : Bytes;
	public function loadJpeg( bytes : Bytes ) : Bytes;
	
	/**
	 * Loads a sound file and creates and AudioSource
	 */
	
	public function loadOggAsset( path : String ) : AudioSource;
	public function loadOgg( bytes : Bytes ) : AudioSource;
	
	public function loadWavAsset( path : String ) : AudioSource;
	public function loadWav( bytes : Bytes ) : AudioSource;
	
	/**
	 * Load text asset
	 */
	public function getText( path : String ) : String;
	
	/**
	 * Load a binary asset
	 */
	public function getBytes( path : String ) : Bytes;
}