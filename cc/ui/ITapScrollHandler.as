package cc.ui {
	
	import flash.geom.Point;
	
	public interface ITapScrollHandler {
		
		function handleTap(coord:Point):void;
		function handleTapHold(coord:Point):void;
		function handleScrollStart():void;
		function handleScrollStop():void;
		function handleScroll(delta:Point):void;
		
	}
	
}