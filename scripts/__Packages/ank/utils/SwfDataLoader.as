class ank.utils.SwfDataLoader
{
   var _startLoadTimer;
   var dispatchEvent;
   static var MAX_TIMEOUT = 20000;
   function SwfDataLoader(oParams)
   {
      mx.events.EventDispatcher.initialize(this);
   }
   function load(sFile)
   {
      var _loc1_ = this;
      var _loc2_ = _level0.createEmptyMovieClip("__ANKSWFDATA__",0);
      _loc2_.loadMovie(sFile);
      ank.utils.CyclicTimer.addFunction(_loc1_,_loc1_,_loc1_.swfDataProgress,[_loc2_],_loc1_,_loc1_.swfDataInit,[_loc2_]);
      _loc1_._startLoadTimer = getTimer();
   }
   function swfDataProgress(mc)
   {
      var _loc2_ = mc.getBytesLoaded();
      var _loc1_ = mc.getBytesTotal();
      if(_loc1_ == -1)
      {
         if(getTimer() - this._startLoadTimer > ank.utils.SwfDataLoader.MAX_TIMEOUT)
         {
            return false;
         }
      }
      if(_loc2_ == _loc1_ && _loc1_ != 0)
      {
         return false;
      }
      return true;
   }
   function swfDataInit(mc)
   {
      var _loc1_ = this;
      ank.utils.Timer.setTimer(_loc1_,_loc1_,_loc1_.checkSwfDataLoaded,5,[mc]);
   }
   function checkSwfDataLoaded(mc)
   {
      var _loc1_ = mc;
      var _loc2_ = this;
      var nBT = _loc1_.getBytesTotal();
      var _loc0_;
      var _loc3_;
      if(nBT == -1)
      {
         _loc2_.dispatchEvent({type:"nofile"});
      }
      else
      {
         var _temp_1 = §§enumeration();
         §§enumerate(_loc1_);
         if((_loc0_ = _temp_1) != null)
         {
            _loc3_ = _loc0_;
            _loc2_.swfDataLoaded(_loc1_);
         }
         else
         {
            _loc2_.swfDataInit(_loc1_);
         }
      }
   }
   function swfDataLoaded(mc)
   {
      var _loc1_ = mc.getBytesTotal();
      if(_loc1_ == -1)
      {
         this.dispatchEvent({type:"nofile"});
      }
      else
      {
         this.dispatchEvent({type:"loaded",data:mc});
      }
   }
}
