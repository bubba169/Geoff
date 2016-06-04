package geoff.platform.windows;
import geoff.event.EventManager;

/**
 * ...
 * @author Simon
 */

@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/../template/windows/include'/></files>")
 
class WindowsPlatform
{

	public var name : String = "Windows";
	
	public var renderer : WindowsRenderer;
	public var eventManager : EventManager;
	
	public function new()
	{
		renderer = new WindowsRenderer();
		eventManager = new EventManager();
	}
	
}