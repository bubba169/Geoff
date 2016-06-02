package pkg;

import geoff.AppDelegate;
import geoff.renderer.IRenderContext;
import geoff.renderer.RenderBatch;
import geoff.renderer.Shader;
import geoff.renderer.Texture;
import geoff.utils.NativeHelper;

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
		#if mobile 
			vsSource += "precision mediump float;";
		#end
		vsSource += "attribute vec2 aVertexPosition;";
		vsSource += "attribute vec2 aVertexUV;";
		vsSource += "uniform mat4 uProjectionMatrix;";
		vsSource += "varying vec2 vVertexUV;";
		vsSource += "void main(void) {";
		vsSource += "    gl_Position = uProjectionMatrix * vec4(aVertexPosition, 1.0, 1.0);";
		vsSource += "    vVertexUV = aVertexUV;";
		vsSource += "}";
		
		var fsSource : String = "";
		#if mobile 
			fsSource += "precision mediump float;";
		#end
		fsSource += "varying vec2 vVertexUV;";
		fsSource += "uniform sampler2D uTexture0;";
		fsSource += "void main(void) {";
		fsSource += "	vec4 texColor = texture2D( uTexture0, vVertexUV );";
		fsSource += "	texColor.rgb = texColor.rgb * texColor.a;";
		fsSource += "	gl_FragColor = texColor;";
		fsSource += "}";	
		
		var shader : Shader = new Shader( vsSource, fsSource, [
			new ShaderAttribute( "aVertexPosition", 0, 2 ),
			new ShaderAttribute( "aVertexUV", 2, 2 )
		]);
		shader.program = renderer.compileShader( vsSource, fsSource );
		
		trace( shader.program );
		
		batch = new RenderBatch();
		batch.shader = shader;
		batch.vertices = [
			320, 0, 0.5, 0,
			0, 480, 0, 1,
			640, 480, 1, 1
		];
		batch.indexes = [ 0, 1, 2 ];
		
		
		var texture : Texture = renderer.createTexture( "test/bug.png" );
		trace( texture.width, texture.height );
		
		batch.textures.push( texture );
		
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