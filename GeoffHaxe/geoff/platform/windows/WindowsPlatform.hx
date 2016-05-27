package geoff.platform.windows;

/**
 * ...
 * @author Simon
 */

@:buildXml("<files id='haxe'><compilerflag value='-I${haxelib:geoff}/template/windows/include'/></files>")
 
class WindowsPlatform
{

	public var name : String = "Windows";
	
	public var gl : WindowsGLContext;
	public var eventManager : WindowsEventManager;
	
	public function new()
	{
		gl = new WindowsGLContext();
		eventManager = new WindowsEventManager();
	}
	
}