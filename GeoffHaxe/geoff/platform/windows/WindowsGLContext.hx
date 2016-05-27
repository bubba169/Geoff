package geoff.platform.windows;
import geoff.gl.GLBuffer;
import geoff.gl.GLProgram;
import geoff.gl.GLShader;
import geoff.platform.interfaces.IGLContext;
import geoff.platform.windows.externs.GL;
import haxe.io.Bytes;

import cpp.Pointer;
import cpp.ConstCharStar;

using cpp.NativeString;

/**
 * ...
 * @author Simon
 */

class WindowsGLContext implements IGLContext
{

	public var COLOR_BUFFER_BIT : Int 	= 0x00004000;
	public var DEPTH_BUFFER_BIT : Int 	= 0x00000100;
	public var STENCIL_BUFFER_BIT : Int = 0x00000400;
	
	public function new() 
	{
		
	}
	
	public function clear(mask:Int) : Void
	{
		GL.clear( mask );
	}
	
	public function clearColor(r:Float, g:Float, b:Float, a:Float) : Void
	{
		GL.clearColor( r, g, b, a );
	}
	
	/**
	 * Buffer
	 */
	
	public function createBuffer() : GLBuffer
	{
		var bufferId : cpp.UInt32 = 0;
		GL.genBuffers( 1, Pointer.addressOf( bufferId ).get_raw() );
		return new GLBuffer( bufferId, this );
	}
	
	public function bindBuffer( target : GLBufferTarget, buffer : GLBuffer ) : Void
	{
		if ( buffer != null ) {
			GL.bindBuffer( target, buffer.value );
		}else{
			GL.bindBuffer( target, 0 );
		}
	}
	
	public function bufferData( target : GLBufferTarget, data : Bytes, usage : GLBufferUsage ) : Void
	{
		GL.bufferData( target, data.length, cast Pointer.addressOf( data.getData() ).get_raw(), usage );
	}
	
	/**
	 * Shader
	 */
	
	public function createShader( type : GLShaderType ) : GLShader
	{
		return new GLShader( GL.createShader( type ), this );
	}
	
	public function shaderSource( shader : GLShader, source : String ) : Void
	{
		var cstr : ConstCharStar = ConstCharStar.fromString( source );
		var length : Int = source.length;
		GL.shaderSource( shader.value, 1, Pointer.addressOf( cstr ).get_raw(), Pointer.addressOf( length ).get_raw() );
	}
	
	public function compileShader( shader : GLShader ) : Void
	{
		GL.compileShader( shader.value );
	}
	
	public function getShaderParameter( shader : GLShader, parameter : GLShaderParameter ) : Int
	{
		var result : Int = 0;
		GL.getShaderiv( shader.value, parameter, Pointer.addressOf( result ).get_raw() );
		return result;
	}
	
	public function getShaderInfoLog( shader : GLShader ) : String
	{
		var length : Int = getShaderParameter( shader, GLShaderParameter.InfoLogLength );
		var size : Int = 0;
		var result : String = "";
		
		untyped {
			__cpp__("char* charPtr = new char[length]");
			GL.getShaderInfoLog( shader.value, length + 1, Pointer.addressOf(size).get_raw(), charPtr );
			result = cpp.NativeString.fromPointer( Pointer.fromRaw(charPtr) );
			__cpp__("delete charPtr");
		}
		
		return result;
	}
	
	
	/**
	 * Program
	 */
	
	public function createProgram( ) : GLProgram
	{
		return new GLProgram( GL.createProgram( ), this );
	}
	
	public function attachShader( program : GLProgram, shader : GLShader ) : Void
	{
		GL.attachShader( program.value, shader.value );
	}
	
	public function linkProgram( program : GLProgram ) : Void
	{
		GL.linkProgram( program.value );
	}
	
	public function getProgramParameter( program : GLProgram, parameter : GLProgramParameter ) : Int
	{
		var result : Int = 0;
		GL.getProgramiv( program.value, parameter, Pointer.addressOf( result ).get_raw() );
		return result;
	}
	
	public function getProgramInfoLog( program : GLProgram ) : String
	{
		var length : Int = getProgramParameter( program, GLProgramParameter.InfoLogLength );
		var size : Int = 0;
		var result : String = "";
		
		untyped {
			__cpp__("char* charPtr = new char[length]");
			GL.getProgramInfoLog( program.value, length + 1, Pointer.addressOf(size).get_raw(), charPtr );
			result = cpp.NativeString.fromPointer( Pointer.fromRaw(charPtr) );
			__cpp__("delete charPtr");
		}
		
		return result;
	}
	
	public function useProgram( program : GLProgram ) : Void 
	{
		GL.useProgram( program.value );
	}
}