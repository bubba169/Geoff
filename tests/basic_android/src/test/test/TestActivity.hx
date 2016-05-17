package test.test;

import android.app.Activity;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.webkit.WebView;

/**
 * 
 * 
 */

class TestActivity extends Activity
{
	
    public function new()
	{
		super();
	}
	
	@:overload
	override public function onCreate( bundle : Bundle ) : Void
	{
		super.onCreate( bundle );
		
		var webview : WebView = new WebView( this );
		webview.setWebViewClient( new TestWebClient() );
		webview.loadUrl( "http://www.google.com" );
		
		setContentView( webview );
		
	}
	
}