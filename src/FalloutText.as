package
{
	import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
    import flash.text.AntiAliasType;
    import flash.filters.GlowFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.text.TextFieldAutoSize;
    import flash.display.Shape;
    import flash.display.Sprite;
	
	public class FalloutText extends Sprite
	{
        public var txt:TextField;
        private var txtFormat:TextFormat;
        private var shadow:DropShadowFilter;
        private var glow:GlowFilter;
        public var backgroundShape:Shape;
        private var backColor:uint = 0xF5CB5B;
        private var backAlpha:Number = 0.7;

        private var lines:int = 0;

		public function FalloutText( 
            _fontColor:uint = 0xFFFFCB,
            _fontSize:int = 22,
            _backColor:uint = 0xF5CB5B80,
            _backAlpha:Number = 0.7,
            _width:int = 300,
            _height:int = 100)
		{
            backColor = _backColor;
            backAlpha = _backAlpha;
            txt = new TextField();
			txtFormat = new TextFormat("$MAIN_Font_Light", _fontSize, _fontColor); //color: 16777163
			txtFormat.align = "left";
            txt.defaultTextFormat = txtFormat;
			txt.setTextFormat(txtFormat);
            txt.multiline = true;
            txt.wordWrap = false;
            txt.autoSize = TextFieldAutoSize.LEFT;
            txt.type = TextFieldType.DYNAMIC;
            txt.antiAliasType = AntiAliasType.ADVANCED;
            txt.background = false;
			//txt.name = "debugText";
			txt.text = "";
            this.width = _width;
            this.height = _height;
            backgroundShape = new Shape();
            drawBackground(backColor, backAlpha);

            shadow = new DropShadowFilter(0, 0, 0x000000, 1, 2, 2, 3, BitmapFilterQuality.HIGH);
            glow = new GlowFilter(0xF5CB5B, 1, 2, 2, 2, 3, true);
            txt.filters = [shadow];
            backgroundShape.filters = [shadow, glow];

            addChild(txt);
            addChildAt(backgroundShape, 0);
		}

        public function drawBackground(_color:uint = 0xF5CB5B, _alpha:Number = 0.7):void
        {
            backgroundShape.graphics.beginFill(_color, _alpha);
            backgroundShape.graphics.lineStyle(1, 0x332A13, 0.5, true);
            backgroundShape.graphics.drawRoundRect(x, y, txt.textWidth, txt.textHeight, 15, 5);
            backgroundShape.graphics.endFill();
        }

        /*public function addMessage(_message:String):void
        {
            txt.appendText(_message + "\r");
        }*/

        public function setMessage(_message:String):void
        {
            txt.text = _message;
            txt.width = 300;
            txt.height = 300;
            drawBackground(backColor, backAlpha);
        }

        public function setColor(_color:uint):void
        {
            txt.textColor = _color;
        }

        public function clear():void
        {
            txt.text = "";
        }
	}
}