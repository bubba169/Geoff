#include <GeoffRenderer.h>

namespace geoff
{
	void GeoffRenderer::clear( float r, float g, float b, float a )
	{
		glClearColor( r, g, b, a );
		glClear( GL_COLOR_BUFFER_BIT );
	}
}