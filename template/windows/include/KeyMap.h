#ifndef __GEOFF_KEYMAP_INCLUDED
#define __GEOFF_KEYMAP_INCLUDED

#define GLEW_STATIC

#include <glfw/glfw3.h>

namespace geoff {

	class KeyMap_obj
	{

		public:

			const static int SPACE = GLFW_KEY_SPACE;
			const static int APOSTROPHE = GLFW_KEY_APOSTROPHE;  /* ' */
			const static int COMMA = GLFW_KEY_COMMA;  /* , */
			const static int MINUS = GLFW_KEY_MINUS;  /* - */
			const static int PERIOD = GLFW_KEY_PERIOD;  /* . */
			const static int SLASH = GLFW_KEY_SLASH;  /* / */
			const static int ZERO = GLFW_KEY_0;
			const static int ONE = GLFW_KEY_1;
			const static int TWO = GLFW_KEY_2;
			const static int THREE = GLFW_KEY_3;
			const static int FOUR = GLFW_KEY_4;
			const static int FIVE = GLFW_KEY_5;
			const static int SIX = GLFW_KEY_6;
			const static int SEVEN = GLFW_KEY_7;
			const static int EIGHT = GLFW_KEY_8;
			const static int NINE = GLFW_KEY_9;
			const static int SEMICOLON = GLFW_KEY_SEMICOLON;  /* ; */
			const static int EQUAL = GLFW_KEY_EQUAL;  /* = */
			const static int A = GLFW_KEY_A;
			const static int B = GLFW_KEY_B;
			const static int C = GLFW_KEY_C;
			const static int D = GLFW_KEY_D;
			const static int E = GLFW_KEY_E;
			const static int F = GLFW_KEY_F;
			const static int G = GLFW_KEY_G;
			const static int H = GLFW_KEY_H;
			const static int I = GLFW_KEY_I;
			const static int J = GLFW_KEY_J;
			const static int K = GLFW_KEY_K;
			const static int L = GLFW_KEY_L;
			const static int M = GLFW_KEY_M;
			const static int N = GLFW_KEY_N;
			const static int O = GLFW_KEY_O;
			const static int P = GLFW_KEY_P;
			const static int Q = GLFW_KEY_Q;
			const static int R = GLFW_KEY_R;
			const static int S = GLFW_KEY_S;
			const static int T = GLFW_KEY_T;
			const static int U = GLFW_KEY_U;
			const static int V = GLFW_KEY_V;
			const static int W = GLFW_KEY_W;
			const static int X = GLFW_KEY_X;
			const static int Y = GLFW_KEY_Y;
			const static int Z = GLFW_KEY_Z;
			const static int LEFT_BRACKET = GLFW_KEY_LEFT_BRACKET;  /* [ */
			const static int BACKSLASH = GLFW_KEY_BACKSLASH;  /* \ */
			const static int RIGHT_BRACKET = GLFW_KEY_RIGHT_BRACKET;  /* ] */
			const static int GRAVE_ACCENT = GLFW_KEY_GRAVE_ACCENT;  /* ` */

			/* Function keys */
			const static int ESCAPE = GLFW_KEY_ESCAPE;
			const static int ENTER = GLFW_KEY_ENTER;
			const static int TAB = GLFW_KEY_TAB;
			const static int BACKSPACE = GLFW_KEY_BACKSPACE;
			const static int INSERT = GLFW_KEY_INSERT;
			const static int DELETE = GLFW_KEY_DELETE;
			const static int RIGHT = GLFW_KEY_RIGHT;
			const static int LEFT = GLFW_KEY_LEFT;
			const static int DOWN = GLFW_KEY_DOWN;
			const static int UP = GLFW_KEY_UP;
			const static int PAGE_UP = GLFW_KEY_PAGE_UP;
			const static int PAGE_DOWN = GLFW_KEY_PAGE_DOWN;
			const static int HOME = GLFW_KEY_HOME;
			const static int END = GLFW_KEY_END;
			const static int CAPS_LOCK = GLFW_KEY_CAPS_LOCK;
			const static int SCROLL_LOCK = GLFW_KEY_SCROLL_LOCK;
			const static int NUM_LOCK = GLFW_KEY_NUM_LOCK;
			const static int PRINT_SCREEN = GLFW_KEY_PRINT_SCREEN;
			const static int PAUSE = GLFW_KEY_PAUSE;
			const static int F1 = GLFW_KEY_F1;
			const static int F2 = GLFW_KEY_F2;
			const static int F3 = GLFW_KEY_F3;
			const static int F4 = GLFW_KEY_F4;
			const static int F5 = GLFW_KEY_F5;
			const static int F6 = GLFW_KEY_F6;
			const static int F7 = GLFW_KEY_F7;
			const static int F8 = GLFW_KEY_F8;
			const static int F9 = GLFW_KEY_F9;
			const static int F10 = GLFW_KEY_F10;
			const static int F11 = GLFW_KEY_F11;
			const static int F12 = GLFW_KEY_F12;
			const static int NUMPAD_0 = GLFW_KEY_KP_0;
			const static int NUMPAD_1 = GLFW_KEY_KP_1;
			const static int NUMPAD_2 = GLFW_KEY_KP_2;
			const static int NUMPAD_3 = GLFW_KEY_KP_3;
			const static int NUMPAD_4 = GLFW_KEY_KP_4;
			const static int NUMPAD_5 = GLFW_KEY_KP_5;
			const static int NUMPAD_6 = GLFW_KEY_KP_6;
			const static int NUMPAD_7 = GLFW_KEY_KP_7;
			const static int NUMPAD_8 = GLFW_KEY_KP_8;
			const static int NUMPAD_9 = GLFW_KEY_KP_9;
			const static int NUMPAD_DECIMAL = GLFW_KEY_KP_DECIMAL;
			const static int NUMPAD_DIVIDE = GLFW_KEY_KP_DIVIDE;
			const static int NUMPAD_MULTIPLY = GLFW_KEY_KP_MULTIPLY;
			const static int NUMPAD_SUBTRACT = GLFW_KEY_KP_SUBTRACT;
			const static int NUMPAD_ADD = GLFW_KEY_KP_ADD;
			const static int NUMPAD_ENTER = GLFW_KEY_KP_ENTER;
			const static int NUMPAD_EQUAL = GLFW_KEY_KP_EQUAL;
			const static int LEFT_SHIFT = GLFW_KEY_LEFT_SHIFT;
			const static int LEFT_CONTROL = GLFW_KEY_LEFT_CONTROL;
			const static int LEFT_ALT = GLFW_KEY_LEFT_ALT;
			const static int LEFT_SUPER = GLFW_KEY_LEFT_SUPER;
			const static int RIGHT_SHIFT = GLFW_KEY_RIGHT_SHIFT;
			const static int RIGHT_CONTROL = GLFW_KEY_RIGHT_CONTROL;
			const static int RIGHT_ALT = GLFW_KEY_RIGHT_ALT;
			const static int RIGHT_SUPER = GLFW_KEY_RIGHT_SUPER;
			const static int MENU = GLFW_KEY_MENU;	
			
			const static int BACK = GLFW_KEY_ESCAPE;

	};
};

#endif

