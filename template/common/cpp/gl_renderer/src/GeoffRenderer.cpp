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
		
        _id = 0;//rand() % 1000;
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

	/**
	 * Shaders
	 */
	
	int GeoffRenderer::compileShader( geoff::renderer::Shader shader )
	{
		GLint status = 0;
		
		GLuint vs = glCreateShader( GL_VERTEX_SHADER );
		const char* vsSourceCStr = shader->vertexSource.__CStr();
		glShaderSource( vs, 1, &vsSourceCStr, &(shader->vertexSource.length) );
		glCompileShader( vs );
		glGetShaderiv( vs, GL_COMPILE_STATUS, &status );
		
		if ( status == 0 ) 
		{
			// There was a problem compiling the vertex shader
			glDeleteShader( vs );
			return -1;
		}
		
		GLuint fs = glCreateShader( GL_FRAGMENT_SHADER );
		const char* fsSourceCStr = shader->fragmentSource.__CStr();
		glShaderSource( fs, 1, &fsSourceCStr, &(shader->fragmentSource.length) );
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

		shader->program = program;	
		
		return 0;
	}

	void GeoffRenderer::destroyShader( geoff::renderer::Shader shader )
	{
		glDeleteProgram( shader->program );
	}
	
	
	/**
	 * Render
	 */

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
			printf( texName, 50, "uTexture%i", 1);
			
			int uTexture = glGetUniformLocation( batch->shader->program, texName );
			glActiveTexture( GL_TEXTURE0 + i );
						
			glBindTexture( GL_TEXTURE_2D, ((geoff::renderer::Texture)(batch->textures[i]))->textureId );
			glUniform1i( uTexture, i );
			
		}
		
		
		int* attribs = new int[ batch->shader->attributes->length ];
		int attribCounter = 0;
		for ( int i = 0; i < batch->shader->attributes->length; ++i )
		{
			geoff::renderer::ShaderAttribute attribute = batch->shader->attributes->__get((int)i).StaticCast<  ::geoff::renderer::ShaderAttribute >();
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
	

	/**
	 * Textures
	 */
	
	void GeoffRenderer::createTexture( geoff::renderer::Texture texture )
	{
		glGenTextures( 1, (GLuint*)&(texture->textureId) );
	}

	void GeoffRenderer::uploadTexture( geoff::renderer::Texture texture ) 
	{
		glBindTexture( GL_TEXTURE_2D, texture->textureId );
		glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE );
		glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE );
		glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
		glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
		glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, texture->width, texture->height, 0, GL_RGBA, GL_UNSIGNED_BYTE, (unsigned char*)&(texture->pixels->b[0]) );
		glBindTexture( GL_TEXTURE_2D, 0 );
	}
	
	void GeoffRenderer::destroyTexture( geoff::renderer::Texture texture ) 
	{
		glDeleteTextures( 1, (GLuint*)&(texture->textureId) );
	}
	

	/**
	 * Framebuffers
	 */

	void GeoffRenderer::createFrameBuffer( geoff::renderer::FrameBuffer target )
	{
		glGenFramebuffers( 1, (GLuint*)&(target->id));
		glBindFramebuffer( GL_FRAMEBUFFER, target->id );
		glFramebufferTexture2D( GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, target->texture->textureId, 0 );
		glBindFramebuffer( GL_FRAMEBUFFER, 0 );

	}

	void GeoffRenderer::bindFrameBuffer( geoff::renderer::FrameBuffer target )
	{
		if ( target != null() )
		{
			glBindFramebuffer( GL_FRAMEBUFFER, target->id );
			_setupViewport( target->texture->width, target->texture->height, false );
		}
		else
		{
			glBindFramebuffer( GL_FRAMEBUFFER, 0 );
			_setupViewport( _w, _h, true );
		}
	}

	void GeoffRenderer::destroyFrameBuffer( geoff::renderer::FrameBuffer target )
	{
		glDeleteFramebuffers( 1, (GLuint*)&(target->id) );
	}


	/**
	 * Blend modes
	 */


	void GeoffRenderer::setBlendMode( int sourceFactor, int destinationFactor )
	{
		glBlendFunc( sourceFactor, destinationFactor );
	}
	
	void GeoffRenderer::setBlendModeSeparate( int sourceFactor, int destinationFactor, int sourceAlphaFactor, int destAlphaFactor )
	{
		glBlendFuncSeparate( sourceFactor, destinationFactor, sourceAlphaFactor, destAlphaFactor );
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