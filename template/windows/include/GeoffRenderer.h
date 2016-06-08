#ifndef GEOFF_RENDERER_INCLUDED
#define GEOFF_RENDERER_INCLUDED

#define GLEW_STATIC

#include <glew/glew.h>
#include <glfw/glfw3.h>

#include <IL/il.h>

#include <hxcpp.h>
#include <geoff/renderer/RenderBatch.h>
#include <geoff/renderer/Shader.h>
#include <geoff/renderer/ShaderAttribute.h>
#include <geoff/renderer/Texture.h>

namespace geoff
{
	
	class GeoffRenderer
	{
		public:
			
			GeoffRenderer();
			~GeoffRenderer();
			
			void clear( float r, float g, float b, float a );
			int compileShader( geoff::renderer::Shader );
			int destroyShader( geoff::renderer::Shader );
			
			void beginRender( int w, int h );
			void renderBatch( geoff::renderer::RenderBatch batch );
			void endRender();
			
			void pushRenderTarget( geoff::renderer::Texture texture );
			void popRenderTarget( );
			
			void createTextureFromImage( geoff::renderer::Texture );
			void createTextureFromPixels( geoff::renderer::Texture );
			void uploadTexture( geoff::renderer::Texture );
			void destroyTexture( geoff::renderer::Texture );
			void reloadTexture( geoff::renderer::Texture );
			
			int getError();
			
		private:
			
			GLuint _vertexBuffer;
			GLuint _indexBuffer;
			
			int _w;
			int _h;
			
			void _setupViewport( int w, int h, bool flipY );
			float _projection[16];
			
			int _id;
		
	};
};

#endif