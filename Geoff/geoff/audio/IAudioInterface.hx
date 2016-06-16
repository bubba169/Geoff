package geoff.audio;

/**
 * @author Simon
 */
interface IAudioInterface 
{
	function init() : Void;
	function load( file : String ) : AudioSource;
	function unload( source : AudioSource ) : Void;
	function playOneShot( source : AudioSource, volume : Float = 1 ) : AudioChannel;
	function playLooping( source : AudioSource, volume : Float = 1 ) : AudioChannel;
	function stop( channel : AudioChannel ) : Void;
}