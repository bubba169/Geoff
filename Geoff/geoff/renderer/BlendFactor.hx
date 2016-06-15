package geoff.renderer;

/**
 * ...
 * @author Simon
 */
@:enum abstract BlendFactor(Int) from Int to Int
{
	var Zero = 0;
	var One = 1;
	var SourceColor = 0x300;
	var OneMinusSourceColor = 0x301;
	var SourceAlpha = 0x302;
	var OneMinusSourceAlpha = 0x303;
	var DestinationAlpha = 0x304;
	var OneMinusDestinationAlpha = 0x304;
	var DestinationColor = 0x306;
	var OneMinusDestinationColor = 0x307;
}