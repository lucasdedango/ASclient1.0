class dofus.managers.NightManager
{
   var _battlefield;
   var _nIntervalID;
   static var STATE_COLORS = [undefined,dofus.Constants.NIGHT_COLOR];
   function NightManager(mspd, hpd, tz, b)
   {
      var _loc1_ = this;
      _loc1_._nMillisecondsPerDay = mspd;
      _loc1_._nHoursPerDay = hpd;
      _loc1_._aSequence = tz;
      _loc1_._battlefield = b;
      _loc1_._nMillisecondsPersHours = _loc1_._nMillisecondsPerDay / _loc1_._nHoursPerDay;
   }
   function get time()
   {
      var _loc2_ = this;
      var _loc3_ = getTimer() - _loc2_._nSaveTime;
      var nCurrentTime = (_loc2_._nRefTime + _loc3_) % _loc2_._nMillisecondsPerDay;
      var _loc1_ = nCurrentTime / _loc2_._nMillisecondsPersHours;
      var nMinutes = Math.floor((_loc1_ - Math.floor(_loc1_)) * 60);
      return Math.floor(_loc1_) + ":" + nMinutes;
   }
   function setReferenceTime(nTine)
   {
      var _loc1_ = this;
      _loc1_._nRefTime = nTine;
      _loc1_._nSaveTime = getTimer();
      _loc1_.clear();
      _loc1_.setState(nTine);
   }
   function clear()
   {
      clearInterval(this._nIntervalID);
   }
   function noEffects()
   {
      this.clear();
      this._battlefield.setColor();
   }
   function setState(nRefTime)
   {
      var _loc3_ = this;
      var _loc1_;
      var _loc2_;
      if(nRefTime < 0)
      {
         ank.utils.Logger.err("[setState] ... une date négative ?? " + nRefTime);
      }
      else
      {
         if(nRefTime >= _loc3_._nMillisecondsPerDay)
         {
            nRefTime = 0;
         }
         _loc1_ = 0;
         while(true)
         {
            if(_loc1_ >= _loc3_._aSequence.length)
            {
               ank.utils.Logger.err("[setState] ... heu la date " + nRefTime + " n\'est pas dans la séquence");
               break;
            }
            _loc2_ = _loc3_._aSequence[_loc1_][1];
            if(nRefTime < _loc2_)
            {
               var oStateColor = _loc3_._aSequence[_loc1_][2];
               _loc3_.applyState(oStateColor,_loc2_ - nRefTime,_loc2_);
               break;
            }
            _loc1_ = _loc1_ + 1;
         }
      }
   }
   function applyState(oStateColor, nDelay, nEndTime)
   {
      var _loc1_ = this;
      _loc1_._battlefield.setColor(oStateColor);
      _loc1_.clear();
      _loc1_._nIntervalID = setInterval(_loc1_,"setState",nDelay,nEndTime);
   }
}
