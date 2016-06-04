package geoff.event;

/**
 * ...
 * @author Simon
 */
@:enum abstract PointerButton(Int) from Int to Int
{
	var None = 0;
	var Left = 1;
	var Middle = 2;
	var Right = 3;
	var Button4 = 4;
	var Button5 = 5;
}