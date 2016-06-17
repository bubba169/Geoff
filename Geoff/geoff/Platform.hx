package geoff;

/**
 * ...
 * @author Simon
 */

#if android
	typedef Platform = geoff.platform.android.AndroidPlatform;
#elseif windows
	typedef Platform = geoff.platform.windows.WindowsPlatform;
#elseif ios
	typedef Platform = geoff.platform.ios.IOSPlatform;
#end
