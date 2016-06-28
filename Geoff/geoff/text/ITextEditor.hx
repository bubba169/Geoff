package geoff.text;

/**
 * @author Simon
 */
interface ITextEditor 
{
	function addTextAtCursor( text : String ) : Void;
	function setCursor( position : Int ) : Void;
	function removeCharactersBeforeCursor( num : Int ) : Void;
	function removeCharactersAfterCursor( num : Int ) : Void;
}