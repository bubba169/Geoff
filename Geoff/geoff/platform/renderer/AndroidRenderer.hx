package geoff.platform.renderer;
import geoff.renderer.BlendFactor;
import geoff.renderer.FrameBuffer;
import geoff.renderer.Shader;
import geoff.renderer.Texture;
import geoff.utils.Color;
import haxe.io.Bytes;

import java.nio.IntBuffer;
import java.nio.FloatBuffer;
import java.nio.ByteBuffer;
import java.io.InputStream;
import java.NativeArray;

import android.opengl.GLES20;
import android.opengl.GLUtils;
import android.app.Activity;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

import geoff.renderer.IRenderContext;
import geoff.renderer.RenderBatch;

/**
 * ...
 * @author Simon
 */
class AndroidRenderer implements IRenderContext
{
	var _vertexBuffer : Int;
	var _indexBuffer : Int;
	var _w : Int;
	var _h : Int;
	var _projection : FloatBuffer;
	
	public function new() 
	{
		
	}
	
	public function init() : Void
	{
		_projection = FloatBuffer.allocate(16);
		_projection.put( 10, -1 );
		_projection.put( 15, 1 );
	}
	
	public function onContextCreated() : Void 
	{
		
		trace( "restoring buffers" );
		var result : NativeArray<Int> = new NativeArray<Int>(2);
		GLES20.glGenBuffers( 2, result, 0 );
		
		_vertexBuffer = result[0];
		_indexBuffer = result[1];
		
		trace( _indexBuffer, _vertexBuffer );
	}
	
	
		
	public function clear( clearColor : Color ):Void 
	{
		GLES20.glClearColor( clearColor.r / 255, clearColor.g / 255, clearColor.b / 255, clearColor.a );
		GLES20.glClear( GLES20.GL_COLOR_BUFFER_BIT );
	}
	
	
	
	public function uploadShader( shader : Shader ) : Void 
	{
		var status : IntBuffer = IntBuffer.allocate(1);
		
		var vs : Int = GLES20.glCreateShader( GLES20.GL_VERTEX_SHADER );
		GLES20.glShaderSource( vs, shader.vertexSource );
		GLES20.glCompileShader( vs );
		GLES20.glGetShaderiv( vs, GLES20.GL_COMPILE_STATUS, status );
		
		if ( status.equals(0) ) 
		{
			GLES20.glDeleteShader( vs );
			shader.program = -1;
			return;
		}
		
		var fs : Int = GLES20.glCreateShader( GLES20.GL_FRAGMENT_SHADER );
		GLES20.glShaderSource( fs, shader.fragmentSource );
		GLES20.glCompileShader( fs );
		GLES20.glGetShaderiv( fs, GLES20.GL_COMPILE_STATUS, status );
		
		if ( status.equals(0) ) 
		{
			GLES20.glDeleteShader( vs );
			GLES20.glDeleteShader( fs );
			shader.program = -2;
			return;
		}
		
		var program : Int = GLES20.glCreateProgram();
		GLES20.glAttachShader( program, vs );
		GLES20.glAttachShader( program, fs );
		GLES20.glLinkProgram( program );
		GLES20.glGetProgramiv( program, GLES20.GL_LINK_STATUS, status );
		
		GLES20.glDeleteShader( vs );
		GLES20.glDeleteShader( fs );
		
		if ( status.equals(0) ) 
		{
			GLES20.glDeleteProgram( program );
			shader.program = -5;
			return;
		}
		
		shader.program = program;
		
	}
	
	public function destroyShader( shader : Shader ) : Void 
	{
		GLES20.glDeleteProgram( shader.program );
	}
	
	
	
	public function beginRender(width:Int, height:Int):Void 
	{
		_w = width;
		_h = height;
		
		setupViewport( width, height, true );
		GLES20.glEnable( GLES20.GL_BLEND );
		GLES20.glBlendFunc( GLES20.GL_ONE, GLES20.GL_ONE_MINUS_SRC_ALPHA );
		
	}
	
	public function renderBatch(batch:RenderBatch):Void 
	{
				
		GLES20.glBindBuffer( GLES20.GL_ARRAY_BUFFER, _vertexBuffer );
		GLES20.glBufferData( GLES20.GL_ARRAY_BUFFER, batch.vertices.length * 4, batch.getRawVertices(), GLES20.GL_STREAM_DRAW );  
		
		GLES20.glBindBuffer( GLES20.GL_ELEMENT_ARRAY_BUFFER, _indexBuffer );
		GLES20.glBufferData( GLES20.GL_ELEMENT_ARRAY_BUFFER, batch.indexes.length * 2, batch.getRawIndexes(), GLES20.GL_STREAM_DRAW );  
		
		GLES20.glUseProgram( batch.shader.program );
		
		var projectionUniform : Int = GLES20.glGetUniformLocation( batch.shader.program, "uProjectionMatrix" );
		GLES20.glUniformMatrix4fv( projectionUniform, 1, false, _projection );
				
		for ( i in 0...batch.textures.length )
		{
			var uTexture : Int = GLES20.glGetUniformLocation( batch.shader.program, "uTexture" + i );
			GLES20.glActiveTexture( GLES20.GL_TEXTURE0 + i );
			GLES20.glBindTexture( GLES20.GL_TEXTURE_2D, batch.textures[i].textureId );
			GLES20.glUniform1i( uTexture, i );
		}
		
		var attribs : Array<Int> = [];
		for ( attribute in batch.shader.attributes )
		{
			var vertexAttribute : Int = GLES20.glGetAttribLocation( batch.shader.program, attribute.name );
			if ( vertexAttribute != -1 ) {
				GLES20.glEnableVertexAttribArray( vertexAttribute );
				GLES20.glVertexAttribPointer( vertexAttribute, attribute.size, GLES20.GL_FLOAT, false, batch.shader.vertexSize * 4, attribute.start * 4 );
				attribs.push( vertexAttribute );
			}
		}
		
		GLES20.glDrawElements( GLES20.GL_TRIANGLES, batch.indexes.length, GLES20.GL_UNSIGNED_SHORT, 0 );
		
		for (i in 0...batch.textures.length )
		{
			GLES20.glActiveTexture( GLES20.GL_TEXTURE0 + i );
			GLES20.glBindTexture( GLES20.GL_TEXTURE_2D, 0 );
		}
		
		for ( attr in attribs )
		{
			GLES20.glDisableVertexAttribArray( attr );
		}
		
		GLES20.glUseProgram( 0 );
		GLES20.glBindBuffer( GLES20.GL_ARRAY_BUFFER, 0 );
		GLES20.glBindBuffer( GLES20.GL_ELEMENT_ARRAY_BUFFER, 0 );		
		
	}
	
	public function endRender():Void 
	{
		
	}
	
	public function getError():Int 
	{
		return GLES20.glGetError();
		
	}
	
	public function createTextureFromPixels( id : String, width : Int, height : Int, pixels : Bytes ) : Texture 
	{
		var idBuffer : IntBuffer = IntBuffer.allocate(1);
		GLES20.glGenTextures( 1, idBuffer );
		
		var texture : Texture = new Texture( id );
		texture.textureId = idBuffer.get(0);
		texture.width = width;
		texture.height = height;
		texture.pixels = pixels;
		
		return texture;
		
	}
	
	public function createTextureFromAsset( path : String ) : Texture  
	{
		var texture : Texture = new Texture( path );
		texture.asset = path;
		
		var assetManager : AssetManager = App.current.platform.nativeActivity.getAssets();
		var is : InputStream = assetManager.open( texture.asset );
		
		var bitmap : Bitmap = BitmapFactory.decodeStream( is );
		is.close();
		
		texture.width = bitmap.getWidth();
		texture.height = bitmap.getHeight();
		
		var pixels : ByteBuffer = ByteBuffer.allocate( texture.width * texture.height * 4 );
		bitmap.setPremultiplied( false );
		bitmap.copyPixelsToBuffer( pixels );
		pixels.rewind();
		
		texture.pixels = Bytes.alloc( pixels.remaining() );
		
		pixels.get( texture.pixels.getData(), 0, pixels.remaining() );
		
		var idBuffer : IntBuffer = IntBuffer.allocate(1);
		GLES20.glGenTextures( 1, idBuffer );
		texture.textureId = idBuffer.get(0);
		
		bitmap.recycle();
		
		return texture;
		
	}
	
	public function uploadTexture( texture : Texture ) : Void
	{
		
		GLES20.glBindTexture( GLES20.GL_TEXTURE_2D, texture.textureId );
		GLES20.glTexParameteri( GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE );
		GLES20.glTexParameteri( GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE );
		GLES20.glTexParameteri( GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MIN_FILTER, GLES20.GL_LINEAR );
		GLES20.glTexParameteri( GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MAG_FILTER, GLES20.GL_LINEAR );
		GLES20.glTexImage2D( GLES20.GL_TEXTURE_2D, 0, GLES20.GL_RGBA, texture.width, texture.height, 0, GLES20.GL_RGBA, GLES20.GL_UNSIGNED_BYTE, ByteBuffer.wrap( texture.pixels.getData() ) ); 
		GLES20.glBindTexture( GLES20.GL_TEXTURE_2D, 0 );		
	}
	
	
	public function destroyTexture( texture : Texture ) : Void
	{
		var buffer : IntBuffer = IntBuffer.allocate(1);
		buffer.put( 0, texture.textureId );
		GLES20.glDeleteTextures( 1, buffer );
	}
	
	
	/**
	 * FrameBuffers
	 */
	
	public function createFrameBuffer( texture : Texture ) : FrameBuffer 
	{
		var target : FrameBuffer = new FrameBuffer();
		target.texture = texture;
		
		var buffer : IntBuffer = IntBuffer.allocate( 1 );
		GLES20.glGenFramebuffers( 1, buffer );
		
		target.id = buffer.get(0);
		
		GLES20.glBindFramebuffer( GLES20.GL_FRAMEBUFFER, target.id );
		GLES20.glFramebufferTexture2D( GLES20.GL_FRAMEBUFFER, GLES20.GL_COLOR_ATTACHMENT0, GLES20.GL_TEXTURE_2D, target.texture.textureId, 0 );
		GLES20.glBindFramebuffer( GLES20.GL_FRAMEBUFFER, 0 );
		
		return target;
	}
	
	public function bindFrameBuffer( target : FrameBuffer ) : Void 
	{
		if ( target != null ) 
		{
			GLES20.glBindFramebuffer( GLES20.GL_FRAMEBUFFER, target.id );
			setupViewport( target.texture.width, target.texture.height, false );
		}
		else
		{
			GLES20.glBindFramebuffer( GLES20.GL_FRAMEBUFFER, 0 );
			setupViewport( _w, _h, true );
		}
	}
	
	public function destroyFrameBuffer( target : FrameBuffer ) : Void 
	{
		var buffer : IntBuffer = IntBuffer.allocate( 1 );
		buffer.put( 0, target.id );
		GLES20.glDeleteFramebuffers( 1, buffer );
	}
	
	
	public function destroy():Void 
	{
		
	}
	
	
	/**
	 * Blend modes
	 */
	
	public function setBlendMode( sourceFactor : BlendFactor, destinationFactor : BlendFactor ) : Void
	{
		GLES20.glBlendFunc( sourceFactor, destinationFactor );
	}
	
	public function setBlendModeSeparate( sourceFactor : BlendFactor, destinationFactor : BlendFactor, sourceAlphaFactor : BlendFactor, destAlphaFactor : BlendFactor ) : Void
	{
		GLES20.glBlendFuncSeparate( sourceFactor, destinationFactor, sourceAlphaFactor, destAlphaFactor );
	}
	
	/**
	 * Privates
	 */
	
	public function setupViewport( width : Int, height : Int, flipY : Bool ) : Void 
	{
		
		GLES20.glViewport( 0, 0, width, height );
		
		var sx : Float = 1.0 / width;
		var sy : Float = (1.0 / height) * ((flipY)? -1:1);
		
		_projection.put( 0, 2.0 * sx );
		_projection.put( 5, 2.0 * sy );
		_projection.put( 12, -width * sx );
		_projection.put( 13, -height * sy );
		
	}
	
	
}