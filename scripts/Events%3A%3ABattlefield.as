BATTLEFIELD.onCellRelease = function(cellData)
{
   var _loc1_ = this;
   var _loc2_ = cellData;
   var _loc3_;
   switch(DATACENTER.Game.interactionType)
   {
      case 1:
         var characData = DATACENTER.Player.data;
         _loc3_ = false;
         if(DATACENTER.Player.InteractionsManager.calculatePath(BATTLEFIELD.mapHandler,_loc2_.num,true,DATACENTER.Game.sFight,false))
         {
            _loc3_ = true;
         }
         else if(!DATACENTER.Game.isFight)
         {
            if(DATACENTER.Player.InteractionsManager.calculatePath(BATTLEFIELD.mapHandler,_loc2_.num,true,DATACENTER.Game.sFight,true))
            {
               _loc3_ = true;
            }
         }
         if(!_loc3_)
         {
            return false;
         }
         if(getTimer() - _loc1_.lastActionTime >= dofus.Constants.CLICK_MIN_DELAY)
         {
            _loc1_.lastActionTime = getTimer();
            var cp = ank.battlefield.utils.Compressor.compressPath(DATACENTER.Player.tmpFullPath);
            if(cp != undefined)
            {
               characData.GameActionsManager.transmittingMove(1,[cp]);
               DATACENTER.Player.clearTmpPaths();
            }
            return true;
         }
         ank.utils.Logger.err("T trop rapide du clic");
         break;
      case 2:
         if(DATACENTER.Player.currentSpell != null && _loc1_.canLaunchSpell == true)
         {
            BATTLEFIELD.Spells.clear();
            var characData = DATACENTER.Player.data;
            characData.GameActionsManager.transmittingOther(300,[DATACENTER.Player.currentSpell.m_ID,_loc2_.num]);
            DATACENTER.Player.currentSpell = null;
         }
         else if(_loc1_.errorMessage != undefined)
         {
            KERNEL.traceToChat(_loc1_.errorMessage,dofus.Constants.ERROR_CHAT_COLOR);
            delete BATTLEFIELD.Interaction.errorMessage;
         }
         DATACENTER.Game.setInteractionType("move");
         break;
      case 3:
         if(DATACENTER.Player.currentSpell != null && _loc1_.canLaunchSpell == true)
         {
            var characData = DATACENTER.Player.data;
            characData.GameActionsManager.transmittingOther(303,[_loc2_.num]);
            DATACENTER.Player.currentSpell = null;
         }
         DATACENTER.Game.setInteractionType("move");
         break;
      case 4:
         var characOnID = BATTLEFIELD.mapHandler.getCellData(_loc2_.num).SpriteOnID;
         if(characOnID == undefined)
         {
            AKS.Game.setPlayerPosition(_loc2_.num);
         }
      default:
         return;
   }
};
BATTLEFIELD.onCellRollOver = function(cellData)
{
   var _loc1_ = this;
   var _loc2_ = cellData;
   var _loc3_;
   switch(DATACENTER.Game.interactionType)
   {
      case 1:
         if(DATACENTER.Game.isFight)
         {
            var localPlayer = DATACENTER.Player;
            var characData = localPlayer.data;
            var characClip = characData.sprite_mc;
            var rangeModerator = characData.CharacteristicsManager.getModeratorValue(19) + localPlayer.RangeModerator;
            if(ank.battlefield.utils.Pathfinding.checkRange(BATTLEFIELD.mapHandler,characData.cellNum,_loc2_.num,false,characData.MP,0))
            {
               DATACENTER.Player.InteractionsManager.setState(DATACENTER.Game.isFight);
               DATACENTER.Player.InteractionsManager.calculatePath(BATTLEFIELD.mapHandler,_loc2_.num,false,DATACENTER.Game.isFight);
            }
            else
            {
               DATACENTER.Player.tmpFullPath = null;
            }
         }
         break;
      case 2:
         delete _loc1_.onMouseUp;
         Mouse.removeListener(_loc1_);
         var localPlayer = DATACENTER.Player;
         var characData = localPlayer.data;
         var cell1 = DATACENTER.Player.data.cellNum;
         var spellData = DATACENTER.Player.currentSpell;
         var spellsManager = DATACENTER.Player.SpellsManager;
         var rangeModerator = spellData.m_Type != "F" ? 0 : characData.CharacteristicsManager.getModeratorValue(19) + localPlayer.RangeModerator;
         _loc1_.canLaunchSpell = spellsManager.checkCanLaunchSpellOnCell(BATTLEFIELD.mapHandler,spellData,BATTLEFIELD.mapHandler.getCellData(_loc2_.num),rangeModerator);
         if(_loc1_.canLaunchSpell)
         {
            GAPI.setCursorForbidden(false);
            BATTLEFIELD.drawPointer(_loc2_.num);
         }
         else
         {
            GAPI.setCursorForbidden(true);
         }
         break;
      case 3:
         BATTLEFIELD.autoCalculateSpriteDirection(DATACENTER.Player.ID,_loc2_.num);
         delete _loc1_.onMouseUp;
         Mouse.removeListener(_loc1_);
         var cell1 = DATACENTER.Player.data.cellNum;
         _loc3_ = _loc2_.num;
         var cell2Data = BATTLEFIELD.mapHandler.getCellData(_loc2_.num);
         _loc1_.canLaunchSpell = false;
         if(DATACENTER.Player.data.cellNum == _loc3_ && !DATACENTER.Player.currentSpell.m_bOnItSelf)
         {
            _loc1_.canLaunchSpell = false;
         }
         else if(ank.battlefield.utils.Pathfinding.checkRange(BATTLEFIELD.mapHandler,cell1,_loc3_,false,DATACENTER.Player.currentSpell.m_Range))
         {
            if(cell2Data.movement > 1 && cell2Data.SpriteOnID != undefined)
            {
               if(ank.battlefield.utils.Pathfinding.checkView(BATTLEFIELD.mapHandler,cell1,_loc3_))
               {
                  _loc1_.canLaunchSpell = true;
               }
            }
         }
         if(_loc1_.canLaunchSpell)
         {
            GAPI.setCursorForbidden(false);
            BATTLEFIELD.drawPointer(_loc2_.num);
         }
         else
         {
            GAPI.setCursorForbidden(true);
         }
      default:
         return;
   }
};
BATTLEFIELD.onCellRollOut = function(cellData)
{
   var _loc1_ = this;
   switch(DATACENTER.Game.interactionType)
   {
      case 1:
         if(DATACENTER.Game.isFight)
         {
            BATTLEFIELD.unSelect(true);
         }
         break;
      case 2:
      case 3:
         _loc1_.onMouseUp = function()
         {
            DATACENTER.Game.setInteractionType("move");
            Mouse.removeListener(this);
            delete this.onMouseUp;
         };
         Mouse.addListener(_loc1_);
         GAPI.setCursorForbidden(true);
         BATTLEFIELD.hidePointer();
         _loc1_.canLaunchSpell = false;
      default:
         return;
   }
};
BATTLEFIELD.onMapLoaded = function()
{
   INTERFACE.Text.clearText();
   BATTLEFIELD.setInteraction(ank.battlefield.Constants.INTERACTION_NONE);
   BATTLEFIELD.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
   BATTLEFIELD.setInteraction(ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE_OVER_OUT);
   BATTLEFIELD.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT);
   DATACENTER.Game.setInteractionType("move");
   DATACENTER.Game.bInCreaturesMode = false;
   AKS.Game.getExtraInformations();
   GAPI.unloadLastUIAutoHideComponent();
   var _loc3_;
   var _loc1_;
   var _loc2_;
   if(DATACENTER.Player.isAtHome(DATACENTER.Map.id))
   {
      var aSkills = new Array();
      _loc3_ = getHousesIndoorSkillsText();
      _loc1_ = 0;
      while(_loc1_ < _loc3_.length)
      {
         _loc2_ = new dofus.datacenter.Skill(_loc3_[_loc1_]);
         aSkills.push(_loc2_);
         _loc1_ = _loc1_ + 1;
      }
      var nHomeID = getHousesMapText(DATACENTER.Map.id);
      if(nHomeID != undefined)
      {
         var oHouse = DATACENTER.Houses.getItemAt(nHomeID);
         GAPI.loadUIComponent("HouseIndoor","HouseIndoor",{skills:aSkills,house:oHouse},{bStayIfPresent:true});
      }
   }
   else
   {
      GAPI.unloadUIComponent("HouseIndoor");
   }
};
BATTLEFIELD.onSpriteRelease = function(sprite_mc)
{
   var _loc2_ = sprite_mc._data;
   var sid = _loc2_.id;
   var _loc3_;
   var _loc1_;
   if(_loc2_ instanceof dofus.datacenter.Character)
   {
      if(DATACENTER.Game.isMultiPlayer)
      {
         if(DATACENTER.Game.isRunning)
         {
            var cell_mc = BATTLEFIELD.mapHandler.getCellData(_loc2_.cellNum).mc;
            if(DATACENTER.Player.isCurrentPlayer)
            {
               BATTLEFIELD.onCellRelease(cell_mc);
            }
         }
         else if(sid != DATACENTER.Player.ID)
         {
            var pm = GAPI.createPopupMenu();
            pm.addItem(getText("KICK"),AKS.Game,AKS.Game.leave,[sid]);
            pm.show(_level0._xmouse,_level0._ymouse);
         }
      }
      else if(sid == DATACENTER.Player.ID)
      {
         var pm = GAPI.createPopupMenu();
         pm.addItem("Baffer",AKS.Chat,AKS.Chat.send,["Aie !","*"]);
         pm.addItem(getText("ORGANIZE_SHOP"),AKS.Exchange,AKS.Exchange.request,[6]);
         pm.addItem(getText("MERCHANT_MODE"),KERNEL,KERNEL.offlineExchange);
         pm.show(_level0._xmouse,_level0._ymouse);
      }
      else
      {
         var pm = GAPI.createPopupMenu();
         pm.addItem(getText("ADD_TO_FRIENDS"),AKS.Account,AKS.Account.addFriend,[_loc2_.name]);
         pm.addItem(getText("WISPER_MESSAGE"),KERNEL,KERNEL.askPrivateMessage,[_loc2_.name]);
         pm.addItem(getText("EXCHANGE"),AKS.Exchange,AKS.Exchange.request,[1,sid]);
         pm.addItem(getText("CHALLENGE"),AKS.Game,AKS.Game.challenge,[[sid]],DATACENTER.Map.bCanChallenge);
         if(_loc2_.Alignment < 0 && DATACENTER.Player.data.Alignment >= 0)
         {
            pm.addItem(getText("PUNISH"),AKS.Game,AKS.Game.attack,[[sid]],DATACENTER.Map.bCanAttack);
         }
         else
         {
            pm.addItem(getText("ATTACK"),AKS.Game,AKS.Game.attack,[[sid]],DATACENTER.Map.bCanAttack);
         }
         if(DATACENTER.Player.isAtHome(DATACENTER.Map.id))
         {
            pm.addItem(getText("KICKOFF"),AKS.Houses,AKS.Houses.kick,[[sid]]);
         }
         pm.show(_level0._xmouse,_level0._ymouse);
      }
   }
   else if(_loc2_ instanceof dofus.datacenter.Team)
   {
      var nPlayerAlignment = DATACENTER.Player.data.Alignment;
      var nPlayerSimpleAlignment = nPlayerAlignment <= 0 ? (nPlayerAlignment != 0 ? 2 : 0) : 1;
      var bCanJoin = _loc2_.alignment == nPlayerSimpleAlignment || nPlayerSimpleAlignment == 0 || _loc2_.alignment == 0;
      if(_loc2_.id > 0 && bCanJoin)
      {
         var pm = GAPI.createPopupMenu();
         if(_loc2_._challenge.count >= dofus.Constants.MAX_PLAYERS_IN_CHALLENGE)
         {
            pm.addItem(getText("CHALENGE_FULL"));
         }
         else if(_loc2_.count >= dofus.Constants.MAX_PLAYERS_IN_TEAM)
         {
            pm.addItem(getText("TEAM_FULL"));
         }
         else
         {
            pm.addItem(getText("JOIN_SMALL"),AKS.Game,AKS.Game.joinChallenge,[_loc2_._challenge.id,_loc2_.id]);
         }
         pm.show(_level0._xmouse,_level0._ymouse);
      }
   }
   else if(_loc2_ instanceof dofus.datacenter.OfflineCharacter)
   {
      var pm = GAPI.createPopupMenu();
      pm.addStaticItem(getText("SHOP") + " " + getText("OF") + " " + _loc2_.name);
      pm.addItem(getText("BUY"),AKS.Exchange,AKS.Exchange.request,[4,_loc2_.id,_loc2_.CellNum]);
      pm.show(_level0._xmouse,_level0._ymouse);
   }
   else if(_loc2_ instanceof dofus.datacenter.MonsterGroup || _loc2_ instanceof dofus.datacenter.Creature || _loc2_ instanceof dofus.datacenter.Monster)
   {
      var cell_mc = BATTLEFIELD.mapHandler.getCellData(_loc2_.cellNum).mc;
      BATTLEFIELD.onCellRelease(cell_mc);
   }
   else if(_loc2_ instanceof dofus.datacenter.NonPlayableCharacter)
   {
      var aActions = _loc2_.actions;
      if(aActions != undefined)
      {
         var pm = GAPI.createPopupMenu();
         _loc3_ = aActions.length;
         while(_loc3_-- > 0)
         {
            _loc1_ = aActions[_loc3_].action;
            pm.addItem(aActions[_loc3_].name,_loc1_.object,_loc1_.method,_loc1_.params);
         }
         pm.show(_level0._xmouse,_level0._ymouse);
      }
   }
};
BATTLEFIELD.onSpriteRollOver = function(sprite_mc)
{
   var _loc1_ = sprite_mc._data;
   var _loc2_;
   var _loc3_;
   if(_loc1_.bVisible)
   {
      if(DATACENTER.Game.isRunning)
      {
         var cell_mc = BATTLEFIELD.mapHandler.getCellData(_loc1_.cellNum).mc;
         if(DATACENTER.Player.isCurrentPlayer)
         {
            BATTLEFIELD.onCellRollOver(cell_mc);
         }
      }
      _loc2_ = _loc1_.name;
      if(_loc1_ instanceof dofus.datacenter.Character)
      {
         if(DATACENTER.Game.isRunning)
         {
            _loc2_ += " (" + _loc1_.LP + ")";
            _loc3_ = _loc1_.EffectsManager.getEffects();
            if(_loc3_.length != 0)
            {
               BATTLEFIELD.addSpriteOverHeadItem(_loc1_.id,"effects",dofus.graphics.battlefield.EffectsOverHead,[_loc3_]);
            }
         }
         else if(DATACENTER.Game.isMultiplayer)
         {
            _loc2_ += " (" + _loc1_.level + ")";
         }
         if(_loc1_.Alignment != 0)
         {
            var sFile = dofus.Constants.DEMON_ANGEL_FILE;
            if(_loc1_.Alignment > 0)
            {
               var nFrame = _loc1_.AlignmentFrame;
            }
            else
            {
               var nFrame = 5 + _loc1_.AlignmentFrame;
            }
         }
      }
      else if(_loc1_ instanceof dofus.datacenter.Creature || _loc1_ instanceof dofus.datacenter.Monster)
      {
         if(DATACENTER.Game.isRunning)
         {
            _loc2_ += " (" + _loc1_.LP + ")";
         }
      }
      BATTLEFIELD.addSpriteOverHeadItem(_loc1_.id,"text",dofus.graphics.battlefield.TextOverHead,[_loc2_,sFile,nFrame]);
      sprite_mc.select(true);
   }
};
BATTLEFIELD.onSpriteRollOut = function(sprite_mc)
{
   var _loc1_ = sprite_mc._data;
   var _loc2_;
   if(DATACENTER.Game.isRunning)
   {
      _loc2_ = BATTLEFIELD.mapHandler.getCellData(_loc1_.cellNum).mc;
      if(DATACENTER.Player.isCurrentPlayer)
      {
         BATTLEFIELD.onCellRollOut(_loc2_);
      }
   }
   BATTLEFIELD.removeSpriteOverHeadLayer(_loc1_.id,"demonangel");
   BATTLEFIELD.removeSpriteOverHeadLayer(_loc1_.id,"text");
   BATTLEFIELD.removeSpriteOverHeadLayer(_loc1_.id,"effects");
   sprite_mc.select(false);
};
BATTLEFIELD.onObjectRelease = function(object_mc)
{
   var cellData = object_mc.cellData;
   var _loc1_ = cellData.mc;
   var nObject2Num = cellData.layerObject2Num;
   var _loc2_;
   var _loc3_;
   if(nObject2Num >= 6700 && !isNaN(nObject2Num))
   {
      var oObject2Infos = getInteractiveObjectDataByGfxText(nObject2Num);
      var sObject2Name = oObject2Infos.n;
      _loc2_ = oObject2Infos.sk;
      var nObject2Type = oObject2Infos.t;
      switch(nObject2Type)
      {
         case 1:
         case 2:
         case 3:
         case 4:
            var bHaveJob = DATACENTER.Player.currentJobID != undefined;
            if(bHaveJob)
            {
               var aJobSkills = DATACENTER.Player.Jobs.findFirstItem("id",DATACENTER.Player.currentJobID).item.skills;
            }
            else
            {
               var aJobSkills = new ank.utils.ExtendedArray();
            }
            var pm = GAPI.createPopupMenu();
            pm.addStaticItem(sObject2Name);
            for(var k in _loc2_)
            {
               var nSkillID = _loc2_[k];
               var oSkill = new dofus.datacenter.Skill(nSkillID);
               var bHaveSkill = aJobSkills.findFirstItem("id",nSkillID).index != -1;
               _loc3_ = oSkill.getState(bHaveSkill);
               if(_loc3_ != "X")
               {
                  pm.addItem(oSkill.description,KERNEL,KERNEL.useRessource,[_loc1_,_loc1_.num,nSkillID],_loc3_ == "V");
               }
            }
            pm.show(_level0._xmouse,_level0._ymouse);
            break;
         case 5:
            var pm = GAPI.createPopupMenu();
            var nHouseId = getHousesDoorText(DATACENTER.Map.id,_loc1_.num);
            var oHouse = DATACENTER.Houses.getItemAt(nHouseId);
            pm.addStaticItem(sObject2Name + " " + oHouse.name);
            if(oHouse.localOwner)
            {
               pm.addStaticItem("chez moi !!!");
            }
            else if(oHouse.ownerName != undefined)
            {
               pm.addStaticItem("chez " + oHouse.ownerName);
            }
            for(var k in _loc2_)
            {
               var nSkillID = _loc2_[k];
               var oSkill = new dofus.datacenter.Skill(nSkillID);
               _loc3_ = oSkill.getState(true,oHouse.localOwner,oHouse.isForSale,oHouse.isLocked);
               if(_loc3_ != "X")
               {
                  pm.addItem(oSkill.description,KERNEL,KERNEL.useRessource,[_loc1_,_loc1_.num,nSkillID],_loc3_ == "V");
               }
            }
            pm.show(_level0._xmouse,_level0._ymouse);
            break;
         case 6:
            var sStorageID = DATACENTER.Map.id + "_" + _loc1_.num;
            var oOwnerStorage = DATACENTER.Storages.getItemAt(sStorageID);
            var bLocked = oOwnerStorage.isLocked;
            var bIsAtHome = DATACENTER.Player.isAtHome(DATACENTER.Map.id);
            var pm = GAPI.createPopupMenu();
            pm.addStaticItem(sObject2Name);
            for(var k in _loc2_)
            {
               var nSkillID = _loc2_[k];
               var oSkill = new dofus.datacenter.Skill(nSkillID);
               _loc3_ = oSkill.getState(true,bIsAtHome,true,bLocked);
               if(_loc3_ != "X")
               {
                  pm.addItem(oSkill.description,KERNEL,KERNEL.useRessource,[_loc1_,_loc1_.num,nSkillID],_loc3_ == "V");
               }
            }
            pm.show(_level0._xmouse,_level0._ymouse);
      }
   }
   else
   {
      BATTLEFIELD.onCellRelease(_loc1_);
   }
};
BATTLEFIELD.onObjectRollOver = function(object_mc)
{
   object_mc.select(true);
};
BATTLEFIELD.onObjectRollOut = function(object_mc)
{
   object_mc.select(false);
};
