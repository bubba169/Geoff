#include <GeoffRenderer.h>

namespace geoff
{
	void GeoffRenderer_obj::clear( float r, float g, float b, float a )
	{
		glClearColor( r, g, b, a );
		glClear( GL_COLOR_BUFFER_BIT );
	}
	
	int GeoffRenderer_obj::compileShader( ::String vsSource, ::String fsSource )
	{
		GLuint vs = glCreateShader( GL_VERTEX_SHADER );
		const char* vsSourceCStr = vsSource.__CStr();
		glShaderSource( vs, 1, &vsSourceCStr, &vsSource.length );
		
		return 0;
	}
}