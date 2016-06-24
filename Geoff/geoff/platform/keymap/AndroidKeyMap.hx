package geoff.platform.keymap;

import android.view.KeyEvent;

/**
 * ...
 * @author Simon
 */
class AndroidKeyMap
{

	/* Printable keys */
	public static var SPACE : Int = KeyEvent.KEYCODE_SPACE;
	public static var APOSTROPHE : Int = KeyEvent.KEYCODE_APOSTROPHE;  /* ' */
	public static var COMMA : Int = KeyEvent.KEYCODE_COMMA;  /* , */
	public static var MINUS : Int = KeyEvent.KEYCODE_MINUS;  /* - */
	public static var PERIOD : Int = KeyEvent.KEYCODE_PERIOD;  /* . */
	public static var SLASH : Int = KeyEvent.KEYCODE_SLASH;  /* / */
	public static var ZERO : Int = KeyEvent.KEYCODE_0;
	public static var ONE : Int = KeyEvent.KEYCODE_1;
	public static var TWO : Int = KeyEvent.KEYCODE_2;
	public static var THREE : Int = KeyEvent.KEYCODE_3;
	public static var FOUR : Int = KeyEvent.KEYCODE_4;
	public static var FIVE : Int = KeyEvent.KEYCODE_5;
	public static var SIX : Int = KeyEvent.KEYCODE_6;
	public static var SEVEN : Int = KeyEvent.KEYCODE_7;
	public static var EIGHT : Int = KeyEvent.KEYCODE_8;
	public static var NINE : Int = KeyEvent.KEYCODE_9;
	public static var SEMICOLON : Int = KeyEvent.KEYCODE_SEMICOLON;  /* ; */
	public static var EQUAL : Int = KeyEvent.KEYCODE_EQUALS;  /* = */
	public static var A : Int = KeyEvent.KEYCODE_A;
	public static var B : Int = KeyEvent.KEYCODE_B;
	public static var C : Int = KeyEvent.KEYCODE_C;
	public static var D : Int = KeyEvent.KEYCODE_D;
	public static var E : Int = KeyEvent.KEYCODE_E;
	public static var F : Int = KeyEvent.KEYCODE_F;
	public static var G : Int = KeyEvent.KEYCODE_G;
	public static var H : Int = KeyEvent.KEYCODE_H;
	public static var I : Int = KeyEvent.KEYCODE_I;
	public static var J : Int = KeyEvent.KEYCODE_J;
	public static var K : Int = KeyEvent.KEYCODE_K;
	public static var L : Int = KeyEvent.KEYCODE_L;
	public static var M : Int = KeyEvent.KEYCODE_M;
	public static var N : Int = KeyEvent.KEYCODE_N;
	public static var O : Int = KeyEvent.KEYCODE_O;
	public static var P : Int = KeyEvent.KEYCODE_P;
	public static var Q : Int = KeyEvent.KEYCODE_Q;
	public static var R : Int = KeyEvent.KEYCODE_R;
	public static var S : Int = KeyEvent.KEYCODE_S;
	public static var T : Int = KeyEvent.KEYCODE_T;
	public static var U : Int = KeyEvent.KEYCODE_U;
	public static var V : Int = KeyEvent.KEYCODE_V;
	public static var W : Int = KeyEvent.KEYCODE_W;
	public static var X : Int = KeyEvent.KEYCODE_X;
	public static var Y : Int = KeyEvent.KEYCODE_Y;
	public static var Z : Int = KeyEvent.KEYCODE_Z;
	public static var LEFT_BRACKET : Int = KeyEvent.KEYCODE_LEFT_BRACKET;  /* [ */
	public static var BACKSLASH : Int = KeyEvent.KEYCODE_BACKSLASH;  /* \ */
	public static var RIGHT_BRACKET : Int = KeyEvent.KEYCODE_RIGHT_BRACKET;  /* ] */
	public static var GRAVE_ACCENT : Int = KeyEvent.KEYCODE_GRAVE;  /* ` */

	/* Function keys */
	public static var ESCAPE : Int = KeyEvent.KEYCODE_ESCAPE;
	public static var ENTER : Int = KeyEvent.KEYCODE_ENTER;
	public static var TAB : Int = KeyEvent.KEYCODE_TAB;
	public static var BACKSPACE : Int = KeyEvent.KEYCODE_DEL;
	public static var INSERT : Int = KeyEvent.KEYCODE_INSERT;
	public static var DELETE : Int = KeyEvent.KEYCODE_DEL;
	public static var RIGHT : Int = KeyEvent.KEYCODE_DPAD_RIGHT;
	public static var LEFT : Int = KeyEvent.KEYCODE_DPAD_LEFT;
	public static var DOWN : Int = KeyEvent.KEYCODE_DPAD_DOWN;
	public static var UP : Int = KeyEvent.KEYCODE_DPAD_UP;
	public static var PAGE_UP : Int = KeyEvent.KEYCODE_PAGE_UP;
	public static var PAGE_DOWN : Int = KeyEvent.KEYCODE_PAGE_DOWN;
	public static var HOME : Int = KeyEvent.KEYCODE_MOVE_HOME;
	public static var END : Int = KeyEvent.KEYCODE_MOVE_END;
	public static var CAPS_LOCK : Int = KeyEvent.KEYCODE_CAPS_LOCK;
	public static var SCROLL_LOCK : Int = KeyEvent.KEYCODE_SCROLL_LOCK;
	public static var NUM_LOCK : Int = KeyEvent.KEYCODE_NUM_LOCK;
	public static var PRINT_SCREEN : Int = KeyEvent.KEYCODE_SYSRQ;
	public static var PAUSE : Int = KeyEvent.KEYCODE_BREAK;
	public static var F1 : Int = KeyEvent.KEYCODE_F1;
	public static var F2 : Int = KeyEvent.KEYCODE_F2;
	public static var F3 : Int = KeyEvent.KEYCODE_F3;
	public static var F4 : Int = KeyEvent.KEYCODE_F4;
	public static var F5 : Int = KeyEvent.KEYCODE_F5;
	public static var F6 : Int = KeyEvent.KEYCODE_F6;
	public static var F7 : Int = KeyEvent.KEYCODE_F7;
	public static var F8 : Int = KeyEvent.KEYCODE_F8;
	public static var F9 : Int = KeyEvent.KEYCODE_F9;
	public static var F10 : Int = KeyEvent.KEYCODE_F10;
	public static var F11 : Int = KeyEvent.KEYCODE_F11;
	public static var F12 : Int = KeyEvent.KEYCODE_F12;
	public static var NUMPAD_0 : Int = KeyEvent.KEYCODE_NUMPAD_0;
	public static var NUMPAD_1 : Int = KeyEvent.KEYCODE_NUMPAD_1;
	public static var NUMPAD_2 : Int = KeyEvent.KEYCODE_NUMPAD_2;
	public static var NUMPAD_3 : Int = KeyEvent.KEYCODE_NUMPAD_3;
	public static var NUMPAD_4 : Int = KeyEvent.KEYCODE_NUMPAD_4;
	public static var NUMPAD_5 : Int = KeyEvent.KEYCODE_NUMPAD_5;
	public static var NUMPAD_6 : Int = KeyEvent.KEYCODE_NUMPAD_6;
	public static var NUMPAD_7 : Int = KeyEvent.KEYCODE_NUMPAD_7;
	public static var NUMPAD_8 : Int = KeyEvent.KEYCODE_NUMPAD_8;
	public static var NUMPAD_9 : Int = KeyEvent.KEYCODE_NUMPAD_9;
	public static var NUMPAD_DECIMAL : Int = KeyEvent.KEYCODE_NUMPAD_DOT;
	public static var NUMPAD_DIVIDE : Int = KeyEvent.KEYCODE_NUMPAD_DIVIDE;
	public static var NUMPAD_MULTIPLY : Int = KeyEvent.KEYCODE_NUMPAD_MULTIPLY;
	public static var NUMPAD_SUBTRACT : Int = KeyEvent.KEYCODE_NUMPAD_SUBTRACT;
	public static var NUMPAD_ADD : Int = KeyEvent.KEYCODE_NUMPAD_ADD;
	public static var NUMPAD_ENTER : Int = KeyEvent.KEYCODE_NUMPAD_ENTER;
	public static var NUMPAD_EQUAL : Int = KeyEvent.KEYCODE_NUMPAD_EQUALS;
	public static var LEFT_SHIFT : Int = KeyEvent.KEYCODE_SHIFT_LEFT;
	public static var LEFT_CONTROL : Int = KeyEvent.KEYCODE_CTRL_LEFT;
	public static var LEFT_ALT : Int = KeyEvent.KEYCODE_ALT_LEFT;
	public static var LEFT_SUPER : Int = KeyEvent.KEYCODE_META_LEFT;
	public static var RIGHT_SHIFT : Int = KeyEvent.KEYCODE_SHIFT_RIGHT;
	public static var RIGHT_CONTROL : Int = KeyEvent.KEYCODE_CTRL_RIGHT;
	public static var RIGHT_ALT : Int = KeyEvent.KEYCODE_ALT_RIGHT;
	public static var RIGHT_SUPER : Int = KeyEvent.KEYCODE_META_RIGHT;
	public static var MENU : Int = KeyEvent.KEYCODE_MENU;	
	
	public static var BACK : Int = KeyEvent.KEYCODE_BACK;
	
}