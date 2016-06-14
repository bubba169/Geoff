package geoff.platform.windows;
import geoff.event.EventManager;
import geoff.platform.desktop.DesktopRenderer;
import haxe.Timer;

/**
 * ...
 * @author Simon
 */

@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/../template/windows/include'/></files>")
 
class WindowsPlatform implements IPlatform
{

	public var name : String = "Windows";
	
	public var renderer : DesktopRenderer;
	public var eventManager : EventManager;
	public var shouldExit : Bool = false;
	
	public function new()
	{
		renderer = new DesktopRenderer();
		eventManager = new EventManager();
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