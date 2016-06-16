package geoff.platform.windows;
import geoff.event.EventManager;
import geoff.platform.desktop.DesktopAudioInterface;
import geoff.platform.desktop.DesktopRenderer;
import haxe.Timer;

/**
 * ...
 * @author Simon
 */

@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/../template/windows/include'/></files>")
 
class WindowsPlatform
{

	public var name : String = "Windows";
	
	public var renderer : DesktopRenderer;
	public var eventManager : EventManager;
	public var audio : DesktopAudioInterface;
	public var shouldExit : Bool = false;
	
	public function new()
	{
		renderer = new DesktopRenderer();
		eventManager = new EventManager();
		audio = new DesktopAudioInterface();
	}
	
	public function getTime() : Float
	{
		return Timer.stamp();
	}
	
	public function exit() : Void 
	{
		shouldExit = true;
	}
	
}