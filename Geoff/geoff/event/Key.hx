package geoff.event;

/**
 * ...
 * @author Simon
 */

#if windows
	typedef Key = geoff.platform.desktop.externs.DesktopKeyMap;
#elseif android
	typedef Key = geoff.platform.android.AndroidKeyMap;
#end
