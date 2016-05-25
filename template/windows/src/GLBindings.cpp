#include <glfw/glfw3.h>
#include <GLBindings.h>

namespace geoff {

	void GLBindings::clear( int mask )
	{
		glClear( mask );
	}

	void GLBindings::clearColor( float r, float g, float b, float a )
	{
		glClearColor( r, g, b, a );
	}
	
	int GLBindings::createBuffer()
	{
		GLuint buffer;
		glGenBuffers(1, &buffer);
		return buffer;
	}

}

