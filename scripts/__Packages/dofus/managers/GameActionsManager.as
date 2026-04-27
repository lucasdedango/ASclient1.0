class dofus.managers.GameActionsManager
{
   var _currentType;
   var _data;
   var _id;
   var _state;
   static var STATE_TRANSMITTING = 2;
   static var STATE_IN_PROGRESS = 1;
   static var STATE_READY = 0;
   function GameActionsManager(d)
   {
      this.initialize(d);
   }
   function initialize(d)
   {
      this._data = d;
      this.clear();
   }
   function clear(Void)
   {
      var _loc1_ = this;
      _loc1_._id = undefined;
      _loc1_._bNextAction = false;
      _loc1_._state = dofus.managers.GameActionsManager.STATE_READY;
      _loc1_._currentType = null;
   }
   function transmittingMove(type, params)
   {
      var _loc1_ = this;
      var _loc2_ = type;
      if(!_loc1_.isWaiting())
      {
         _global.AKS.Game.sendActions(_loc2_,params);
         _loc1_._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
         _loc1_._currentType = _loc2_;
      }
      else if(_loc1_.canCancel(_loc2_))
      {
         _loc1_.cancel(_loc1_._data.CellNum);
         _loc1_.transmittingMove(_loc2_,params);
      }
      else
      {
         ank.utils.Logger.err("L\'état de l\'action ne permet pas de faire ceci");
      }
   }
   function transmittingOther(type, params)
   {
      var _loc1_ = this;
      if(!_loc1_.isWaiting())
      {
         _global.AKS.Game.sendActions(type,params);
         _loc1_._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
         _loc1_._currentType = type;
      }
      else
      {
         ank.utils.Logger.err("L\'état de l\'action ne permet pas de faire ceci");
      }
   }
   function onServerResponse(id)
   {
      this._id = id;
      this._state = dofus.managers.GameActionsManager.STATE_IN_PROGRESS;
   }
   function cancel(params)
   {
      var _loc1_ = this;
      _loc1_._currentType = null;
      var _loc2_;
      if(_loc1_.canCancel())
      {
         _global.AKS.Game.ActionCancel(_loc1_._id,params);
         _loc2_ = _loc1_._data.sequencer;
         var s = _loc1_._data.sprite_mc;
         _loc2_.clearAllNextActions();
         _loc1_.clear();
      }
   }
   function end(bIAmSender)
   {
      var _loc1_ = this;
      if(_loc1_._bNextAction == false || !bIAmSender)
      {
         _loc1_.clear();
      }
      else
      {
         _loc1_._state = dofus.managers.GameActionsManager.STATE_TRANSMITTING;
         _loc1_._id = undefined;
      }
   }
   function ack(idAction)
   {
      _global.AKS.Game.ActionAck(idAction);
      this.end(true);
   }
   function isWaiting(Void)
   {
      switch(this._state)
      {
         case dofus.managers.GameActionsManager.STATE_READY:
            return false;
         case dofus.managers.GameActionsManager.STATE_TRANSMITTING:
         case dofus.managers.GameActionsManager.STATE_IN_PROGRESS:
            return true;
         default:
            return false;
      }
   }
   function canCancel(type)
   {
      if(type != this._currentType)
      {
         return false;
      }
      switch(this._state)
      {
         case dofus.managers.GameActionsManager.STATE_TRANSMITTING:
            return false;
         case dofus.managers.GameActionsManager.STATE_READY:
         case dofus.managers.GameActionsManager.STATE_IN_PROGRESS:
            return true;
         default:
            return false;
      }
   }
}
