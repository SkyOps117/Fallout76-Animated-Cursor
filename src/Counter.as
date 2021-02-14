package
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.utils.getTimer;

	public class Counter extends Sprite
	{
		//private var cursor:*;
		public var initTime:int = 0;
        public var startTime:int = 0;
        public var currentTime:int = 0;
        public var lastTime:int = 0;
        public var lastTickTime:int = 0;        
        public var loadDelay:int = 0;
        public var frameDelay:int = 0;
        public var elapsed:int = 0;
        public var delay:int = 0;
        public var currentCount:int = 0;

        public var millisecounds:int = 0;
        public var secounds:int = 0;
        public var minutes:int = 0;

		public function Counter(_delay:int)
		{
            delay = _delay;
            initTime = getTimer();
            
		}
        
        public function start():void
        {
            startTime = getTimer();
            loadDelay = startTime - initTime;
        }

		public function update():void
		{
            lastTime = currentTime;
			currentTime = getTimer();
            frameDelay = currentTime - lastTime;

            elapsed = currentTime - lastTickTime;
            if (elapsed >= delay)
            {
                lastTickTime = getTimer();
                currentCount++;
            }

            //secounds = (currentTime / 1000) % 60;
            secounds = millisecToSec(currentTime);
            //minutes = (currentTime / 1000) / 60;
            minutes = millisecToMin(currentTime);
		}

        public static function millisecToSec(_milliSec:int):int
        {
           return (_milliSec / 1000) % 60;
        }

        public static function millisecToMin(_milliSec:int):int
        {
           return (_milliSec / 1000) / 60;
        }
	}
}