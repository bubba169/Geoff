package geoff.platform.android;

import android.view.inputmethod.InputConnection;
import android.view.inputmethod.CompletionInfo;
import android.view.inputmethod.CorrectionInfo;

import java.lang.CharSequence;

import geoff.text.ITextEditor;

/**
 * ...
 * @author Simon
 */
class GeoffInputConnection extends InputConnection
{
	public static var editor : ITextEditor;
	var _batchEdits : Int = 0;

	public function new() 
	{
		
	}
	
	public function beginBatchEdit() : Bool
	{
		_batchEdits++;
		return true;
	}
	
	public function clearMetaKeyStates( states : Int ) : Bool 
	{
		// Not tracking meta states
		return true;
	}
	
	public function commitCompletion( info : CompletionInfo ) : Bool
	{
		// Not using autocomplete
		return true;
	}
	
	public function commitCorrection( info : CorrectionInfo ) : Bool
	{
		// May need to do this
		return true;
	}
	
	public function commitText( text : CharSequence, cursorPos : Int ) : Bool
	{
		if ( editor ) 
		{
			editor.addTextAtCursor( text.toString() );
			editor.setCursor( cursorPos );
		}
		
		return true;
	}
	
	public function deleteSurroundingText( before : Int, after : Int ) : Bool
	{
		if ( editor ) 
		{
			editor.removeCharactersBeforeCursor( before );
			editor.removeCharactersAfterCursor( after );
		}
		return true;
	}
	
	public function endBatchEdit() : Bool
	{
		_batchEdits--;
		if ( _batchEdits > 0 ) 
		{
			return true;
		}
		
		return false;
	}
	
	public function finishComposingText() : Bool
	{
		// No styling is applied
		return true;
	}
	
	
	public function getCursorCapsMode( reqModes : Int ) : Int 
	{
		// Not using any special caps modes
		return 0;
	}
	
	
}