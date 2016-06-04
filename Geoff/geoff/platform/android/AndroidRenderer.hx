package geoff.platform.android;
import geoff.renderer.Texture;
import geoff.utils.Color;

import java.nio.IntBuffer;
import java.nio.FloatBuffer;
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
	public var clearColor : Color = Color.RED;
	
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
		var result : NativeArray<Int> = new NativeArray<Int>(2);
		GLES20.glGenBuffers( 2, result, 0 );
		
		_vertexBuffer = result[0];
		_indexBuffer = result[1];
		
		_projection = FloatBuffer.allocate(16);
		_projection.put( 10, -1 );
		_projection.put( 15, 1 );
		
		trace( _indexBuffer, _vertexBuffer );
	}
	
	
		
	public function clear():Void 
	{
		GLES20.glClearColor( clearColor.r / 255, clearColor.g / 255, clearColor.b / 255, clearColor.a );
		GLES20.glClear( GLES20.GL_COLOR_BUFFER_BIT );
	}
	
	
	
	public function compileShader(vsSource:String, fsSource:String):Int 
	{
		var status : IntBuffer = IntBuffer.allocate(1);
		
		var vs : Int = GLES20.glCreateShader( GLES20.GL_VERTEX_SHADER );
		GLES20.glShaderSource( vs, vsSource );
		GLES20.glCompileShader( vs );
		GLES20.glGetShaderiv( vs, GLES20.GL_COMPILE_STATUS, status );
		
		if ( status.equals(0) ) 
		{
			GLES20.glDeleteShader( vs );
			return -1;
		}
		
		var fs : Int = GLES20.glCreateShader( GLES20.GL_FRAGMENT_SHADER );
		GLES20.glShaderSource( fs, fsSource );
		GLES20.glCompileShader( fs );
		GLES20.glGetShaderiv( fs, GLES20.GL_COMPILE_STATUS, status );
		
		if ( status.equals(0) ) 
		{
			GLES20.glDeleteShader( vs );
			GLES20.glDeleteShader( fs );
			return -2;
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
			return -5;
		}
		
		return program;
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
		
		trace( "Vertices:");
		for ( i in 0...6 )
		{
			trace ( batch.getRawVertices().get(i) );
		}
		
		GLES20.glBindBuffer( GLES20.GL_ARRAY_BUFFER, _vertexBuffer );
		GLES20.glBufferData( GLES20.GL_ARRAY_BUFFER, batch.vertices.length * 4, batch.getRawVertices(), GLES20.GL_STREAM_DRAW );  
		
		trace( "Indexes:", batch.getRawIndexes().get(0), batch.getRawIndexes().get(1), batch.getRawIndexes().get(2) );
		
		GLES20.glBindBuffer( GLES20.GL_ELEMENT_ARRAY_BUFFER, _indexBuffer );
		GLES20.glBufferData( GLES20.GL_ELEMENT_ARRAY_BUFFER, batch.indexes.length * 2, batch.getRawIndexes(), GLES20.GL_STREAM_DRAW );  
		
		GLES20.glUseProgram( batch.shader.program );
		
		var projectionUniform : Int = GLES20.glGetUniformLocation( batch.shader.program, "uProjectionMatrix" );
		GLES20.glUniformMatrix4fv( projectionUniform, 1, false, _projection );
				
		for ( i in 0...batch.textures.length )
		{
			var uTexture : Int = GLES20.glGetUniformLocation( batch.shader.program, "uTexture" + i );
			GLES20.glActiveTexture( GLES20.GL_TEXTURE0 + i );
			GLES20.glBindTexture( GLES20.GL_TEXTURE_2D, batch.textures[i].id );
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
	
	public function pushRenderTarget(target:Texture):Void 
	{
		
	}
	
	public function popRenderTarget():Void 
	{
		
	}
	
	public function getError():Int 
	{
		return GLES20.glGetError();
		
	}
	
	public function createTexture( path : String ):Texture 
	{
		var texture : Texture = new Texture( path );
		
		var assetManager : AssetManager = App.current.platform.nativeActivity.getAssets();
		var is : InputStream = assetManager.open( path );
		
		var bitmap : Bitmap = BitmapFactory.decodeStream( is );
		is.close();
		
		texture.width = bitmap.getWidth();
		texture.height = bitmap.getHeight();
		
		var idBuffer : IntBuffer = IntBuffer.allocate(1);
		GLES20.glGenTextures( 1, idBuffer );
		texture.id = idBuffer.get(0);
		
		GLES20.glBindTexture( GLES20.GL_TEXTURE_2D, texture.id );
		GLES20.glTexParameteri( GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_S, GLES20.GL_CLAMP_TO_EDGE );
		GLES20.glTexParameteri( GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_WRAP_T, GLES20.GL_CLAMP_TO_EDGE );
		GLES20.glTexParameteri( GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MIN_FILTER, GLES20.GL_LINEAR );
		GLES20.glTexParameteri( GLES20.GL_TEXTURE_2D, GLES20.GL_TEXTURE_MAG_FILTER, GLES20.GL_LINEAR );
		
		GLUtils.texImage2D( GLES20.GL_TEXTURE_2D, 0, bitmap, 0 ); 
		
		bitmap.recycle();
		
		return texture;
		
	}
	
	
	public function destroy():Void 
	{
		
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