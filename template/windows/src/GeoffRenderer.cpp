#include <GeoffRenderer.h>

namespace geoff
{
	
	GeoffRenderer::GeoffRenderer()
	{
		glGenBuffers( 1, &_vertexBuffer );
		glGenBuffers( 1, &_indexBuffer );
	}
	
	GeoffRenderer::~GeoffRenderer()
	{
		glDeleteBuffers( 1, &_vertexBuffer );
		glDeleteBuffers( 1, &_indexBuffer );
	}
	
	void GeoffRenderer::clear( float r, float g, float b, float a )
	{
		glClearColor( r, g, b, a );
		glClear( GL_COLOR_BUFFER_BIT );
	}
	
	int GeoffRenderer::compileShader( ::String vsSource, ::String fsSource )
	{
		GLint status = 0;
		
		GLuint vs = glCreateShader( GL_VERTEX_SHADER );
		const char* vsSourceCStr = vsSource.__CStr();
		glShaderSource( vs, 1, &vsSourceCStr, &vsSource.length );
		glCompileShader( vs );
		glGetShaderiv( vs, GL_COMPILE_STATUS, &status );
		
		if ( status == 0 ) 
		{
			// There was a problem compiling the vertex shader
			glDeleteShader( vs );
			return -1;
		}
		
		GLuint fs = glCreateShader( GL_FRAGMENT_SHADER );
		const char* fsSourceCStr = fsSource.__CStr();
		glShaderSource( fs, 1, &fsSourceCStr, &fsSource.length );
		glCompileShader( fs );
		glGetShaderiv( vs, GL_COMPILE_STATUS, &status );
		
		if ( status == 0 ) 
		{
			// There was a problem compiling the fragment shader
			glDeleteShader( vs );
			glDeleteShader( fs );
			return 2;
		}
		
		GLuint program = glCreateProgram();
		glAttachShader( program, vs );
		glAttachShader( program, fs );
		glLinkProgram( program );
		glGetProgramiv( program, GL_LINK_STATUS, &status );
		
		glDeleteShader( vs );
		glDeleteShader( fs );
		
		if ( status == 0 ) 
		{
			// There was a problem linking the shader
			glDeleteProgram( program );
			return -3;
		}		
		
		return program;
	}
}