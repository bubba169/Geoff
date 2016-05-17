package test.test;

import android.webkit.WebViewClient;
import android.webkit.WebView;

/**
 * ...
 * @author Simon
 */
class TestWebClient extends WebViewClient
{

	public function new() 
	{
		super();
	}
	
	@:overload
	override public function shouldOverrideUrlLoading( view : WebView, url : String )
	{
		view.loadUrl( url );
		return false;
	}
	
}