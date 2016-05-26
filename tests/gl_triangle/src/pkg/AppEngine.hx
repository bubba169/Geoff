package pkg;

import geoff.AppDelegate;
import geoff.gl.GLBuffer;
import geoff.gl.GLProgram;
import geoff.gl.GLShader;
import geoff.platform.interfaces.IGLContext;
import geoff.utils.BytesHelper;

/**
 * ...
 * @author ...
 */
class AppEngine extends AppDelegate
{

	var vertexBuffer : GLBuffer;
	var indexBuffer : GLBuffer;
	
	var vertexShader : GLShader;
	var fragmentShader : GLShader;
	var program : GLProgram;
	
	public function new() 
	{
		super();
	}
	
	override public function init(gl:IGLContext) 
	{
		gl.clearColor( 1, 1, 0, 1 );
		vertexBuffer = gl.createBuffer();
		indexBuffer = gl.createBuffer();
		
		var vsSource : String = "";
		vsSource += "attribute vec3 aVertexPosition;";
		vsSource += "uniform mat4 uMVMatrix;";
		vsSource += "uniform mat4 uPMatrix;";
		
		vsSource += "void main(void) {";
		vsSource += "    gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);";
		vsSource += "}";
		
		var fsSource : String = "";
		fsSource += "void main(void) {";
		fsSource += "	gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);";
		fsSource += "}";		
		
		vertexShader = gl.createShader( GLShaderType.VertexShader );
		gl.shaderSource( vertexShader, vsSource );
		gl.compileShader( vertexShader );
		
		fragmentShader = gl.createShader( GLShaderType.FragmentShader );
		gl.shaderSource( fragmentShader, fsSource );
		gl.compileShader( fragmentShader );
		
		program = gl.createProgram();
		gl.attachShader( program, vertexShader );
		gl.attachShader( program, fragmentShader );
		gl.linkProgram( program );
		
		gl.useProgram( program );
		
		var vertexData : Array<Float> = [
			100, 0,
			0, 100,
			200, 100
		];
		
		var indexData : Array<Int> = [
			0, 1, 2
		];
		
		gl.bindBuffer( GLBufferTarget.ArrayBuffer, vertexBuffer );
		gl.bufferData( GLBufferTarget.ArrayBuffer, BytesHelper.toFloatBytes( vertexData ), GLBufferUsage.StreamDraw );
		gl.bindBuffer( GLBufferTarget.ArrayBuffer, null );
		
		gl.bindBuffer( GLBufferTarget.ElementArrayBuffer, indexBuffer );
		gl.bufferData( GLBufferTarget.ElementArrayBuffer, BytesHelper.toIntBytes( indexData ), GLBufferUsage.StreamDraw );
		gl.bindBuffer( GLBufferTarget.ElementArrayBuffer, null );
		
	}
	
	override public function render(gl:IGLContext) 
	{
		
		gl.clear( gl.COLOR_BUFFER_BIT );
		
		
		
	}
	
}