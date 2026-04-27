class ank.utils.SWFLoader extends MovieClip
{
   var _frameStart;
   var swf_mc;
   function SWFLoader()
   {
      super();
      AsBroadcaster.initialize(this);
      this.initialize(0);
   }
   function initialize(frame)
   {
      this.clear();
      this._frameStart = frame == undefined ? 1 : frame;
   }
   function clear()
   {
      this.createEmptyMovieClip("swf_mc",10);
   }
   function remove()
   {
      this.swf_mc.__proto__ = MovieClip.prototype;
      this.swf_mc.removeMovieClip();
   }
   function loadSWF(file, frame, args)
   {
      var _loc1_ = this;
      _loc1_.initialize(frame);
      _loc1_.swf_mc.onInitFrame = function()
      {
         var _loc1_ = this;
         if(_loc1_._parent._frameStart != undefined)
         {
            _loc1_.gotoAndStop(_loc1_._parent._frameStart); //unpopped
         }
         _loc1_._parent.broadcastMessage("onLoadComplete",_loc1_,args);
      };
      _loc1_.swf_mc.loadMovie(file);
   }
}
