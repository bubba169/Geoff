package geoff.event;

/**
 * ...
 * @author Simon
 */

#if windows
	typedef Key = geoff.platform.desktop.DesktopKeyMap;
#elseif android
	typedef Key = geoff.platform.android.AndroidKeyMap;
#end
