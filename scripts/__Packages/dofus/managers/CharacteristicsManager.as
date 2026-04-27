class dofus.managers.CharacteristicsManager
{
   var _Effects;
   var _Moderators;
   static var LIFE_POINTS = 0;
   static var ACTION_POINTS = 1;
   static var GOLD = 2;
   static var STATS_POINTS = 3;
   static var EXPERIENCE = 4;
   static var LEVEL = 5;
   static var STRENGTH = 10;
   static var VITALITY = 11;
   static var WISDOM = 12;
   static var CHANCE = 13;
   static var AGILITY = 14;
   static var INTELLIGENCE = 15;
   static var DAMAGES = 16;
   static var DAMAGES_FACTOR = 17;
   static var CRITICAL_HIT = 18;
   static var RANGE = 19;
   static var MOVE_POINTS = 23;
   static var INVISIBILITY = 24;
   static var RETURN_SPELL = 30;
   static var RETURN_DAMAGES = 31;
   function CharacteristicsManager(characData)
   {
      this.initialize(characData);
   }
   function initialize(characData)
   {
      var _loc2_ = this;
      _loc2_._characData = characData;
      _loc2_._Effects = new Array();
      _loc2_._Moderators = new Array(20);
      var _loc1_ = 0;
      while(_loc1_ < _loc2_._Moderators.length)
      {
         _loc2_._Moderators[_loc1_] = 0;
         _loc1_ = _loc1_ + 1;
      }
   }
   function getEffects()
   {
      return this._Effects;
   }
   function getModeratorValue(type)
   {
      var _loc1_ = Number(type);
      return this._Moderators[_loc1_];
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
         if(_loc2_.remainingTurn < 0)
         {
            _loc3_.onEffectEnd(_loc2_);
            _loc3_._Effects.splice(_loc1_,_loc1_ + 1);
         }
      }
   }
   function onEffectStart(effect)
   {
      var _loc1_ = effect;
      var _loc2_ = this;
      switch(_loc1_.type)
      {
         case dofus.managers.CharacteristicsManager.LIFE_POINTS:
         case dofus.managers.CharacteristicsManager.ACTION_POINTS:
         case dofus.managers.CharacteristicsManager.GOLD:
         case dofus.managers.CharacteristicsManager.STATS_POINTS:
         case dofus.managers.CharacteristicsManager.EXPERIENCE:
         case dofus.managers.CharacteristicsManager.LEVEL:
         case dofus.managers.CharacteristicsManager.STRENGTH:
         case dofus.managers.CharacteristicsManager.VITALITY:
         case dofus.managers.CharacteristicsManager.WISDOM:
         case dofus.managers.CharacteristicsManager.CHANCE:
         case dofus.managers.CharacteristicsManager.AGILITY:
         case dofus.managers.CharacteristicsManager.INTELLIGENCE:
         case dofus.managers.CharacteristicsManager.DAMAGES:
         case dofus.managers.CharacteristicsManager.DAMAGES_FACTOR:
         case dofus.managers.CharacteristicsManager.CRITICAL_HIT:
         case dofus.managers.CharacteristicsManager.RANGE:
         case dofus.managers.CharacteristicsManager.MOVE_POINTS:
            _loc2_._Moderators[Number(_loc1_.type)] += Number(_loc1_.value);
            return;
         case dofus.managers.CharacteristicsManager.INVISIBILITY:
            if(_loc1_.value)
            {
               _loc2_._characData.sprite_mc.setAlpha(40);
            }
            else
            {
               _loc2_._characData.sprite_mc.setVisible(false);
            }
            return;
         default:
            ank.utils.Logger.err("Mauvais type d\'effet");
            return;
      }
   }
   function onEffectEnd(effect)
   {
      var _loc1_ = effect;
      var _loc2_ = this;
      switch(_loc1_.type)
      {
         case dofus.managers.CharacteristicsManager.LIFE_POINTS:
         case dofus.managers.CharacteristicsManager.GOLD:
         case dofus.managers.CharacteristicsManager.STATS_POINTS:
         case dofus.managers.CharacteristicsManager.EXPERIENCE:
         case dofus.managers.CharacteristicsManager.LEVEL:
         case dofus.managers.CharacteristicsManager.VITALITY:
         case dofus.managers.CharacteristicsManager.WISDOM:
         case dofus.managers.CharacteristicsManager.CHANCE:
         case dofus.managers.CharacteristicsManager.AGILITY:
         case dofus.managers.CharacteristicsManager.INTELLIGENCE:
         case dofus.managers.CharacteristicsManager.DAMAGES:
         case dofus.managers.CharacteristicsManager.DAMAGES_FACTOR:
         case dofus.managers.CharacteristicsManager.CRITICAL_HIT:
         case dofus.managers.CharacteristicsManager.RANGE:
         case dofus.managers.CharacteristicsManager.MOVE_POINTS:
            _loc2_._Moderators[Number(_loc1_.type)] -= Number(_loc1_.value);
            return;
         case dofus.managers.CharacteristicsManager.MOVE_POINTS:
            _loc2_._Moderators[Number(_loc1_.type)] -= Number(_loc1_.value);
            _loc2_._characData.MP -= _loc2_._characData.MP <= 0 ? 0 : Number(_loc1_.value);
            return;
         case dofus.managers.CharacteristicsManager.ACTION_POINTS:
            _loc2_._Moderators[Number(_loc1_.type)] -= Number(_loc1_.value);
            _loc2_._characData.AP -= _loc2_._characData.AP <= 0 ? 0 : Number(_loc1_.value);
            return;
         case dofus.managers.CharacteristicsManager.STRENGTH:
            _loc2_._Moderators[Number(_loc1_.type)] -= Number(_loc1_.value);
            _loc2_._characData.force -= _loc2_._characData.force <= 0 ? 0 : Number(_loc1_.value);
            return;
         case dofus.managers.CharacteristicsManager.INVISIBILITY:
            if(_loc1_.value)
            {
               _loc2_._characData.sprite_mc.setAlpha(100);
            }
            else
            {
               _loc2_._characData.sprite_mc.setVisible(true);
            }
            return;
         default:
            ank.utils.Logger.err("Mauvais type d\'effet");
            return;
      }
   }
}
