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
import uk.co.mojaworks.norman.factory.UIFactory;
import uk.co.mojaworks.norman.components.renderer.ShapeRenderer;

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

		var arr : Array<Int> = [];
		arr.push( 123 );
		trace( arr );

		var square : GameObject = SpriteFactory.createFilledSprite( Color.BLUE, 100, 100 );
		square.transform.x = 300;
		square.transform.y = 300;
		square.add( new SquareAnimation() );
		core.view.root.transform.addChild( square.transform );

		//var fps : GameObject = UIFactory.createFPS();
		//core.view.root.transform.addChild( fps.transform );
	}



}
