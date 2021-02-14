package
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality;
	
	public class AnimatedCursor extends Sprite
	{
		//private var cursor:*;
		private var cfg:Object;
		private var cursorShape:Shape;
		private var clickCircle:Sprite;
        
		public function AnimatedCursor(_cfg:Object)
		{
            cfg = _cfg;
		}

        private function addFilters():void
		{
			//Empty filters on upper level
			filters = new Array();
			//Get current filters
			var cursorFilters:Array = cursorShape.filters
			//index 0 -> Color change
			//index 1 -> Glow
			//cursorFilters[0] = cursorColorMatrixFilter;
			cursorFilters[0] = [new GlowFilter(0xff0000,1.0,8,8,1.5,BitmapFilterQuality.HIGH,false,false)];
			cursorShape.filters = cursorFilters;
		}
	}
}