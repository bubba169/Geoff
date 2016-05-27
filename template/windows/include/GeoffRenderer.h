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
			static void clear( float r, float g, float b, float a );
			
			static int compileShader( ::String vsSource, ::String fsSource );
			
			static void beginRender( float w, float h );
			static void renderBatch( geoff::renderer::RenderBatch batch );
			static void endRender();
			
			static void pushRenderTarget( geoff::renderer::Texture texture );
			static void popRenderTarget( );
			
		
		
	};
};

#endif