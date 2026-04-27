class ank.utils.Sequencer extends Object
{
   var _actions;
   var bPlaying;
   function Sequencer(timeout)
   {
      super();
      this.initialize(timeout);
   }
   function initialize(timeout)
   {
      var _loc1_ = this;
      _loc1_._timeOut = timeout != undefined ? timeout : 10000;
      _loc1_._unicID = String(getTimer()) + random(10000);
      _loc1_._actionIndex = 0;
      _loc1_.clear();
   }
   function clear(Void)
   {
      var _loc1_ = this;
      _loc1_._actions = new Array();
      _loc1_.bPlaying = false;
      ank.utils.Timer.removeTimer(_loc1_);
   }
   function addAction(_waitEnd, _object, _function, _parameters, _duration)
   {
      var _loc1_ = new Object();
      _loc1_.id = this.getActionIndex();
      _loc1_.waitEnd = _waitEnd;
      _loc1_.object = _object;
      _loc1_.fn = _function;
      _loc1_.parameters = _parameters;
      _loc1_.duration = _duration;
      this._actions.push(_loc1_);
   }
   function execute(bForced)
   {
      var _loc2_ = this;
      var _loc1_;
      if(!(_loc2_.bPlaying && bForced == undefined))
      {
         _loc2_.bPlaying = true;
         if(_loc2_._actions.length > 0)
         {
            _loc1_ = _loc2_._actions[0];
            if(_loc1_.waitEnd)
            {
               _loc1_.object[_loc2_._unicID] = _loc1_.id;
            }
            _loc1_.fn.apply(_loc1_.object,_loc1_.parameters);
            if(!_loc1_.waitEnd)
            {
               _loc2_.onActionEnd(_loc1_.id);
            }
            else
            {
               ank.utils.Timer.setTimer(_loc1_.object,_loc2_,_loc2_.onActionTimeOut,_loc1_.duration == undefined ? _loc2_._timeOut : _loc1_.duration,[_loc1_.id]);
            }
         }
         else
         {
            _loc2_.stop();
         }
      }
   }
   function stop()
   {
      this.bPlaying = false;
   }
   function isPlaying()
   {
      return this.bPlaying;
   }
   function clearAllNextActions(Void)
   {
      this._actions.splice(1);
      ank.utils.Timer.removeTimer(this);
   }
   function onActionTimeOut(actionID)
   {
      var _loc1_ = actionID;
      if(!(_loc1_ != undefined && this._actions[0].id != _loc1_))
      {
         this.onActionEnd(_loc1_);
      }
   }
   function onActionEnd(actionID)
   {
      var _loc1_ = this;
      if(_loc1_._actions.length != 0)
      {
         if(_loc1_._actions[0].waitEnd)
         {
            ank.utils.Timer.removeTimer(_loc1_._actions[0].object);
         }
         _loc1_._actions.shift();
         if(_loc1_._actions.length == 0)
         {
            _loc1_.clear();
            _loc1_.onSequenceEnd();
         }
         else if(_loc1_.bPlaying)
         {
            _loc1_.execute(true);
         }
      }
   }
   function getActionIndex(Void)
   {
      var _loc1_ = this;
      _loc1_._actionIndex = _loc1_._actionIndex + 1;
      if(_loc1_._actionIndex > 10000)
      {
         _loc1_._actionIndex = 0;
      }
      return _loc1_._actionIndex;
   }
}
