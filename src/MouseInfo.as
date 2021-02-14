package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
      import flash.geom.Point;
      import flash.text.TextField;

      public class MouseInfo extends Sprite
      {
            public var infoTxt:FalloutText;
            public var infoStr:String;
            public var currentPosition:Point;
            public var lastPosition:Point;
            public var distancePoint:Point;
            public var distance:Number;
            public var speed:Number;
            public var direction:Number;

            public function MouseInfo()
            {
                  currentPosition = new Point();
                  lastPosition = new Point();
                  distancePoint = new Point();
                  distance = 0;
                  speed = 0;
                  direction = 0;
                  infoTxt = new FalloutText(0xFFFFCB, 18, 0xF5CB5B80, 150, 75);
                  infoStr = "";
                  addChild(infoTxt);
            }

            public function update():void
            {
                  lastPosition = currentPosition;
                  currentPosition.x = this.mouseX;
                  currentPosition.y = this.mouseY;
                  this.x = currentPosition.x + 15;
                  this.y = currentPosition.y - infoTxt.height;
                  distancePoint = currentPosition.subtract(lastPosition);
                  distance = distancePoint.length;
                  speed = distance / ((getTimer() / 1000) % 60);
                  
                  infoStr += currentPosition.toString() + "\r";
                  infoStr += distancePoint.toString() + "\r";
                  infoStr += distance.toString() + "\r";
                  infoStr += speed.toString() + "\r";
                  infoTxt.setMessage(infoStr);
            }
	}
}