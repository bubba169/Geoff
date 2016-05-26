package geoff.platform.windows;
import geoff.gl.GLBuffer;
import geoff.gl.GLShader;
import geoff.platform.interfaces.IGLContext;
import geoff.platform.windows.externs.GL;

import cpp.Pointer;
import cpp.ConstCharStar;

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
	
	public function createBuffer() : GLBuffer
	{
		var bufferId : cpp.UInt32 = 0;
		GL.genBuffers( 1, Pointer.addressOf( bufferId ).get_raw() );
		return new GLBuffer( bufferId, this );
		
		//return new GLBuffer( GL.createBuffer() );
	}
	
	public function createShader( type : Int ) : GLShader
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
	
}