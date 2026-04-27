class dofus.datacenter.LocalPlayer extends Object
{
   var Inventory;
   var Spells;
   var SpellsUsed;
   var _agility;
   var _agilityxtra;
   var _ap;
   var _bonusPoints;
   var _bonusPointsSpell;
   var _chance;
   var _chancextra;
   var _color1;
   var _color2;
   var _color3;
   var _datacenter;
   var _energy;
   var _force;
   var _forcextra;
   var _guild;
   var _id;
   var _intelligence;
   var _intelligencextra;
   var _kama;
   var _level;
   var _login;
   var _lp;
   var _lpmax;
   var _mp;
   var _nCurrentJobID;
   var _nCurrentWeight;
   var _nMaxWeight;
   var _name;
   var _oWorldPosition;
   var _password;
   var _rangeModerator;
   var _sex;
   var _vitality;
   var _vitalityxtra;
   var _wisdom;
   var _wisdomxtra;
   var _xp;
   var _xphigh;
   var _xplow;
   var currentSpell;
   function LocalPlayer(d)
   {
      super();
      this.initialize(d);
   }
   function initialize(d)
   {
      var _loc1_ = this;
      _loc1_._datacenter = d;
      _loc1_.SpellsManager = new dofus.managers.SpellsManager(_loc1_);
      _loc1_.InteractionsManager = new dofus.managers.InteractionsManager(_loc1_);
      AsBroadcaster.initialize(_loc1_);
      _loc1_.Inventory = new ank.utils.ExtendedArray();
      _loc1_.Jobs = new ank.utils.ExtendedArray();
      _loc1_.Spells = new ank.utils.ExtendedObject();
      _loc1_.SpellsUsed = new ank.utils.ExtendedObject();
      _loc1_.SpellsAir = new Array();
      _loc1_.SpellsWater = new Array();
      _loc1_.SpellsEarth = new Array();
      _loc1_.SpellsFire = new Array();
      _loc1_.SpellsGuild = new Array();
      _loc1_.CCData = new Object();
      mx.events.EventDispatcher.initialize(_loc1_);
   }
   function get clip()
   {
      return this._datacenter.Sprites.getItemAt(this.ID).sprite_mc;
   }
   function get data()
   {
      return this._datacenter.Sprites.getItemAt(this.ID);
   }
   function get isCurrentPlayer()
   {
      return this._datacenter.Game.currentPlayerID == this.ID;
   }
   function get noMoreAP()
   {
      return this.data <= 0;
   }
   function set login(value)
   {
      this._login = value;
   }
   function get login()
   {
      return this._login;
   }
   function set password(value)
   {
      this._password = value;
   }
   function get password()
   {
      return this._password;
   }
   function set ID(value)
   {
      this._id = Number(value);
   }
   function get ID()
   {
      if(this._id == undefined)
      {
         ank.utils.Logger.err("Le joueur local n\'a pas encore d\'id");
         return undefined;
      }
      return this._id;
   }
   function set Name(value)
   {
      this._name = String(value);
   }
   function get Name()
   {
      return this._name;
   }
   function set Guild(value)
   {
      this._guild = Number(value);
   }
   function get Guild()
   {
      return this._guild;
   }
   function set Level(value)
   {
      var _loc1_ = this;
      _loc1_._level = Number(value);
      _loc1_.broadcastMessage("onSetLevel",value);
   }
   function get Level()
   {
      return this._level;
   }
   function set Sex(value)
   {
      this._sex = Number(value);
   }
   function get Sex()
   {
      return this._sex;
   }
   function set Color1(value)
   {
      this._color1 = Number(value);
   }
   function get Color1()
   {
      return this._color1;
   }
   function set Color2(value)
   {
      this._color2 = Number(value);
   }
   function get Color2()
   {
      return this._color2;
   }
   function set Color3(value)
   {
      this._color3 = Number(value);
   }
   function get Color3()
   {
      return this._color3;
   }
   function set LP(value)
   {
      var _loc1_ = this;
      var _loc2_ = value;
      _loc1_._lp = Number(_loc2_) <= 0 ? 0 : Number(_loc2_);
      _loc1_.dispatchEvent({type:"lpChanged",value:_loc2_});
      _loc1_.broadcastMessage("onSetLP",_loc2_);
   }
   function get LP()
   {
      return this._lp;
   }
   function set LPmax(value)
   {
      var _loc1_ = this;
      var _loc2_ = value;
      _loc1_._lpmax = Number(_loc2_);
      _loc1_.dispatchEvent({type:"lpmaxChanged",value:_loc2_});
      _loc1_.broadcastMessage("onSetLPmax",_loc2_);
   }
   function get LPmax()
   {
      return this._lpmax;
   }
   function set AP(value)
   {
      var _loc1_ = this;
      _loc1_._ap = Number(value);
      trace("Appppp");
      _loc1_.broadcastMessage("onSetAP",value);
   }
   function get AP()
   {
      return this._ap;
   }
   function set MP(value)
   {
      var _loc1_ = this;
      _loc1_._mp = Number(value);
      _loc1_.broadcastMessage("onSetMP",value);
   }
   function get MP()
   {
      return this._mp;
   }
   function set Kama(value)
   {
      var _loc1_ = this;
      var _loc2_ = value;
      _loc1_._kama = Number(_loc2_);
      _loc1_.dispatchEvent({type:"kamaChanged",value:_loc2_});
      _loc1_.broadcastMessage("onSetKama",_loc2_);
   }
   function get Kama()
   {
      return this._kama;
   }
   function set XPlow(value)
   {
      this._xplow = Number(value);
   }
   function get XPlow()
   {
      return this._xplow;
   }
   function set XP(value)
   {
      var _loc1_ = this;
      _loc1_._xp = Number(value);
      _loc1_.broadcastMessage("onSetXP",value);
   }
   function get XP()
   {
      return this._xp;
   }
   function set XPhigh(value)
   {
      this._xphigh = Number(value);
   }
   function get XPhigh()
   {
      return this._xphigh;
   }
   function set Force(value)
   {
      var _loc1_ = this;
      _loc1_._force = Number(value);
      _loc1_.broadcastMessage("onSetForce",value);
   }
   function get Force()
   {
      return this._force;
   }
   function set ForceXtra(value)
   {
      var _loc1_ = this;
      _loc1_._forcextra = Number(value);
      _loc1_.broadcastMessage("onSetForceXtra",value);
   }
   function get ForceXtra()
   {
      return this._forcextra;
   }
   function set Vitality(value)
   {
      var _loc1_ = this;
      _loc1_._vitality = Number(value);
      _loc1_.broadcastMessage("onSetVitality",value);
   }
   function get Vitality()
   {
      return this._vitality;
   }
   function set VitalityXtra(value)
   {
      var _loc1_ = this;
      _loc1_._vitalityxtra = Number(value);
      _loc1_.broadcastMessage("onSetVitalityXtra",value);
   }
   function get VitalityXtra()
   {
      return this._vitalityxtra;
   }
   function set Wisdom(value)
   {
      var _loc1_ = this;
      _loc1_._wisdom = Number(value);
      _loc1_.broadcastMessage("onSetWisdom",value);
   }
   function get Wisdom()
   {
      return this._wisdom;
   }
   function set WisdomXtra(value)
   {
      var _loc1_ = this;
      _loc1_._wisdomxtra = Number(value);
      _loc1_.broadcastMessage("onSetWisdomXtra",value);
   }
   function get WisdomXtra()
   {
      return this._wisdomxtra;
   }
   function set Chance(value)
   {
      var _loc1_ = this;
      _loc1_._chance = Number(value);
      _loc1_.broadcastMessage("onSetChance",value);
   }
   function get Chance()
   {
      return this._chance;
   }
   function set ChanceXtra(value)
   {
      var _loc1_ = this;
      _loc1_._chancextra = Number(value);
      _loc1_.broadcastMessage("onSetChanceXtra",value);
   }
   function get ChanceXtra()
   {
      return this._chancextra;
   }
   function set Agility(value)
   {
      var _loc1_ = this;
      _loc1_._agility = Number(value);
      _loc1_.broadcastMessage("onSetAgility",value);
   }
   function get Agility()
   {
      return this._agility;
   }
   function set AgilityXtra(value)
   {
      var _loc1_ = this;
      _loc1_._agilityxtra = Number(value);
      _loc1_.broadcastMessage("onSetAgilityXtra",value);
   }
   function get AgilityXtra()
   {
      return this._agilityxtra;
   }
   function set Intelligence(value)
   {
      var _loc1_ = this;
      _loc1_._intelligence = Number(value);
      _loc1_.broadcastMessage("onSetIntelligence",value);
   }
   function get Intelligence()
   {
      return this._intelligence;
   }
   function set IntelligenceXtra(value)
   {
      var _loc1_ = this;
      _loc1_._intelligencextra = Number(value);
      _loc1_.broadcastMessage("onSetIntelligenceXtra",value);
   }
   function get IntelligenceXtra()
   {
      return this._intelligencextra;
   }
   function set BonusPoints(value)
   {
      var _loc1_ = this;
      _loc1_._bonusPoints = Number(value);
      _loc1_.broadcastMessage("onSetBonusPoints",value);
   }
   function get BonusPoints()
   {
      return this._bonusPoints;
   }
   function set BonusPointsSpell(value)
   {
      var _loc1_ = this;
      var _loc2_ = value;
      _loc1_._bonusPointsSpell = Number(_loc2_);
      _loc1_.dispatchEvent({type:"bonusSpellsChanged",value:_loc2_});
      _loc1_.broadcastMessage("onSetBonusPointsSpell",_loc2_);
   }
   function get BonusPointsSpell()
   {
      return this._bonusPointsSpell;
   }
   function set RangeModerator(value)
   {
      var _loc1_ = this;
      _loc1_._rangeModerator = Number(value);
      _loc1_.broadcastMessage("onSetRangeModerator",value);
   }
   function get RangeModerator()
   {
      return this._rangeModerator;
   }
   function set Energy(value)
   {
      var _loc1_ = this;
      _loc1_._energy = Number(value);
      _loc1_.broadcastMessage("onSetEnergy",value);
   }
   function get Energy()
   {
      return this._energy;
   }
   function set currentJobID(value)
   {
      var _loc1_ = this;
      if(value == undefined)
      {
         delete _loc1_._nCurrentJobID;
      }
      else
      {
         _loc1_._nCurrentJobID = Number(value);
      }
   }
   function get currentJobID()
   {
      return this._nCurrentJobID;
   }
   function set worldPosition(value)
   {
      var _loc1_ = this;
      _loc1_._oWorldPosition = value;
      _loc1_.broadcastMessage("onSetWorldPosition",value);
   }
   function get worldPosition()
   {
      return this._oWorldPosition;
   }
   function set currentWeight(value)
   {
      var _loc1_ = this;
      _loc1_._nCurrentWeight = value;
      _loc1_.broadcastMessage("onSetCurrentWeight",value);
   }
   function get currentWeight()
   {
      return this._nCurrentWeight;
   }
   function set maxWeight(value)
   {
      var _loc1_ = this;
      _loc1_._nMaxWeight = value;
      _loc1_.broadcastMessage("onSetMaxWeight",value);
   }
   function get maxWeight()
   {
      return this._nMaxWeight;
   }
   function reset()
   {
      this.currentSpell = null;
   }
   function hasEnoughAP(wantedAP)
   {
      return this.data.AP >= wantedAP;
   }
   function setCCData(apcost, range, damages)
   {
      var _loc1_ = this;
      var _loc2_ = damages;
      var _loc3_ = _global.getGuildText(_loc1_._guild).cc;
      if(_loc2_ == undefined)
      {
         _loc2_ = _loc3_;
      }
      _loc1_.CCData = new Object();
      _loc1_.CCData.m_APCost = apcost != undefined ? apcost : _loc3_[4];
      _loc1_.CCData.m_Range = range != undefined ? range : 1;
      _loc1_.CCData.m_Description = ank.utils.PatternDecoder.getDescription(_global.getEffectText(_loc2_[0]).d,new Array(_loc2_[1],_loc2_[2],_loc2_[3]));
      _loc1_.CCData.m_bOnItSelf = false;
      _loc1_.CCData.iconFile = dofus.Constants.CCICON_FILE;
      _loc1_.CCData.m_bCC = true;
   }
   function addItem(itemData)
   {
      this.Inventory.push(itemData);
   }
   function updateItemQuantity(nItemNum, nQuantity)
   {
      var _loc1_ = this.Inventory.findFirstItem("ID",nItemNum);
      var _loc2_ = _loc1_.item;
      _loc2_.Quantity = nQuantity;
      this.Inventory.updateItem(_loc1_.index,_loc2_);
   }
   function updateItemPosition(nItemNum, nPosition)
   {
      var _loc1_ = this.Inventory.findFirstItem("ID",nItemNum);
      var _loc2_ = _loc1_.item;
      _loc2_.Position = nPosition;
      this.Inventory.updateItem(_loc1_.index,_loc2_);
   }
   function dropItem(nItemNum)
   {
      var _loc1_ = this.Inventory.findFirstItem("ID",nItemNum);
      this.Inventory.removeItems(_loc1_.index,1);
   }
   function addSpell(spellObject)
   {
      var _loc3_ = spellObject;
      var _loc2_;
      var strDest = new String();
      switch(_loc3_.m_Class)
      {
         case 0:
            strDest = "Guild";
            break;
         case 1:
            strDest = "Water";
            break;
         case 2:
            strDest = "Fire";
            break;
         case 3:
            strDest = "Earth";
            break;
         case 4:
            strDest = "Air";
      }
      _loc2_ = this["Spells" + strDest];
      var bExist = false;
      var i;
      var oldPos;
      var _loc1_;
      _loc1_ = 0;
      while(_loc1_ < _loc2_.length)
      {
         if(_loc2_[_loc1_].m_ID == _loc3_.m_ID)
         {
            oldPos = _loc2_[_loc1_].m_Position;
            _loc3_.m_Position = oldPos;
            _loc2_[_loc1_] = _loc3_;
            i = _loc1_;
            bExist = true;
            break;
         }
         _loc1_ = _loc1_ + 1;
      }
      this.Spells.addItemAt(_loc3_.m_ID,_loc3_);
      if(!bExist)
      {
         i = _loc2_.push(_loc3_);
      }
      if(!isNaN(_loc3_.m_Position))
      {
         this.SpellsUsed.addItemAt(_loc3_.m_Position,_loc3_);
      }
      return {index:i,location:strDest};
   }
   function canBoost(nCharacID)
   {
      var _loc1_ = this;
      if(_loc1_._datacenter.Game.isRunning)
      {
         return false;
      }
      var _loc2_ = _loc1_.getBoostCostForCharacteristic(nCharacID);
      if(_loc1_._bonusPoints >= _loc2_)
      {
         return true;
      }
      return false;
   }
   function getBoostCostForCharacteristic(nCharacID)
   {
      var _loc2_ = _global.getGuildText(this._guild)["b" + nCharacID];
      var nCost = 1;
      var nCharacValue = 0;
      switch(nCharacID)
      {
         case 10:
            var nCharacValue = this._force;
            break;
         case 11:
            var nCharacValue = this._vitality;
            break;
         case 12:
            var nCharacValue = this._wisdom;
            break;
         case 13:
            var nCharacValue = this._chance;
            break;
         case 14:
            var nCharacValue = this._agility;
            break;
         case 15:
            var nCharacValue = this._intelligence;
      }
      var _loc1_ = 0;
      var _loc3_;
      while(_loc1_ < _loc2_.length)
      {
         _loc3_ = _loc2_[_loc1_][0];
         if(nCharacValue < _loc3_)
         {
            break;
         }
         nCost = _loc2_[_loc1_][1];
         _loc1_ = _loc1_ + 1;
      }
      return nCost;
   }
   function isAtHome(nMapID)
   {
      var _loc1_ = _global.getHousesMapText(nMapID);
      if(_loc1_ != undefined)
      {
         return this._datacenter.Houses.getItemAt(_loc1_).localOwner;
      }
      return false;
   }
}
