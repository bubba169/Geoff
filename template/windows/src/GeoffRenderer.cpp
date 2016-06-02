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
		_projection[10] = -1;
		
		_id = rand() % 1000;
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
		
		_setupViewport( w, h, true );
		glEnable( GL_BLEND );
		glBlendFunc( GL_ONE, GL_ONE_MINUS_SRC_ALPHA );
	}
	
	
	void GeoffRenderer::renderBatch( geoff::renderer::RenderBatch batch )
	{
		float* vertices = (float*)&(batch->getRawVertices()[0]);
		glBindBuffer( GL_ARRAY_BUFFER, _vertexBuffer );
		glBufferData( GL_ARRAY_BUFFER, batch->vertices->length * 4, vertices, GL_STREAM_DRAW );
		
		unsigned short* indexes = (unsigned short*)&(batch->getRawIndexes()[0]);
		glBindBuffer( GL_ELEMENT_ARRAY_BUFFER, _indexBuffer );
		glBufferData( GL_ELEMENT_ARRAY_BUFFER, batch->indexes->length * 2, indexes, GL_STREAM_DRAW );
		
		glUseProgram( batch->shader->program );		
		
		int projectionUniform = glGetUniformLocation( batch->shader->program, "uProjectionMatrix" );
		glUniformMatrix4fv( projectionUniform, 1, GL_FALSE, _projection );
		

		for ( int i = 0; i < batch->textures->length; ++i ) {

			char texName[50];
			snprintf( texName, 50, "uTexture%i", 1);
			
			int uTexture = glGetUniformLocation( batch->shader->program, texName );
			glActiveTexture( GL_TEXTURE0 + i );
						
			glBindTexture( GL_TEXTURE_2D, ((geoff::renderer::Texture)(batch->textures[i]))->id );
			glUniform1i( uTexture, i );
			
		}
		
		
		int* attribs = new int[ batch->shader->attributes->length ];
		int attribCounter = 0;
		for ( int i = 0; i < batch->shader->attributes->length; ++i )
		{
			geoff::renderer::ShaderAttribute attribute = batch->shader->attributes[i];
			int vertexAttribute = glGetAttribLocation( batch->shader->program, attribute->name.__CStr() );
			
			if ( vertexAttribute != -1 ) {
				int offset = (attribute->start) * 4;
				glEnableVertexAttribArray( vertexAttribute );
				glVertexAttribPointer( vertexAttribute, attribute->size, GL_FLOAT, GL_FALSE, batch->shader->vertexSize * 4, (void*)offset );
				attribs[attribCounter] = vertexAttribute;
				attribCounter++;
			}
		}
				
		glDrawElements( GL_TRIANGLES, batch->indexes->length, GL_UNSIGNED_SHORT, 0 );
		
		for ( int i = 0; i < attribCounter; ++i )
		{
			glDisableVertexAttribArray( attribs[i] );
		}
		
	
		for ( int i = 0; i < batch->textures->length; ++i ) {
			glActiveTexture( GL_TEXTURE0 + i );
			glBindTexture( GL_TEXTURE_2D, 0 );
		}
		
		glUseProgram( 0 );
		glBindBuffer( GL_ARRAY_BUFFER, 0 );
		glBindBuffer( GL_ELEMENT_ARRAY_BUFFER, 0 );
		delete[] attribs;
		
	}
	
	void GeoffRenderer::endRender()
	{
	}
	
	
	int GeoffRenderer::getError()
	{
		return glGetError();
	}
	
	
	void GeoffRenderer::createTexture( ::String* filepath, geoff::renderer::Texture texture )
	{
		unsigned int imageName;
		ilGenImages( 1, &imageName );
		ilBindImage( imageName );		
		ilLoadImage( filepath->__CStr() );
		
		texture->width = ilGetInteger( IL_IMAGE_WIDTH );
		texture->height = ilGetInteger( IL_IMAGE_HEIGHT );
		
		glGenTextures( 1, (GLuint*)&(texture->id) );
		glBindTexture( GL_TEXTURE_2D, texture->id );
		
		glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE );
		glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE );
		glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
		glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
		
		char* buffer = new char[texture->width * texture->height * 4];	
		ilCopyPixels( 0, 0, 0, texture->width, texture->height, 1, IL_RGBA, IL_UNSIGNED_BYTE, buffer );
		
		glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, texture->width, texture->height, 0, GL_RGBA, GL_UNSIGNED_BYTE, buffer );
		
		glBindTexture( GL_TEXTURE_2D, 0 );
		ilBindImage(0);
		ilDeleteImages( 1, &imageName );
		delete[] buffer;
		
	}
	
	
	/**
	 * Privates
	 */
	
	void GeoffRenderer::_setupViewport( int w, int h, bool flipY )
	{
		
		glViewport( 0, 0, w, h );
		
		float sx = 1.0f / w;
		float sy = (1.0f / h) * ((flipY)?-1:1);
		
		_projection[0] = 2.0f * sx;
		_projection[5] = 2.0f * sy;
		_projection[12] = -w * sx;
		_projection[13] = -h * sy;
				
	}
	
}