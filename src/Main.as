package
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.BitmapFilterQuality;
	import flash.display.StageScaleMode;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	import flash.system.SecurityDomain;
	import flash.ui.MouseCursor;
	import flash.utils.getTimer;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.AntiAliasType;
	
	public class Main extends Sprite
	{
		private var topLevel:* = null;
		private var cursor:*;
		private var cursorShape:Shape;
		private var cfg:Object;
		private var debugTxt:FalloutText;
		private var cursorAni:AnimatedCursor;
		private var counter:Counter;
		private var mouseInfo:MouseInfo;
		private var tempTxt:TextField;

		public function Main()
		{
			//Events
			/*
			if (stage) onStageInit();
			else addEventListener(Event.ADDED_TO_STAGE, onStageInit);
			*/
			counter = new Counter(1000);

			addEventListener(Event.ADDED_TO_STAGE, onStageInit);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);	
		}

		private function onStageInit(e:Event = null):void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//Get the top level display object named root1
			topLevel = stage.getChildAt(0);
			mouseInfo = new MouseInfo();
			if (topLevel != null)
			{
				
				counter.start();
				trace("loading: " + "../CursorConfig.json");
				loadJSON("../CursorConfig.json");
			}
			else
			{
				trace("Error: Can't find root1");
			}

			debugTxt = new FalloutText(0xFFFFCB, 22, 0xF5CB5B, 0.7, 200, 500);
			tempTxt = new TextField();
			var txtFormat:TextFormat = new TextFormat("$MAIN_Font_Light", 22, 0xffffcb); //color: 16777163
			txtFormat.align = "left";
            tempTxt.defaultTextFormat = txtFormat;
			tempTxt.setTextFormat(txtFormat);
            tempTxt.multiline = true;
            tempTxt.wordWrap = false;
            tempTxt.autoSize = TextFieldAutoSize.LEFT;
            tempTxt.type = TextFieldType.DYNAMIC;
            tempTxt.antiAliasType = AntiAliasType.ADVANCED;
            tempTxt.background = false;
			tempTxt.text = "FLASH PLAYER DEBUG TEXT";
			tempTxt.x = 960;
			tempTxt.y = 540;
			addChild(tempTxt);
			addChild(debugTxt);
		}

		private function runInGame():void
		{
			cursor = topLevel.Cursor_mc;
			cursorShape = topLevel.Cursor_mc.getChildAt(0);
			cursorShape.rotation += 31;
			cursorShape.x -= 2;
			cursorShape.y += 1.5;
			cursorAni = new AnimatedCursor(cfg);
			cursor.addChild(mouseInfo);
			
			addEvents();

		}

		private function runOutsideGame():void
		{
			cursorAni = new AnimatedCursor(cfg);
			
			addChild(mouseInfo);
			//addEvents();
		}

		//Main loop
		private function onEnterFrame(e:Event):void
        {
			counter.update();
			mouseInfo.update();
			displayTimerInfo();
			tempTxt.text = tempTxt.width + " | " + tempTxt.height;
        }

        //JSON loader
		private function loadJSON(fileName:String):void
		{
			var urlRequest:URLRequest  = new URLRequest(fileName);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, decodeJSON);
			try {
				loader.load(urlRequest);
			} catch (error:Error) {
        		trace("Cannot load: " + error.message);
			}
		}
		//JSON decoding handler
		private function decodeJSON(e:Event):void 
		{
			var loader:URLLoader = URLLoader(e.target) ;
			cfg = JSON.parse(loader.data);
			
			checkRunMode();
		}

		private function checkRunMode():void
		{
			//No configuration case
			if (cfg == null)
			{
				trace("Can't find config");
				//debugTxt.setMessage("Can't find config");
			}
			else
			{
				trace("Configuration found, version: " + cfg.version);
				/*for each(var options:Object in cfg)
				{
					trace(options);
				}*/
				//In game or outside
				if (topLevel.numChildren > 0 && topLevel.getChildAt(0).name == "Cursor_mc")
				{
					trace("Injected in: " + topLevel.getChildAt(0).name);
					runInGame();
				}
				else //if (topLevel.getChildAt(0).name == "instance1")
				{
					trace("Not injected, running standalone as: " + topLevel.name + " | " + topLevel.getChildAt(0).name)
					runOutsideGame();
				}
				/*else
				{
					trace("nothing ? . . .");
				}*/
			}
		}

		private function addEvents():void
		{
			trace("adding events . . .");
		}

		private function onMouseMove(e:MouseEvent):void
		{
			
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			//isMouseDown = true;
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			//isMouseDown = false;
		}

		//Show Flash player security panel
		//Work outside the game not in Fallout 76
		private function securitySettings():void
		{
			Security.showSettings(SecurityPanel.LOCAL_STORAGE);
		}

		private function displayTimerInfo():void
		{
			var info:String = "";
			info += "initTime: " + counter.initTime + "\r";
			info += "startTime: " + counter.startTime + "\r";
			info += "currentTime: " + counter.currentTime + "\r";
			info += "loadDelay: " + counter.loadDelay.toString() + "\r";
            info += "frameDelay: " + counter.frameDelay.toString() + "\r";
			info += "currentCount: " + counter.currentCount.toString() + "\r";
			info += "secounds: " + counter.secounds.toString() + "\r";
			info += "minutes: " + counter.minutes.toString();
			debugTxt.setMessage(info);
			//debugTxt.txt.width = 150;
			//debugTxt.txt.height = 400;
		}
	}
}