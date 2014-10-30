package cc.util {
	
	import flash.geom.Point;
	
	public class MathHelper {
		
		public static function toRadians(degrees:Number):Number {
			return degrees * Math.PI / 180;
		}
		
		public static function toDegrees(radians:Number):Number {
			return radians * 180 / Math.PI;
		}
		
		public static function getDistance(pointA:Point, pointB:Point):Number {
			var dx:Number = pointB.x - pointA.x;
			var dy:Number = pointB.y - pointA.y;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		/*
		 * returns the angle in radians
		 */
		public static function getAngle(pointA:Point, pointB:Point):Number {
			return Math.atan2(pointB.y - pointA.y, pointB.x - pointA.x);
		}
		
		/*
		 * returns a Point which represents the x and y velocity
		 */
		public static function getVelocity(angleRadians:Number, speed:Number):Point {
			var velocity:Point = new Point();
			velocity.x = Math.cos(angleRadians) * speed;
			velocity.y = Math.sin(angleRadians) * speed;
			return velocity;
		}
		
	}
	
}