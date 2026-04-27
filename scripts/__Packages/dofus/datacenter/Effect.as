class dofus.datacenter.Effect extends Object
{
   var m_param1;
   var m_param2;
   var m_param3;
   var m_param4;
   var m_remainingTurn;
   var m_spellID;
   var m_type;
   function Effect(type, param1, param2, param3, param4, remainingTurn, spellID)
   {
      super();
      this.initialize(type,param1,param2,param3,param4,remainingTurn,spellID);
   }
   function initialize(type, param1, param2, param3, param4, remainingTurn, spellID)
   {
      var _loc1_ = this;
      _loc1_.m_type = Number(type);
      _loc1_.m_param1 = !isNaN(Number(param1)) ? Number(param1) : undefined;
      _loc1_.m_param2 = !isNaN(Number(param2)) ? Number(param2) : undefined;
      _loc1_.m_param3 = !isNaN(Number(param3)) ? Number(param3) : undefined;
      _loc1_.m_param4 = !isNaN(Number(param4)) ? Number(param4) : undefined;
      _loc1_.m_remainingTurn = remainingTurn != "-1" ? Number(remainingTurn) : Infinity;
      _loc1_.m_spellID = Number(spellID);
   }
   function get type()
   {
      return this.m_type;
   }
   function get param1()
   {
      return this.m_param1;
   }
   function get param2()
   {
      return this.m_param2;
   }
   function get param3()
   {
      return this.m_param3;
   }
   function get param4()
   {
      return this.m_param4;
   }
   function set remainingTurn(value)
   {
      this.m_remainingTurn = value;
   }
   function get remainingTurn()
   {
      return this.m_remainingTurn;
   }
   function get remainingTurnStr()
   {
      var _loc2_ = this;
      var _loc1_ = new String();
      if(isFinite(_loc2_.m_remainingTurn))
      {
         if(_loc2_.m_remainingTurn > 1)
         {
            _loc1_ = String(_loc2_.m_remainingTurn) + " " + ank.utils.Translator.getText("TURNS");
         }
         else if(_loc2_.m_remainingTurn == 0)
         {
            _loc1_ = ank.utils.Translator.getText("LAST_TURN");
         }
         else
         {
            _loc1_ = String(_loc2_.m_remainingTurn) + " " + ank.utils.Translator.getText("TURN");
         }
      }
      else
      {
         _loc1_ = ank.utils.Translator.getText("INFINIT");
      }
      return _loc1_;
   }
   function get spellID()
   {
      return this.m_spellID;
   }
   function get description()
   {
      var _loc1_ = this;
      var _loc2_ = ank.utils.Translator.getEffectInfos(_loc1_.m_type).d;
      var _loc3_ = ank.utils.PatternDecoder.getDescription(_loc2_,[_loc1_.param1,_loc1_.param2,_loc1_.param3,_loc1_.param4]);
      return _loc3_;
   }
   function get characteristic()
   {
      var _loc1_ = ank.utils.Translator.getEffectInfos(this.m_type).c;
      return Number(_loc1_);
   }
   function get operator()
   {
      return ank.utils.Translator.getEffectInfos(this.m_type).o;
   }
   function get spellName()
   {
      return ank.utils.Translator.getSpellInfos(this.m_spellID).n;
   }
}
