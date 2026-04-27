class ank.utils.Timer extends Object
{
   static var _timerIndex = 0;
   static var _IDs = new Object();
   static var _timer = new ank.utils.Timer();
   function Timer()
   {
      super();
   }
   static function setTimer(objRef, objFn, fn, interval, args)
   {
      var _loc3_ = objRef;
      ank.utils.Timer.garbageCollector();
      var _loc2_ = ank.utils.Timer.getNextTimerIndex();
      var _loc1_ = setInterval(ank.utils.Timer.getInstance(),"onTimer",interval,_loc2_,_loc3_,objFn,fn,args);
      _loc3_.__ANKTIMERID__ = _loc1_;
      ank.utils.Timer._IDs[_loc2_] = new Array(_loc3_,_loc1_);
   }
   static function clear()
   {
      for(var _loc1_ in ank.utils.Timer._IDs)
      {
         ank.utils.Timer.removeTimer(ank.utils.Timer._IDs[_loc1_][0],ank.utils.Timer._IDs[_loc1_][1]);
      }
   }
   static function removeTimer(objRef, timerIndex)
   {
      var _loc1_ = objRef;
      var _loc3_ = timerIndex;
      var _loc2_;
      if(_loc3_ == undefined)
      {
         if(_loc1_ == undefined)
         {
            return;
         }
         if(_loc1_.__ANKTIMERID__ == undefined)
         {
            return;
         }
         _loc2_ = _loc1_.__ANKTIMERID__;
      }
      else
      {
         _loc2_ = ank.utils.Timer._IDs[_loc3_][1];
      }
      clearInterval(_loc2_);
      delete _loc1_.__ANKTIMERID__;
      delete ank.utils.Timer._IDs[_loc3_];
   }
   static function getInstance()
   {
      return ank.utils.Timer._timer;
   }
   static function garbageCollector()
   {
      var _loc1_;
      for(var _loc2_ in ank.utils.Timer._IDs)
      {
         _loc1_ = ank.utils.Timer._IDs[_loc2_];
         if(_loc1_[0] == undefined || typeof _loc1_[0] == "movieclip" && _loc1_[0]._name == undefined || _loc1_[0].__ANKTIMERID__ != _loc1_[1])
         {
            clearInterval(_loc1_[1]);
            delete ank.utils.Timer._IDs[_loc2_];
         }
      }
   }
   static function getNextTimerIndex()
   {
      return ank.utils.Timer._timerIndex++;
   }
   function onTimer(timerIndex, objRef, objFn, fn, args)
   {
      var _loc1_ = objRef;
      var _loc2_ = timerIndex;
      if(_loc1_ == undefined)
      {
         ank.utils.Timer.removeTimer(undefined,_loc2_);
      }
      else if(_loc1_.__ANKTIMERID__ == undefined)
      {
         ank.utils.Timer.removeTimer(undefined,_loc2_);
      }
      else
      {
         ank.utils.Timer.removeTimer(_loc1_,_loc2_);
         delete _loc1_.__ANKTIMERID__;
         fn.apply(objFn,args);
         ank.utils.Timer.garbageCollector();
      }
   }
}
