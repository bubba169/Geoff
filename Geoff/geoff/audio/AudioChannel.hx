package geoff.audio;

/**
 * ...
 * @author Simon
 */
class AudioChannel
{

	public var position : Int = 0;
	public var source : AudioSource;
	public var volume : Float = 1;
	public var looping : Bool = false;
	public var complete : Bool = false;
	public var paused : Bool = false;
	
	public function new() 
	{
		
	}
	
}