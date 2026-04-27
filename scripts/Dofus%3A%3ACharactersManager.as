Class_CharactersManager = function()
{
};
Object.registerClass("Dofus::CharactersManager",Class_CharactersManager);
Class_CharactersManager.prototype.clearAllOthersCharacters = function()
{
   var _loc1_ = DATACENTER.Player.ID;
   var _loc2_ = DATACENTER.Player.data;
   DATACENTER.Sprites.removeAll();
   DATACENTER.Sprites.addItemAt(_loc1_,_loc2_);
};
Class_CharactersManager.prototype.setLocalPlayerData = function(i, name, ca)
{
   var _loc1_ = i;
   var lp = DATACENTER.Player;
   lp.ID = _loc1_;
   lp.Name = name;
   lp.Guild = ca.guild;
   lp.Level = ca.level;
   lp.Sex = ca.sex;
   lp.Color1 = ca.color1 != -1 ? Number("0x" + ca.color1) : ca.color1;
   lp.Color2 = ca.color2 != -1 ? Number("0x" + ca.color2) : ca.color2;
   lp.Color3 = ca.color3 != -1 ? Number("0x" + ca.color3) : ca.color3;
   if(ca.cc)
   {
      lp.setCCData(ca.cc);
   }
   var spellsArray = ca.spells.split(";");
   _loc1_ = 0;
   var _loc2_;
   while(_loc1_ < spellsArray.length)
   {
      _loc2_ = spellsArray[_loc1_];
      if(_loc2_.length != 0)
      {
         var s = this.getSpellObjectFromData(_loc2_);
         lp.addSpell(s);
      }
      _loc1_ = _loc1_ + 1;
   }
   var itemsArray = ca.items.split(";");
   _loc1_ = 0;
   var _loc3_;
   while(_loc1_ < itemsArray.length)
   {
      _loc3_ = this.getItemObjectFromData(itemsArray[_loc1_]);
      if(_loc3_ != undefined)
      {
         lp.addItem(_loc3_);
      }
      _loc1_ = _loc1_ + 1;
   }
};
Class_CharactersManager.prototype.createCharacter = function(i, name, ca)
{
   var _loc1_ = ca;
   var _loc2_ = i;
   var _loc3_ = DATACENTER.Sprites.getItemAt(_loc2_);
   if(_loc3_ == undefined)
   {
      _loc3_ = new dofus.datacenter.Character(_loc2_,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + _loc1_.gfxID + ".swf",_loc1_.cell,_loc1_.dir,_loc1_.gfxID);
      DATACENTER.Sprites.addItemAt(_loc2_,_loc3_);
   }
   _loc3_.GameActionsManager.init();
   _loc3_.CellNum = _loc1_.cell;
   _loc3_.name = name;
   _loc3_.Guild = _loc1_.spriteType;
   _loc3_.Level = _loc1_.level;
   _loc3_.Sex = _loc1_.sex == undefined ? 1 : _loc1_.sex;
   _loc3_.Color1 = _loc1_.color1 != -1 ? Number("0x" + _loc1_.color1) : _loc1_.color1;
   _loc3_.Color2 = _loc1_.color2 != -1 ? Number("0x" + _loc1_.color2) : _loc1_.color2;
   _loc3_.Color3 = _loc1_.color3 != -1 ? Number("0x" + _loc1_.color3) : _loc1_.color3;
   _loc3_.Alignment = _loc1_.alignment == undefined ? 0 : _loc1_.alignment;
   _loc3_.Merchant = _loc1_.merchant != "1" ? false : true;
   _loc3_.Died = _loc1_.died != "1" ? false : true;
   if(_loc1_.accessories.length != 0)
   {
      var aAccessories = new Array();
      var aTmp = _loc1_.accessories.split(",");
      _loc2_ = 0;
      while(_loc2_ < aTmp.length)
      {
         var unicID = parseInt(aTmp[_loc2_],16);
         var oAcc = new dofus.datacenter.Accessory(unicID);
         aAccessories[_loc2_] = oAcc;
         _loc2_ = _loc2_ + 1;
      }
      _loc3_.Accessories = aAccessories;
   }
   if(_loc1_.LP != undefined)
   {
      _loc3_.LP = _loc1_.LP;
   }
   if(_loc1_.LP != undefined)
   {
      _loc3_.LPmax = _loc1_.LP;
   }
   if(_loc1_.AP != undefined)
   {
      _loc3_.AP = _loc1_.AP;
   }
   if(_loc1_.AP != undefined)
   {
      _loc3_.APinit = _loc1_.AP;
   }
   if(_loc1_.MP != undefined)
   {
      _loc3_.MP = _loc1_.MP;
   }
   if(_loc1_.MP != undefined)
   {
      _loc3_.MPinit = _loc1_.MP;
   }
   _loc3_.Team = _loc1_.team != undefined ? _loc1_.team : null;
   return _loc3_;
};
Class_CharactersManager.prototype.createCreature = function(i, name, ca)
{
   var _loc1_ = ca;
   var _loc3_ = i;
   var _loc2_ = DATACENTER.Sprites.getItemAt(_loc3_);
   if(_loc2_ == undefined)
   {
      _loc2_ = new dofus.datacenter.Creature(_loc3_,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + _loc1_.gfxID + ".swf",_loc1_.cell,_loc1_.dir,_loc1_.gfxID);
      DATACENTER.Sprites.addItemAt(_loc3_,_loc2_);
   }
   _loc2_.GameActionsManager.init();
   _loc2_.CellNum = _loc1_.cell;
   _loc2_.name = name;
   _loc2_.Level = _loc1_.level;
   if(_loc1_.LP != undefined)
   {
      _loc2_.LP = _loc1_.LP;
   }
   if(_loc1_.LP != undefined)
   {
      _loc2_.LPmax = _loc1_.LP;
   }
   if(_loc1_.AP != undefined)
   {
      _loc2_.AP = _loc1_.AP;
   }
   if(_loc1_.AP != undefined)
   {
      _loc2_.APinit = _loc1_.AP;
   }
   if(_loc1_.MP != undefined)
   {
      _loc2_.MP = _loc1_.MP;
   }
   if(_loc1_.MP != undefined)
   {
      _loc2_.MPinit = _loc1_.MP;
   }
   _loc2_.Team = _loc1_.team != undefined ? _loc1_.team : null;
   return _loc2_;
};
Class_CharactersManager.prototype.createMonster = function(i, name, ca)
{
   var _loc1_ = ca;
   var _loc3_ = i;
   var _loc2_ = DATACENTER.Sprites.getItemAt(_loc3_);
   if(_loc2_ == undefined)
   {
      _loc2_ = new dofus.datacenter.Monster(_loc3_,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + _loc1_.gfxID + ".swf",_loc1_.cell,_loc1_.dir,_loc1_.gfxID);
      DATACENTER.Sprites.addItemAt(_loc3_,_loc2_);
   }
   _loc2_.GameActionsManager.init();
   _loc2_.CellNum = _loc1_.cell;
   _loc2_.name = name;
   _loc2_.Level = _loc1_.level;
   if(_loc1_.LP != undefined)
   {
      _loc2_.LP = _loc1_.LP;
   }
   if(_loc1_.LP != undefined)
   {
      _loc2_.LPmax = _loc1_.LP;
   }
   if(_loc1_.AP != undefined)
   {
      _loc2_.AP = _loc1_.AP;
   }
   if(_loc1_.AP != undefined)
   {
      _loc2_.APinit = _loc1_.AP;
   }
   if(_loc1_.MP != undefined)
   {
      _loc2_.MP = _loc1_.MP;
   }
   if(_loc1_.MP != undefined)
   {
      _loc2_.MPinit = _loc1_.MP;
   }
   _loc2_.Team = _loc1_.team != undefined ? _loc1_.team : null;
   return _loc2_;
};
Class_CharactersManager.prototype.createMonsterGroup = function(i, name, ca)
{
   var _loc2_ = ca;
   var _loc3_ = i;
   var _loc1_ = DATACENTER.Sprites.getItemAt(_loc3_);
   if(_loc1_ == undefined)
   {
      _loc1_ = new dofus.datacenter.MonsterGroup(_loc3_,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + _loc2_.gfxID + ".swf",_loc2_.cell,_loc2_.dir);
      DATACENTER.Sprites.addItemAt(_loc3_,_loc1_);
   }
   _loc1_.CellNum = _loc2_.cell;
   _loc1_.name = name;
   _loc1_.Level = _loc2_.level;
   return _loc1_;
};
Class_CharactersManager.prototype.createNonPlayableCharacter = function(i, unicID, ca)
{
   var _loc2_ = ca;
   var _loc3_ = i;
   var _loc1_ = DATACENTER.Sprites.getItemAt(_loc3_);
   if(_loc1_ == undefined)
   {
      _loc1_ = new dofus.datacenter.NonPlayableCharacter(_loc3_,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + _loc2_.gfxID + ".swf",_loc2_.cell,_loc2_.dir,_loc2_.gfxID);
      DATACENTER.Sprites.addItemAt(_loc3_,_loc1_);
   }
   _loc1_.CellNum = _loc2_.cell;
   _loc1_.unicID = unicID;
   return _loc1_;
};
Class_CharactersManager.prototype.createOfflineCharacter = function(i, name, ca)
{
   var _loc1_ = i;
   var c = DATACENTER.Sprites.getItemAt(_loc1_);
   if(c == undefined)
   {
      c = new dofus.datacenter.OfflineCharacter(_loc1_,ank.battlefield.mc.Sprite,dofus.Constants.CLIPS_PERSOS_PATH + ca.gfxID + ".swf",ca.cell,ca.dir,ca.gfxID);
      DATACENTER.Sprites.addItemAt(_loc1_,c);
   }
   c.CellNum = ca.cell;
   c.name = name;
   c.Color1 = ca.color1 != -1 ? Number("0x" + ca.color1) : ca.color1;
   c.Color2 = ca.color2 != -1 ? Number("0x" + ca.color2) : ca.color2;
   c.Color3 = ca.color3 != -1 ? Number("0x" + ca.color3) : ca.color3;
   var _loc2_;
   var _loc3_;
   if(ca.accessories.length != 0)
   {
      var aAccessories = new Array();
      var aTmp = ca.accessories.split(",");
      _loc1_ = 0;
      while(_loc1_ < aTmp.length)
      {
         _loc2_ = parseInt(aTmp[_loc1_],16);
         _loc3_ = new dofus.datacenter.Accessory(_loc2_);
         aAccessories[_loc1_] = _loc3_;
         _loc1_ = _loc1_ + 1;
      }
      c.Accessories = aAccessories;
   }
   return c;
};
Class_CharactersManager.prototype.createNewCharacter = function()
{
   GAPI.unloadUIComponent("ChooseCharacter");
   GAPI.loadUIComponent("CreateCharacter","CreateCharacter");
   INTERFACE.draw("dofus::graphics::gui::UICreateCharacter",1);
};
Class_CharactersManager.prototype.getSpellObjectFromData = function(data)
{
   var _loc2_ = data.split("~");
   var _loc1_ = new Class_DataCenter_Spell();
   _loc1_.m_ID = _loc2_[0];
   _loc1_.m_Level = Number(_loc2_[1]);
   _loc1_.setEffectZones();
   _loc1_.setAdditionalData(_loc2_[2]);
   return _loc1_;
};
Class_CharactersManager.prototype.getItemObjectFromData = function(data)
{
   var _loc1_;
   var _loc3_;
   var _loc2_;
   if(data.length != 0)
   {
      _loc1_ = data.split("~");
      var ID = parseInt(_loc1_[0],16);
      var unicID = parseInt(_loc1_[1],16);
      var quantity = parseInt(_loc1_[2],16);
      var Position = _loc1_[3].length != 0 ? parseInt(_loc1_[3],16) : -1;
      _loc3_ = _loc1_[4];
      _loc2_ = new dofus.datacenter.Item(ID,unicID,quantity,Position,_loc3_);
      _loc2_.PriceMultiplicator = getConfigText("SELL_PRICE_MULTIPLICATOR");
      return _loc2_;
   }
};
