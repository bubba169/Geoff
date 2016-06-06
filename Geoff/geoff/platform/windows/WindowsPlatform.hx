package geoff.platform.windows;
import geoff.event.EventManager;
import geoff.platform.desktop.DesktopRenderer;

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
	
	public function new()
	{
		renderer = new DesktopRenderer();
		eventManager = new EventManager();
	}
	
}