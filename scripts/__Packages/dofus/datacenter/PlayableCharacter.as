class dofus.datacenter.PlayableCharacter extends ank.battlefield.datacenter.Sprite
{
   var __proto__;
   var _accessories;
   var _ap;
   var _apinit;
   var _gfxID;
   var _kama;
   var _level;
   var _lp;
   var _lpmax;
   var _mp;
   var _mpinit;
   var _name;
   var _team;
   var _xp;
   function PlayableCharacter(id, clipClass, gfxFile, cellNum, dir, gfxID)
   {
      super();
      if(this.__proto__ == dofus.datacenter.PlayableCharacter.prototype)
      {
         this.initialize(id,clipClass,gfxFile,gfxID,cellNum,dir);
      }
   }
   function initialize(id, clipClass, gfxFile, cellNum, dir, gfxID)
   {
      var _loc1_ = this;
      super.initialize(id,clipClass,gfxFile,cellNum,dir);
      _loc1_._gfxID = gfxID;
      _loc1_.GameActionsManager = new dofus.managers.GameActionsManager(_loc1_);
      _loc1_.CharacteristicsManager = new dofus.managers.CharacteristicsManager(_loc1_);
      _loc1_.EffectsManager = new dofus.managers.EffectsManager(_loc1_);
      AsBroadcaster.initialize(_loc1_);
      mx.events.EventDispatcher.initialize(_loc1_);
   }
   function updateLP(dLP)
   {
      var _loc1_ = this;
      var _loc2_ = dLP;
      _loc1_.LP += Number(_loc2_);
      _loc1_.sprite_mc.showPoints(_loc2_,16711680);
      if(_loc2_ < 0)
      {
         _loc1_.sprite_mc.setAnim("Hit");
      }
   }
   function initLP(Void)
   {
      this.LP = this.LPmax;
   }
   function updateAP(dAP, bUsed)
   {
      var _loc1_ = this;
      var _loc2_ = bUsed;
      if(_loc2_ == undefined)
      {
         _loc2_ = false;
      }
      if(!(_global.DATACENTER.Game.currentPlayerID != _loc1_.id && _loc2_))
      {
         _loc1_.AP += Number(dAP);
         _loc1_.sprite_mc.showPoints(dAP,255);
      }
   }
   function initAP(bWithModerator)
   {
      var _loc1_ = this;
      var _loc2_ = bWithModerator;
      if(_loc2_ == undefined)
      {
         _loc2_ = true;
      }
      var _loc3_;
      if(_loc2_)
      {
         _loc3_ = _loc1_.CharacteristicsManager.getModeratorValue("1");
         _loc1_.AP = Number(_loc1_.APinit) + Number(_loc3_);
      }
      else
      {
         _loc1_.AP = Number(_loc1_.APinit);
      }
   }
   function updateMP(dMP, bUsed)
   {
      var _loc1_ = this;
      var _loc2_ = bUsed;
      if(_loc2_ == undefined)
      {
         _loc2_ = false;
      }
      if(!(_global.DATACENTER.Game.currentPlayerID != _loc1_.id && _loc2_))
      {
         _loc1_.MP += Number(dMP);
         _loc1_.sprite_mc.showPoints(dMP,26112);
      }
   }
   function initMP(bWithModerator)
   {
      var _loc1_ = this;
      var _loc2_ = bWithModerator;
      if(_loc2_ == undefined)
      {
         _loc2_ = true;
      }
      var _loc3_;
      if(_loc2_)
      {
         _loc3_ = _loc1_.CharacteristicsManager.getModeratorValue("23");
         _loc1_.MP = Number(_loc1_.MPinit) + Number(_loc3_);
      }
      else
      {
         _loc1_.MP = Number(_loc1_.MPinit);
      }
   }
   function get gfxID()
   {
      return this._gfxID;
   }
   function set gfxID(value)
   {
      this._gfxID = value;
   }
   function get name()
   {
      return this._name;
   }
   function set name(value)
   {
      this._name = value;
   }
   function get Level()
   {
      return this._level;
   }
   function set Level(value)
   {
      var _loc1_ = this;
      _loc1_._level = Number(value);
      _loc1_.broadcastMessage("onSetLevel",value);
   }
   function get XP()
   {
      return this._xp;
   }
   function set XP(value)
   {
      var _loc1_ = this;
      _loc1_._xp = Number(value);
      _loc1_.broadcastMessage("onSetXP",value);
   }
   function get LP()
   {
      return this._lp;
   }
   function set LP(value)
   {
      var _loc1_ = this;
      var _loc2_ = value;
      _loc1_._lp = Number(_loc2_) <= 0 ? 0 : Number(_loc2_);
      _loc1_.dispatchEvent({type:"lpChanged",value:_loc2_});
      _loc1_.broadcastMessage("onSetLP",_loc2_,_loc1_.LPmax);
   }
   function get LPmax()
   {
      return this._lpmax;
   }
   function set LPmax(value)
   {
      var _loc1_ = this;
      _loc1_._lpmax = Number(value);
      _loc1_.broadcastMessage("onSetLP",_loc1_.LP,value);
   }
   function get AP()
   {
      return this._ap;
   }
   function set AP(value)
   {
      var _loc1_ = this;
      var _loc2_ = value;
      _loc1_._ap = Number(_loc2_);
      _loc1_.dispatchEvent({type:"apChanged",value:_loc2_});
      _loc1_.broadcastMessage("onSetAP",_loc2_);
   }
   function get APinit()
   {
      return this._apinit;
   }
   function set APinit(value)
   {
      this._apinit = Number(value);
   }
   function get MP()
   {
      return this._mp;
   }
   function set MP(value)
   {
      var _loc1_ = this;
      var _loc2_ = value;
      _loc1_._mp = Number(_loc2_);
      _loc1_.dispatchEvent({type:"mpChanged",value:_loc2_});
      _loc1_.broadcastMessage("onSetMP",_loc2_);
   }
   function get MPinit()
   {
      return this._mpinit;
   }
   function set MPinit(value)
   {
      this._mpinit = Number(value);
   }
   function get Kama()
   {
      return this._kama;
   }
   function set Kama(value)
   {
      var _loc1_ = this;
      _loc1_._kama = Number(value);
      _loc1_.broadcastMessage("onSetKama",value);
   }
   function get Team()
   {
      return this._team;
   }
   function set Team(value)
   {
      this._team = Number(value);
   }
   function get Weapon()
   {
      return this._accessories[0];
   }
   function get ToolAnimation()
   {
      var _loc2_ = this.Weapon.unicID;
      var _loc1_ = _global.getItemUnicText(_loc2_);
      if(_loc1_.an == undefined)
      {
         if(_global.DATACENTER.Game.isFight)
         {
            return "anim0";
         }
         return "anim3";
      }
      return "anim" + _loc1_.an;
   }
}
