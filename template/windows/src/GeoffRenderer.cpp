#include <GeoffRenderer.h>

namespace geoff
{
	
	GeoffRenderer::GeoffRenderer()
	{
		glGenBuffers( 1, &_vertexBuffer );
		glGenBuffers( 1, &_indexBuffer );
		
		// Setup projection matrix
		for ( int i = 0; i < 16; i++ )
		{
			_projection[i] = 0;
		}
		_projection[15] = 1;
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
	
	int GeoffRenderer::compileShader( ::String* vsSource, ::String* fsSource )
	{
		GLint status = 0;
		
		GLuint vs = glCreateShader( GL_VERTEX_SHADER );
		const char* vsSourceCStr = vsSource->__CStr();
		glShaderSource( vs, 1, &vsSourceCStr, &(vsSource->length) );
		glCompileShader( vs );
		glGetShaderiv( vs, GL_COMPILE_STATUS, &status );
		
		if ( status == 0 ) 
		{
			// There was a problem compiling the vertex shader
			glDeleteShader( vs );
			return -1;
		}
		
		GLuint fs = glCreateShader( GL_FRAGMENT_SHADER );
		const char* fsSourceCStr = fsSource->__CStr();
		glShaderSource( fs, 1, &fsSourceCStr, &(fsSource->length) );
		glCompileShader( fs );
		glGetShaderiv( vs, GL_COMPILE_STATUS, &status );
		
		if ( status == 0 ) 
		{
			// There was a problem compiling the fragment shader
			glDeleteShader( vs );
			glDeleteShader( fs );
			return -2;
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
			return -5;
		}		
		
		return program;
	}
	
	
	void GeoffRenderer::beginRender( int w, int h )
	{
		_w = w;
		_h = h;		
		
		_setupViewport( w, h, false );
		glEnable( GL_BLEND );
		glBlendFunc( GL_ONE, GL_ONE_MINUS_SRC_ALPHA );
	}
	
	
	void GeoffRenderer::renderBatch( geoff::renderer::RenderBatch batch )
	{
		//void* vertices = batch->getRawVertices();
		glBindBuffer( GL_ARRAY_BUFFER, _vertexBuffer );
		glBufferData( GL_ARRAY_BUFFER, batch->vertices->length * 4, &(batch->vertices[0]), GL_STREAM_DRAW );
		
		//void* indexes = batch->getRawIndexes();
		glBindBuffer( GL_ELEMENT_ARRAY_BUFFER, _indexBuffer );
		glBufferData( GL_ELEMENT_ARRAY_BUFFER, batch->indexes->length * 4, &(batch->indexes[0]), GL_STREAM_DRAW );
		
		glUseProgram( batch->shader->program );
		
		int projectionUniform = glGetUniformLocation( batch->shader->program, "uProjectionMatrix" );
		glUniformMatrix4fv( projectionUniform, 1, GL_FALSE, _projection );
				
		int vertexAttribute = glGetAttribLocation( batch->shader->program, "aVertexPosition" );
		glEnableVertexAttribArray( vertexAttribute );
		glVertexAttribPointer( vertexAttribute, 2, GL_FLOAT, GL_FALSE, 0, 0 );
				
		glDrawElements( GL_TRIANGLES, batch->indexes->length, GL_UNSIGNED_INT, 0 );
		
		glDisableVertexAttribArray( vertexAttribute );
		glUseProgram( 0 );
		glBindBuffer( GL_ARRAY_BUFFER, 0 );
		glBindBuffer( GL_ELEMENT_ARRAY_BUFFER, 0 );
		
	}
	
	
	int GeoffRenderer::getError()
	{
		return glGetError();
	}
	
	/**
	 * Privates
	 */
	
	void GeoffRenderer::_setupViewport( int w, int h, bool flipY )
	{
		glViewport( 0, 0, w, h );
		
		float sx = 1.0 / w;
		float sy = (1.0 / h) * ((flipY)?-1:1);
		
		_projection[0] = 2.0 * sx;
		_projection[5] = 2.0 * sy;
		_projection[10] = -2.0 * 0.5;
		_projection[12] = -w * sx;
		_projection[13] = -h * sy;
		
	}
	
}