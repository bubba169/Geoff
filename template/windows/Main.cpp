#include <glfw/glfw3.h>
#include <geoff/App.h>

extern "C" const char *hxRunLibrary();
extern "C" void hxcpp_set_top_of_stack();

int main( void )
{
	GLFWwindow* window;

	if (!glfwInit()) return -1;

	window = glfwCreateWindow(640, 480, "Hello World", NULL, NULL);
	if (!window)
	{
		glfwTerminate();
		return -1;
	}

	glfwMakeContextCurrent(window);

	hxcpp_set_top_of_stack();
	hxRunLibrary();

	geoff::App& app = geoff::App_obj::current;
	app->init();

	while (!glfwWindowShouldClose(window))
	{
		app->render();

		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	glfwTerminate();

	return 0;
}