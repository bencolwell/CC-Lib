package cc.ui {
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class TapScrollHelper {
		
		private var _dispatcher:DisplayObjectContainer;
		private var _handler:ITapScrollHandler;
		private var _scrollTolerance:int;
		private var _mouseHoldTimer:Timer;
		private var _mousePos:Point;
		private var _isMouseDown:Boolean;
		private var _isMouseHeld:Boolean;
		private var _isScrolling:Boolean;
		
		public function TapScrollHelper(
										dispatcher:DisplayObjectContainer,
										handler:ITapScrollHandler,
										tapTolerance:int = 300,
										scrollTolerance:int = 5
										) {
			
			_dispatcher = dispatcher;
			_handler = handler;
			_scrollTolerance = scrollTolerance;
			
			_dispatcher.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			_dispatcher.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			_dispatcher.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			
			_mouseHoldTimer = new Timer(tapTolerance, 1);
			_mouseHoldTimer.addEventListener(TimerEvent.TIMER_COMPLETE, handleTimer);
			
			_mousePos = new Point();
			_isMouseDown = false;
			_isMouseHeld = false;
			_isScrolling = false;
			
		}
		
		private function handleTimer(e:TimerEvent):void {
			
			if (!_isScrolling) {
				_isMouseHeld = true;
				_handler.handleTapHold(_mousePos);
			}
			
		}
		
		private function handleMouseDown(e:MouseEvent):void {
			
			_isMouseDown = true;
			_isMouseHeld = false;
			_mousePos.x = e.stageX;
			_mousePos.y = e.stageY;
			_mouseHoldTimer.reset();
			_mouseHoldTimer.start();
			
		}
		
		private function handleMouseUp(e:MouseEvent):void {
			
			_isMouseDown = false;
			_mouseHoldTimer.stop();
			if (_isScrolling) {
				_isScrolling = false;
				_handler.handleScrollStop();
			} else {
				if (!_isMouseHeld) {
					_handler.handleTap(_mousePos);
				}
			}
			
		}
		
		private function handleMouseMove(e:MouseEvent):void {
			
			if (_isMouseDown) {
				if (_isScrolling) {
					_handler.handleScroll(new Point(_mousePos.x - e.stageX, _mousePos.y - e.stageY));
					_mousePos.x = e.stageX;
					_mousePos.y = e.stageY;
				} else {
					if (Math.abs(_mousePos.x - e.stageX) > _scrollTolerance || Math.abs(_mousePos.y - e.stageY) > _scrollTolerance) {
						_isScrolling = true;
						_handler.handleScrollStart();
					}
				}
			}
			
		}
		
	}
	
}