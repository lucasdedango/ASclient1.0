class ank.utils.CyclicTimer
{
   static var _functions = new Array();
   static var _interval = 40;
   static var bPlaying = false;
   static var _cyclicTimer = new ank.utils.CyclicTimer();
   function CyclicTimer()
   {
      super();
   }
   static function addFunction(objRef, objFn, fn, args, objFnEnd, fnEnd, argsEnd)
   {
      var _loc1_ = new Object();
      _loc1_.objRef = objRef;
      _loc1_.objFn = objFn;
      _loc1_.fn = fn;
      _loc1_.args = args;
      _loc1_.objFnEnd = objFnEnd;
      _loc1_.fnEnd = fnEnd;
      _loc1_.argsEnd = argsEnd;
      ank.utils.CyclicTimer._functions.push(_loc1_);
      ank.utils.CyclicTimer.play();
   }
   static function removeFunction(objRef)
   {
      var _loc3_ = objRef;
      var _loc1_ = ank.utils.CyclicTimer._functions.length - 1;
      var _loc2_;
      while(_loc1_ >= 0)
      {
         _loc2_ = ank.utils.CyclicTimer._functions[_loc1_];
         if(_loc3_ == _loc2_.objRef)
         {
            ank.utils.CyclicTimer._functions.splice(_loc1_,1);
         }
         _loc1_ = _loc1_ - 1;
      }
   }
   static function clear()
   {
      ank.utils.CyclicTimer.stop();
      ank.utils.CyclicTimer._functions = new Array();
   }
   static function play()
   {
      if(ank.utils.CyclicTimer.bPlaying)
      {
         return undefined;
      }
      ank.utils.CyclicTimer.bPlaying = true;
      ank.utils.CyclicTimer.doCycle();
   }
   static function stop()
   {
      ank.utils.CyclicTimer.bPlaying = false;
   }
   static function getInstance()
   {
      return ank.utils.CyclicTimer._cyclicTimer;
   }
   static function get interval()
   {
      return ank.utils.CyclicTimer._interval;
   }
   static function doCycle()
   {
      var _loc2_ = ank.utils.CyclicTimer._functions.length - 1;
      var _loc1_;
      while(_loc2_ >= 0)
      {
         _loc1_ = ank.utils.CyclicTimer._functions[_loc2_];
         if(!_loc1_.fn.apply(_loc1_.objFn,_loc1_.args))
         {
            ank.utils.CyclicTimer.onFunctionEnd(_loc2_,_loc1_);
         }
         _loc2_ = _loc2_ - 1;
      }
      if(ank.utils.CyclicTimer._functions.length != 0)
      {
         ank.utils.Timer.setTimer(ank.utils.CyclicTimer._cyclicTimer,ank.utils.CyclicTimer,ank.utils.CyclicTimer.doCycle,ank.utils.CyclicTimer._interval);
      }
      else
      {
         ank.utils.CyclicTimer.stop();
      }
   }
   static function onFunctionEnd(index, fn)
   {
      var _loc1_ = fn;
      _loc1_.fnEnd.apply(_loc1_.objFnEnd,_loc1_.argsEnd);
      ank.utils.CyclicTimer._functions.splice(index,1);
   }
}
