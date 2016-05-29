package pkg;

import geoff.AppDelegate;
import geoff.renderer.IRenderContext;
import geoff.renderer.RenderBatch;
import geoff.renderer.Shader;
import geoff.utils.BytesHelper;

/**
 * ...
 * @author ...
 */
class AppEngine extends AppDelegate
{
	var shader : Int;
	var batch:RenderBatch;

	public function new() 
	{
		super();
	}
	
	override public function init( renderer : IRenderContext ) 
	{
		/*gl.clearColor( 1, 1, 0, 1 );
		vertexBuffer = gl.createBuffer();
		indexBuffer = gl.createBuffer();*/
		
		var vsSource : String = "";
		vsSource += "attribute vec2 aVertexPosition;";
		vsSource += "uniform mat4 uProjectionMatrix;";
		
		vsSource += "void main(void) {";
		vsSource += "    gl_Position = uProjectionMatrix * vec4(aVertexPosition, 1.0, 1.0);";
		vsSource += "}";
		
		var fsSource : String = "";
		fsSource += "void main(void) {";
		fsSource += "	gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);";
		fsSource += "}";	
		
		//trace( renderer.compileShader( vsSource, fsSource ) );
		var shader : Shader = new Shader( vsSource, fsSource, [] );
		shader.program = renderer.compileShader( vsSource, fsSource );
		
		trace( shader.program );
		
		batch = new RenderBatch();
		batch.shader = shader;
		batch.vertices = [
			100, 0,
			0, 100,
			200, 100
		];
		batch.indexes = [ 0, 1, 2 ];
			
		
		/*
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
		gl.bindBuffer( GLBufferTarget.ElementArrayBuffer, null );*/
		
	}
	
	override public function update( renderer : IRenderContext ) 
	{
		renderer.clear();
		renderer.renderBatch( batch );
		
		trace( renderer.getError() );
	}
	
}