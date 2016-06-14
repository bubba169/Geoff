package geoff.platform.android;
import geoff.event.EventManager;
import geoff.platform.android.AndroidRenderer;

import android.app.Activity;
import java.lang.System;

/**
 * This is a static class that will give access to all of the platform dependant features
 * @author Simon
 */
class AndroidPlatform
{
	public var name : String = "Android";
	
	public var renderer : AndroidRenderer;
	public var eventManager : EventManager;
	public var nativeActivity : GeoffActivity;
	
	public function new()
	{
		renderer = new AndroidRenderer();
		eventManager = new EventManager();
	}
	
	public function setActivity( activity : GeoffActivity ) : Void
	{
		this.nativeActivity = activity;
	}
	
	public function getTime() : Float
	{
		return cast( System.currentTimeMillis(), Float ) / 1000.0;
	}
	
	public function showKeyboard() : Void
	{
		nativeActivity.showKeyboard();
	}
	
	public function hideKeyboard() : Void
	{
		nativeActivity.hideKeyboard();
	}
	
	public function exit() : Void
	{
		nativeActivity.finish();
	}
}