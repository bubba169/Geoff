package geoff;

/**
 * ...
 * @author Simon
 */

#if android
	typedef Platform = geoff.platform.AndroidPlatform;
#elseif windows
	typedef Platform = geoff.platform.WindowsPlatform;
#elseif mac
	typedef Platform = geoff.platform.MacPlatform;
#elseif ios
	typedef Platform = geoff.platform.IOSPlatform;
#end
