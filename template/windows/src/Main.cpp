#define GLEW_STATIC

#include <glew/glew.h>
#include <glfw/glfw3.h>
#include <geoff/App.h>
#include <geoff/platform/windows/WindowsPlatform.h>
#include <geoff/event/EventManager.h>
#include <IL/il.h>

#ifdef _WIN32
	#include <Windows.h>
#endif

extern "C" const char *hxRunLibrary();
extern "C" void hxcpp_set_top_of_stack();

geoff::App geoff_app;

/**
 * Callbacks
 */

void geoff_callback_framebuffer_size( GLFWwindow* window, int width, int height )
{
	Array< int > array = Array_obj< int >::__new();
	array->push(width);
	array->push(height);
	geoff_app->platform->eventManager->sendEventInt( ::String("Resize"), array );

}

void geoff_mouse_button_callback( GLFWwindow* window, int button, int action, int mods )
{
	double x, y;
	glfwGetCursorPos( window, &x, &y );
	
	Array< int > array = Array_obj< int >::__new();
	array->push(0);
	array->push(button);
	array->push(x);
	array->push(y);
	
	switch( action ) 
	{
		case GLFW_PRESS:
			geoff_app->platform->eventManager->sendEventInt( ::String("PointerDown"), array );
			break;
			
		case GLFW_RELEASE:
			geoff_app->platform->eventManager->sendEventInt( ::String("PointerUp"), array );
			break;
	}

}

void geoff_mouse_move_callback( GLFWwindow* window, double x, double y )
{
	Array< int > array = Array_obj< int >::__new();
	array->push(0);
	array->push((int)x);
	array->push((int)y);
	
	geoff_app->platform->eventManager->sendEventInt( ::String("PointerMove"), array );
}

void geoff_mouse_scroll_callback( GLFWwindow* window, double x, double y )
{
	Array< int > array = Array_obj< int >::__new();
	array->push(0);
	array->push((int)x);
	array->push((int)y);
	
	geoff_app->platform->eventManager->sendEventInt( ::String("PointerScroll"), array );
}


void geoff_key_callback( GLFWwindow* window, int key, int scancode, int action, int mods )
{	
	Array< int > array = Array_obj< int >::__new();
	array->push(key);
	array->push(mods);
	
	switch( action ) 
	{
		case GLFW_PRESS:
			geoff_app->platform->eventManager->sendEventInt( ::String("KeyDown"), array );
			break;
			
		case GLFW_RELEASE:
			geoff_app->platform->eventManager->sendEventInt( ::String("KeyUp"), array );
			break;
	}

}

void geoff_char_callback( GLFWwindow* window, unsigned int key )
{	
	Array< int > array = Array_obj< int >::__new();
	array->push(key);
	
	geoff_app->platform->eventManager->sendEventInt( ::String("TextEntry"), array );

}


/**
 * Main
 */
  
int main( void )
{
	
	GLFWwindow* window;

	if (!glfwInit()) return -1;

	window = glfwCreateWindow({{WindowWidth}}, {{WindowHeight}}, "Hello World", NULL, NULL);
	if (!window)
	{
		glfwTerminate();
		return -1;
	}

	glfwSetFramebufferSizeCallback( window, geoff_callback_framebuffer_size );
	glfwSetMouseButtonCallback( window, geoff_mouse_button_callback );
	glfwSetScrollCallback( window, geoff_mouse_scroll_callback );	
	glfwSetCursorPosCallback( window, geoff_mouse_move_callback );	
	glfwSetKeyCallback( window, geoff_key_callback );
	glfwSetCharCallback( window, geoff_char_callback );

	glfwMakeContextCurrent(window);
	
	glewInit();
	ilInit();
	
	hxcpp_set_top_of_stack();
	hxRunLibrary();

	geoff_app = geoff::App_obj::current;
	geoff_app->init();
	
	geoff_callback_framebuffer_size( window, {{WindowWidth}}, {{WindowHeight}} );

	while (!glfwWindowShouldClose(window))
	{
		geoff_app->update();

		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	geoff_app->destroy();
	glfwTerminate();

	return 0;
}

#ifdef _WIN32
int CALLBACK WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance, LPTSTR lpCmdLine, int nCmdShow )
{
	return main();
}
#endif


