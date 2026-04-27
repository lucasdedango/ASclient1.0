class dofus.managers.SpellsManager
{
   var _localPlayerData;
   function SpellsManager(d)
   {
      this.initialize(d);
   }
   function initialize(d)
   {
      this._localPlayerData = d;
      this.clear();
   }
   function clear()
   {
      var _loc1_ = this;
      _loc1_._spellsCountByTurn = new Array();
      _loc1_._spellsCountByTurn_Counter = new Array();
      _loc1_._spellsCountByPlayer = new Array();
      _loc1_._spellsCountByPlayer_Counter = new Array();
      _loc1_._spellsDelay = new Array();
   }
   function addLaunchedSpell(spellLaunchData)
   {
      var _loc1_ = spellLaunchData;
      var _loc2_ = this;
      var _loc3_ = _loc1_.m_spellData;
      var launchCountByTurn = _loc3_.m_LaunchCountByTurn;
      var launchCountByPlayerTurn = _loc3_.m_LaunchCountByPlayerTurn;
      var delayBetweenLaunch = _loc3_.m_DelayBetweenLaunch;
      if(launchCountByTurn != 0)
      {
         _loc2_._spellsCountByTurn.push(_loc1_);
         _loc2_._spellsCountByTurn_Counter[_loc1_.m_SpellID]++;
      }
      if(launchCountByPlayerTurn != 0)
      {
         if(_loc1_.m_characOnID != undefined)
         {
            _loc2_._spellsCountByPlayer.push(_loc1_);
            _loc2_._spellsCountByPlayer_Counter[_loc1_.m_SpellID]++;
         }
      }
      if(delayBetweenLaunch != 0)
      {
         _loc2_._spellsDelay.push(_loc1_);
      }
   }
   function nextTurn()
   {
      var _loc3_ = this;
      var _loc2_;
      _loc3_._spellsCountByTurn = new Array();
      _loc3_._spellsCountByTurn_Counter = new Object();
      _loc3_._spellsCountByPlayer = new Array();
      _loc3_._spellsCountByPlayer_Counter = new Object();
      var _loc1_ = _loc3_._spellsDelay.length;
      while((_loc1_ = _loc1_ - 1) >= 0)
      {
         _loc2_ = _loc3_._spellsDelay[_loc1_];
         _loc2_.m_RemainingTurn = _loc2_.m_RemainingTurn - 1;
         if(_loc2_.m_RemainingTurn <= 0)
         {
            _loc3_._spellsDelay.splice(_loc1_,_loc1_ + 1);
         }
      }
   }
   function checkCanLaunchSpell(spellID, characID)
   {
      var _loc2_ = this;
      var _loc3_ = spellID;
      var len;
      var _loc1_;
      var spellData;
      var launchCountByTurn;
      var launchCountByPlayerTurn;
      var i = _loc2_._spellsCountByTurn.length;
      while(--i >= 0)
      {
         _loc1_ = _loc2_._spellsCountByTurn[i];
         if(_loc1_.m_SpellID == _loc3_)
         {
            spellData = _loc1_.m_spellData;
            launchCountByTurn = spellData.m_LaunchCountByTurn;
            if(_loc2_._spellsCountByTurn_Counter[_loc3_] >= launchCountByTurn)
            {
               _loc2_._localPlayerData.errorMessage = ank.utils.Translator.getText("CANT_LAUNCH_MORE",[launchCountByTurn]);
               return false;
            }
         }
      }
      var i = _loc2_._spellsCountByPlayer.length;
      while(--i >= 0)
      {
         _loc1_ = _loc2_._spellsCountByPlayer[i];
         if(_loc1_.m_SpellID == _loc3_)
         {
            spellData = _loc1_.m_spellData;
            launchCountByPlayerTurn = spellData.m_LaunchCountByPlayerTurn;
            if(_loc1_.m_characOnID == characID && _loc2_._spellsCountByPlayer_Counter[_loc3_] >= launchCountByPlayerTurn)
            {
               _loc2_._localPlayerData.errorMessage = ank.utils.Translator.getText("CANT_ON_THIS_PLAYER");
               return false;
            }
         }
      }
      var i = _loc2_._spellsDelay.length;
      while(--i >= 0)
      {
         _loc1_ = _loc2_._spellsDelay[i];
         if(_loc1_.m_SpellID == _loc3_)
         {
            if(_loc1_.m_RemainingTurn >= 63)
            {
               _loc2_._localPlayerData.errorMessage = ank.utils.Translator.getText("CANT_RELAUNCH");
            }
            else
            {
               _loc2_._localPlayerData.errorMessage = ank.utils.Translator.getText("CANT_LAUNCH_BEFORE",[_loc1_.m_RemainingTurn]);
            }
            return false;
         }
      }
      return true;
   }
   function checkCanLaunchSpellOnCell(mapHandler, spellData, cellToData, rangeModerator)
   {
      var _loc1_ = spellData;
      var _loc2_ = cellToData;
      var _loc3_ = Number(this._localPlayerData.data.cellNum);
      var cellToNum = Number(_loc2_.mc.num);
      if(_loc3_ == cellToNum && !_loc1_.m_bOnItSelf)
      {
         return false;
      }
      if(ank.battlefield.utils.Pathfinding.checkRange(mapHandler,_loc3_,cellToNum,_loc1_.m_bLineOnly,_loc1_.m_Range,rangeModerator))
      {
         if(_loc1_.m_bFreeCell)
         {
            trace(_loc2_.SpriteOnID);
            if(_loc2_.movement > 1 && _loc2_.SpriteOnID != undefined)
            {
               return false;
            }
         }
         if(_loc1_.m_bLineOfSight)
         {
            if(ank.battlefield.utils.Pathfinding.checkView(mapHandler,_loc3_,cellToNum))
            {
               return this.checkCanLaunchSpell(_loc1_.m_ID,_loc2_.SpriteOnID);
            }
            return false;
         }
         return this.checkCanLaunchSpell(_loc1_.m_ID,_loc2_.SpriteOnID);
      }
      return false;
   }
}
