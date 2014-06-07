package 
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @author P.J.Shand
	 */
	public class LoaderMain extends Sprite 
	{
		private var loader:Loader;
		private var request:URLRequest;
		private var url:String;
		private var bytesTotal:int;
		private var bytesLoaded:int;
		private var ldr:Loader;
		
		private var clearCache:Boolean = true;
		
		public function LoaderMain():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			/*url = "FluidSolver.swf";
			request = new URLRequest(url);
			loader = new Loader();
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, OnLoadComplete);*/
			//loader.load(request);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.HIGH;
			
			loadAsset("FluidSolver.swf");
		}
		
		/*
		
		private function OnLoadComplete(e:Event):void 
		{
			trace("OnLoadComplete");
			//addChild(loader.content);
			
		}*/
		
		
		private function loadAsset(loadURL:String):void
		{
			if (clearCache) {
				loadURL += "?=random=" + Math.random();
			}
			
			var ldrContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain); 
			
			ldr = new Loader();
			ldr.load(new URLRequest(loadURL), ldrContext);
			ldr.contentLoaderInfo.addEventListener(Event.INIT, loadStart);
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			ldr.contentLoaderInfo.addEventListener(ErrorEvent.ERROR, loadError);
			ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			ldr.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, OnProgress);
			ldr.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadError);
		}
		
		private function OnProgress(e:ProgressEvent):void 
		{
			bytesTotal = e.bytesTotal;
			bytesLoaded = e.bytesLoaded;
		}
		
		private function loadStart(e:Event):void
		{
			trace("load start");
			ldr.contentLoaderInfo.removeEventListener(Event.INIT, loadStart);
		}
		
		private function loadError(e:Event):void
		{
			trace("load error");
			ldr.contentLoaderInfo.removeEventListener(ErrorEvent.ERROR, loadError);
			ldr.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadError);
			ldr.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loadError);
		}
		
		private function loadComplete(e:Event):void
		{
			trace("load complete");
			ldr.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
			addChild(e.target.content) as DisplayObject;
		}
	}
}