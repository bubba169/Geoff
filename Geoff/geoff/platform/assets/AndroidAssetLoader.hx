package geoff.platform.assets;
import haxe.io.Bytes;
import geoff.assets.IAssetLoader;
import geoff.audio.AudioSource;
import geoff.renderer.Texture;

import java.nio.ByteBuffer;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import java.io.InputStream;

/**
 * ...
 * @author Simon
 */
class AndroidAssetLoader implements IAssetLoader
{

	public function new() 
	{
		
	}
	
	
	/* INTERFACE geoff.assets.IAssetLoader */
	
	public function loadTexture(texture:Texture):Void 
	{
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
		bitmap.recycle();
	}
	
	public function loadAudio(source:AudioSource):Void 
	{
		
	}
	
	
	public function getText( path : String ) : String 
	{
		var asset = App.current.platform.nativeActivity.getAssets().open( path );
		var stream = new java.io.InputStreamReader( asset );
		var buffer = new java.io.BufferedReader( stream );
		
		var result : String = "";
		var line : String = buffer.readLine();
		while ( line != null ) 
		{
			result += line;
			line = buffer.readLine();
			if ( line != null ) result += "\n";
		}
		
		buffer.close();
		stream.close();
		asset.close();
		
		return result;
	}
	
	
	
	public function getBytes( path : String ) : Bytes 
	{
		var buffer = App.current.platform.nativeActivity.getAssets().open( path );
		var bytes = Bytes.alloc( buffer.available() );
		
		buffer.read( bytes.getData() );
		buffer.close();
		
		return bytes;
	}
	
}