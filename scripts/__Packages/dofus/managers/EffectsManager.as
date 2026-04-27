class dofus.managers.EffectsManager
{
   var _Effects;
   var _characData;
   function EffectsManager(characData)
   {
      this.initialize(characData);
   }
   function initialize(characData)
   {
      this._characData = characData;
      this._Effects = new Array();
   }
   function getEffects()
   {
      return this._Effects;
   }
   function addEffect(effectData)
   {
      this._Effects.push(effectData);
      this.onEffectStart(effectData);
   }
   function terminateAllEffects()
   {
      var _loc2_ = this;
      var _loc1_ = _loc2_._Effects.length;
      var _loc3_;
      while((_loc1_ = _loc1_ - 1) >= 0)
      {
         _loc3_ = _loc2_._Effects[_loc1_];
         _loc2_.onEffectEnd(_loc3_);
         _loc2_._Effects.splice(_loc1_,_loc1_ + 1);
      }
   }
   function nextTurn()
   {
      var _loc3_ = this;
      var _loc1_ = _loc3_._Effects.length;
      var _loc2_;
      while((_loc1_ = _loc1_ - 1) >= 0)
      {
         _loc2_ = _loc3_._Effects[_loc1_];
         _loc2_.remainingTurn = _loc2_.remainingTurn - 1;
      }
   }
   function refresh()
   {
      var _loc2_ = this;
      var _loc1_ = _loc2_._Effects.length;
      var _loc3_;
      while((_loc1_ = _loc1_ - 1) >= 0)
      {
         _loc3_ = _loc2_._Effects[_loc1_];
         if(_loc3_.remainingTurn <= 0)
         {
            _loc2_.onEffectEnd(_loc3_);
            _loc2_._Effects.splice(_loc1_,_loc1_ + 1);
         }
      }
   }
   function onEffectStart(effect)
   {
   }
   function onEffectEnd(effect)
   {
      trace("on termine l\'effet (" + effect.spellName + ") " + effect.description);
   }
}
