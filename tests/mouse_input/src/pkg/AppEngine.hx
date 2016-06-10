package pkg;

import geoff.event.Key;
import geoff.event.PointerButton.PointerButton;
import geoff.renderer.IRenderContext;
import geoff.renderer.RenderBatch;
import geoff.utils.Assets;
import geoff.utils.Color;
import uk.co.mojaworks.norman.NormanApp;
import uk.co.mojaworks.norman.data.NormanConfigData;
import uk.co.mojaworks.norman.factory.GameObject;
import uk.co.mojaworks.norman.factory.SpriteFactory;

/**
 * ...
 * @author ...
 */
class AppEngine extends NormanApp
{
	var shader : Int;
	var batch:RenderBatch;
	
	var _width : Int = 640;
	var _height : Int = 480;

	public function new() 
	{
		var config : NormanConfigData = new NormanConfigData();
		config.targetScreenHeight = 720;
		config.targetScreenWidth = 1280;
		
		super( config );
	}
	
	override function onStartupComplete() 
	{
		super.onStartupComplete();
		
		var fb : GameObject = SpriteFactory.createRenderTexture( 200, 200, "render" );
		fb.add( new UIListener() );
		fb.transform.x = 200;
		//fb.transform.rotationDegrees = 45;
		core.view.root.transform.addChild( fb.transform );
		
		var square : GameObject = SpriteFactory.createImageSpriteFromAsset( Assets.getPath("test/bug.png"), "image" );
		square.transform.rotationDegrees = 45;
		fb.transform.addChild( square.transform );
	}
	
	
	
}