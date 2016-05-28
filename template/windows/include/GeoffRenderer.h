#ifndef GEOFF_RENDERER_INCLUDED
#define GEOFF_RENDERER_INCLUDED

#define GLEW_STATIC

#include <glew/glew.h>
#include <glfw/glfw3.h>

#include <hxcpp.h>
#include <geoff/renderer/RenderBatch.h>
#include <geoff/renderer/Texture.h>

namespace geoff
{
	
	class GeoffRenderer
	{
		public:
			
			GeoffRenderer();
			~GeoffRenderer();
			
			void clear( float r, float g, float b, float a );
			int compileShader( ::String vsSource, ::String fsSource );
			
			void beginRender( float w, float h );
			void renderBatch( geoff::renderer::RenderBatch batch );
			void endRender();
			
			void pushRenderTarget( geoff::renderer::Texture texture );
			void popRenderTarget( );
			
		private:
			
			GLuint _vertexBuffer;
			GLuint _indexBuffer;
		
	};
};

#endif