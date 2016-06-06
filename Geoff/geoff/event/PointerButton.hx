package geoff.event;

/**
 * ...
 * @author Simon
 */
@:enum abstract PointerButton(Int) from Int to Int
{
	var None = -1;
	var Left = 0;
	var Right = 1;
	var Middle = 2;
	var Button4 = 3;
	var Button5 = 4;
}