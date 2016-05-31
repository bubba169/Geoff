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
	
	var _width : Int = 640;
	var _height : Int = 480;

	public function new() 
	{
		super();
	}
	
	override public function init( renderer : IRenderContext ) 
	{
		
		var vsSource : String = "";
		vsSource += "attribute vec2 aVertexPosition;";
		vsSource += "attribute vec4 aVertexColor;";
		vsSource += "uniform mat4 uProjectionMatrix;";
		vsSource += "varying vec4 vVertexColor;";
		vsSource += "void main(void) {";
		vsSource += "    gl_Position = uProjectionMatrix * vec4(aVertexPosition, 1.0, 1.0);";
		vsSource += "    vVertexColor = aVertexColor;";
		vsSource += "}";
		
		var fsSource : String = "";
		fsSource += "varying vec4 vVertexColor;";
		fsSource += "void main(void) {";
		fsSource += "	gl_FragColor = vVertexColor;";
		fsSource += "}";	
		
		var shader : Shader = new Shader( vsSource, fsSource, [
			new ShaderAttribute( "aVertexPosition", 0, 2 ),
			new ShaderAttribute( "aVertexColor", 2, 4 )
		]);
		shader.program = renderer.compileShader( vsSource, fsSource );
		
		trace( shader.program );
		
		batch = new RenderBatch();
		batch.shader = shader;
		batch.vertices = [
			200, 0, 1, 1, 1, 1,
			100, 100, 0, 1, 1, 1,
			300, 100, 1, 0, 0, 1
		];
		batch.indexes = [ 0, 1, 2 ];
		
	}
	
	override public function update( renderer : IRenderContext ) 
	{
		renderer.clear();
		renderer.beginRender( _width, _height );
		renderer.renderBatch( batch );
	}
	
	override public function resize(width:Int, height:Int) 
	{
		_width = width;
		_height = height;
	}
	
}