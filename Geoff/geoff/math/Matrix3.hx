package geoff.math;
import geoff.math.Matrix3;
import geoff.math.Vector2;

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
		
		return this;
	}
	
	public function identity() : Matrix3
	{
		a = 1;
		b = 0;
		c = 0;
		d = 1;
		tx = 0;
		ty = 0;
		
		return this;
	}
	
	public function translate( dx : Float, dy : Float ) : Matrix3
	{
		tx += dx;
		ty += dy;
		
		return this;
	}
	
	public function scale( sx : Float, sy : Float ) : Matrix3
	{
		a *= sx;
		b *= sy;
		c *= sx;
		d *= sy;
		tx *= sx;
		ty *= sy;
		
		return this;
	}
	
	public function rotate ( theta : Float ) : Matrix3 {
				
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
		
		return this;
		
	}
	
	public function transformVector2( pos : Vector2 ) : Vector2
	{
		return new Vector2( pos.x * a + pos.y * c + tx, pos.x * b + pos.y * d + ty );
	}
	
	
	public function copyFrom( other : Matrix3 ) : Matrix3 
	{
		this.a = other.a;
		this.b = other.b;
		this.c = other.c;
		this.d = other.d;
		this.tx = other.tx;
		this.ty = other.ty;
		
		return this;
	}
	
	
	public function invert ():Matrix3 {
		
		var norm = a * d - b * c;
		
		if (norm == 0) {
			
			a = b = c = d = 0;
			tx = -tx;
			ty = -ty;
			
		} else {
			
			norm = 1.0 / norm;
			var a1 = d * norm;
			d = a * norm;
			a = a1;
			b *= -norm;
			c *= -norm;
			
			var tx1 = - a * tx - c * ty;
			ty = - b * tx - d * ty;
			tx = tx1;
			
		}
		
		return this;
	}
	
}