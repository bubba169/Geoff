package geoff.platform.interfaces;
import geoff.gl.GLBuffer;
import geoff.gl.GLProgram;
import geoff.gl.GLShader;
import haxe.io.Bytes;

/**
 * @author Simon
 */
interface IGLContext 
{
	public var COLOR_BUFFER_BIT : Int;
	public var DEPTH_BUFFER_BIT : Int;
	public var STENCIL_BUFFER_BIT : Int;
	
	function clear( mask : Int ) : Void;
	function clearColor( r : Float, g : Float, b : Float, a : Float ) : Void;
	
	/**
	 * Buffers
	 */
	
	function createBuffer() : GLBuffer;
	function bindBuffer( target : Int, buffer : GLBuffer ) : Void;
	function bufferData( target : Int, data : Bytes, use : GLBufferUsage ) : Void;
	
	/**
	 * Shaders
	 */
	
	function createShader( type : Int ) : GLShader;
	function shaderSource( shader : GLShader, source : String ) : Void;
	function compileShader( shader : GLShader ) : Void;
	function getShaderParameter( shader : GLShader, parameter : GLShaderParameter ) : Int;
	function getShaderInfoLog( shader : GLShader ) : String;
	
	function createProgram() : GLProgram;
	function attachShader( program : GLProgram, shader : GLShader ) : Void;
	function linkProgram( program : GLProgram ) : Void;
	function getProgramParameter( program : GLProgram, parameter : GLProgramParameter ) : Int;
	function getProgramInfoLog( program : GLProgram ) : String;
}