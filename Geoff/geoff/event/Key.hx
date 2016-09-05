package geoff.event;

/**
 * ...
 * @author Simon
 */

#if desktop
	typedef Key = geoff.platform.keymap.DesktopKeyMap;
#elseif android
	typedef Key = geoff.platform.keymap.AndroidKeyMap;
#elseif ios
	typedef Key = geoff.platform.keymap.IOSKeyMap;
#end
