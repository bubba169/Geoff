#ifndef GEOFF_RENDERER_INCLUDED
#define GEOFF_RENDERER_INCLUDED

#include <OpenGLES/ES2/gl.h>

#include <hxcpp.h>
#include <haxe/io/Bytes.h>

#include <geoff/renderer/RenderBatch.h>
#include <geoff/renderer/Shader.h>
#include <geoff/renderer/ShaderAttribute.h>
#include <geoff/renderer/Texture.h>
#include <geoff/renderer/FrameBuffer.h>

namespace geoff
{
	
	class GeoffRenderer
	{
		public:
			
			GeoffRenderer();
			~GeoffRenderer();
			
			void clear( float r, float g, float b, float a );
			int compileShader( geoff::renderer::Shader );
			void destroyShader( geoff::renderer::Shader );
			
			void beginRender( int w, int h );
			void renderBatch( geoff::renderer::RenderBatch batch );
			void endRender();
			
			void createFrameBuffer( geoff::renderer::FrameBuffer buffer );
			void bindFrameBuffer( geoff::renderer::FrameBuffer buffer );
			void destroyFrameBuffer( geoff::renderer::FrameBuffer buffer );
			
			void setBlendMode( int sourceFactor, int destinationFactor );
			void setBlendModeSeparate( int sourceFactor, int destinationFactor, int sourceAlphaFactor, int destAlphaFactor );

			void createTextureFromAsset( geoff::renderer::Texture );
			void createTexture( geoff::renderer::Texture );
			void uploadTexture( geoff::renderer::Texture );
			void destroyTexture( geoff::renderer::Texture );


			
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