package geoff.math;

/**
 * ...
 * @author Simon
 */
class Matrix3
{

	public var a : Float;
	public var b : Float;
	public var c : Float;
	public var d : Float;
	public var tx : Float;
	public var ty : Float;
	
	public function new( a : Float = 1, b : Float = 0, c : Float = 0, d : Float = 1, tx : Float = 0, ty : Float = 0 )
	{
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
		this.tx = tx;
		this.ty = ty;
	}
	
	public function clone( ) : Matrix3
	{
		return new Matrix3( a, b, c, d, tx, ty );
	}
	
	public function concat( m : Matrix3 ) : Matrix3
	{
		var a1 = a * m.a + b * m.c;
		b = a * m.b + b * m.d;
		a = a1;

		var c1 = c * m.a + d * m.c;
		d = c * m.b + d * m.d;
		c = c1;
		
		var tx1 = tx * m.a + ty * m.c + m.tx;
		ty = tx * m.b + ty * m.d + m.ty;
		tx = tx1;
	}
	
	public function identity() : Void
	{
		a = 1;
		b = 0;
		c = 0;
		d = 1;
		tx = 0;
		ty = 0;
	}
	
	public function translate( dx : Float, dy : Float ) : Void
	{
		tx += dx;
		ty += dy;
	}
	
	public function scale( sx : Float, sy : Float ) : Void
	{
		a *= sx;
		b *= sy;
		c *= sx;
		d *= sy;
		tx *= sx;
		ty *= sy;
	}
	
	public function rotate ( theta : Float ) : Void {
				
		var cos = Math.cos (theta);
		var sin = Math.sin (theta);
		
		var a1 = a * cos - b * sin;
		b = a * sin + b * cos;
		a = a1;
		
		var c1 = c * cos - d * sin;
		d = c * sin + d * cos;
		c = c1;
		
		var tx1 = tx * cos - ty * sin;
		ty = tx * sin + ty * cos;
		tx = tx1;
		
	}
	
}