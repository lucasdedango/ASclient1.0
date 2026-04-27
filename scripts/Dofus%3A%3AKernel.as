Class_Kernel = function()
{
   this.init();
};
Class_Kernel.prototype.init = function()
{
   var _loc1_ = this;
   _global.GAC = new ank.battlefield.GlobalSpriteHandler();
   _loc1_.PathFinding = new Class_PathFinding();
   _loc1_.KeyListener = new Class_KeyListener();
   _loc1_.CharactersManager = new Class_CharactersManager();
   _global.GAPI = MODULE_GAPI.GAPI;
   GAPI.api = {datacenter:DATACENTER,network:AKS,gui:INTERFACE,colors:GAC,lang:ank.utils.Translator,kernel:_loc1_,sounds:SOMA};
   GAPI.setScreenSize(742,550);
   GAPI.addEventListener("removeCursor",_loc1_);
   _loc1_.tryAutoLogin();
};
Class_Kernel.prototype.tryAutoLogin = function()
{
   var _loc1_ = this;
   _loc1_.m_LoadVars = new LoadVars();
   _loc1_.m_LoadVars.onLoad = function(success)
   {
      var _loc1_ = this;
      if(success)
      {
         if(_loc1_.l != undefined)
         {
            DATACENTER.Player.login = _loc1_.l;
            DATACENTER.Player.password = _loc1_.p;
            AKS.connect(dofus.Constants.SERVER_NAME,dofus.Constants.SERVER_PORT);
         }
         else
         {
            GAPI.loadUIComponent("Login","Login");
         }
      }
      else
      {
         GAPI.loadUIComponent("Login","Login");
      }
   };
   _loc1_.m_LoadVars.sendAndLoad(dofus.Constants.HTTP_GETUSER_FILE,_loc1_.m_LoadVars,"POST");
};
Class_Kernel.prototype.traceToChat = function(txt, color, bSameLine)
{
   if(AKS.Chat.output == undefined)
   {
      log(txt,true);
   }
   else
   {
      CHAT.addText(txt,color);
   }
};
Class_Kernel.prototype.drawPlayerInterface = function()
{
   GAPI.loadUIComponent("Banner","Banner",{data:DATACENTER.Player},{bStayIfPresent:true,bAlwaysOnTop:true});
   GAPI.setScreenSize(742,432);
};
Class_Kernel.prototype.switchToSpellLaunch = function(spellData)
{
   var _loc2_;
   var _loc3_;
   var _loc1_;
   if(DATACENTER.Game.isRunning)
   {
      if(DATACENTER.Game.isFight)
      {
         if(!DATACENTER.Player.data.sequencer.isPlaying())
         {
            if(!DATACENTER.Player.data.GameActionsManager.isWaiting())
            {
               if(!DATACENTER.Player.hasEnoughAP(spellData.m_APCost))
               {
                  KERNEL.traceToChat(getText("NOT_ENOUGH_AP"),dofus.Constants.ERROR_CHAT_COLOR);
               }
               else if(!DATACENTER.Player.SpellsManager.checkCanLaunchSpell(spellData.m_ID,undefined))
               {
                  if(DATACENTER.Player.errorMessage != undefined)
                  {
                     KERNEL.traceToChat(DATACENTER.Player.errorMessage,dofus.Constants.ERROR_CHAT_COLOR);
                     delete DATACENTER.Player.errorMessage;
                  }
               }
               else
               {
                  BATTLEFIELD.unSelect(true);
                  DATACENTER.Player.currentSpell = spellData;
                  BATTLEFIELD.clearZoneLayer("spell");
                  BATTLEFIELD.clearPointer();
                  _loc2_ = spellData.m_EffectZones;
                  if(spellData.m_Range != 63)
                  {
                     var rangeModerator = spellData.m_Type != "F" ? 0 : DATACENTER.Player.data.CharacteristicsManager.getModeratorValue("19") + DATACENTER.Player.RangeModerator;
                     var range = spellData.m_Range + rangeModerator;
                     if(range < 1)
                     {
                        if(spellData.m_Range != 0)
                        {
                           range = 1;
                        }
                        else
                        {
                           range = 0;
                        }
                     }
                     if(rangeModerator > 0 && spellData.m_Range == 0)
                     {
                        range = 0;
                     }
                     _loc3_ = DATACENTER.Player.data.cellNum;
                     _loc1_ = 0;
                     while(_loc1_ < _loc2_.length)
                     {
                        BATTLEFIELD.addPointerShape(_loc2_[_loc1_].shape,_loc2_[_loc1_].size,dofus.Constants.CELL_SPELL_EFFECT_COLOR,_loc3_);
                        _loc1_ = _loc1_ + 1;
                     }
                     if(spellData.m_bLineOnly)
                     {
                        BATTLEFIELD.drawZone(_loc3_,range,"spell",dofus.Constants.CELL_SPELL_RANGE_COLOR,"X");
                     }
                     else
                     {
                        BATTLEFIELD.drawZone(_loc3_,range,"spell",dofus.Constants.CELL_SPELL_RANGE_COLOR,"C");
                     }
                  }
                  else
                  {
                     BATTLEFIELD.drawZone(_loc3_,100,"spell",dofus.Constants.CELL_SPELL_RANGE_COLOR,"C");
                  }
                  DATACENTER.Game.setInteractionType("spell");
                  GAPI.setCursor(spellData,{width:25,height:25,x:20,y:20});
                  GAPI.setCursorForbidden(true);
                  KERNEL.lastTimerSwitch = getTimer();
                  BATTLEFIELD.onMouseUp = function()
                  {
                     if(getTimer() - KERNEL.lastTimerSwitch > 400)
                     {
                        DATACENTER.Game.setInteractionType("move");
                        Mouse.removeListener(this);
                        delete this.onMouseUp;
                     }
                  };
                  Mouse.addListener(BATTLEFIELD);
                  this.forceOver();
               }
            }
         }
      }
   }
};
Class_Kernel.prototype.switchToCC = function(CCData)
{
   var _loc1_ = CCData;
   var _loc2_ = this;
   if(DATACENTER.Game.isRunning)
   {
      if(DATACENTER.Game.isFight)
      {
         if(!DATACENTER.Player.data.sequencer.isPlaying())
         {
            if(!DATACENTER.Player.data.GameActionsManager.isWaiting())
            {
               if(!DATACENTER.Player.hasEnoughAP(_loc1_.m_APCost))
               {
                  KERNEL.traceToChat(getText("NOT_ENOUGH_AP"),dofus.Constants.ERROR_CHAT_COLOR);
               }
               else
               {
                  BATTLEFIELD.unSelect(true);
                  DATACENTER.Player.currentSpell = _loc1_;
                  BATTLEFIELD.clearZoneLayer("spell");
                  BATTLEFIELD.clearPointer();
                  BATTLEFIELD.addPointerShape("C",0,dofus.Constants.CELL_SPELL_EFFECT_COLOR);
                  BATTLEFIELD.drawZone(DATACENTER.Player.data.cellNum,_loc1_.m_Range,"spell",dofus.Constants.CELL_SPELL_RANGE_COLOR);
                  DATACENTER.Game.setInteractionType("cc");
                  GAPI.setCursor(_loc1_,{width:25,height:25,x:20,y:20});
                  GAPI.setCursorForbidden(true);
                  KERNEL.lastTimerSwitch = getTimer();
                  BATTLEFIELD.onMouseUp = function()
                  {
                     if(getTimer() - KERNEL.lastTimerSwitch > 400)
                     {
                        DATACENTER.Game.setInteractionType("move");
                        delete this.onMouseUp;
                        Mouse.removeListener(this);
                     }
                  };
                  Mouse.addListener(BATTLEFIELD);
                  _loc2_.forceOver();
               }
            }
         }
      }
   }
};
Class_Kernel.prototype.cleanUpGameArea = function(bkeepSelection)
{
   GAPI.removeCursor();
   if(bkeepSelection)
   {
      BATTLEFIELD.unSelect(true);
   }
   BATTLEFIELD.clearPointer();
   BATTLEFIELD.clearZoneLayer("spell");
   DATACENTER.Player.currentSpell = null;
   if(!(DATACENTER.Game.isMultiplayer && !DATACENTER.Game.isRunning))
   {
      DATACENTER.Game.setInteractionType("move");
   }
   DATACENTER.Player.InteractionsManager.setState(DATACENTER.Game.isFight);
};
Class_Kernel.prototype.cleanPlayer = function(characID)
{
   var _loc1_;
   if(characID != DATACENTER.Game.currentPlayerID)
   {
      _loc1_ = DATACENTER.Sprites.getItemAt(characID);
      _loc1_.CharacteristicsManager.nextTurn();
      _loc1_.GameActionsManager.clear();
   }
};
Class_Kernel.prototype.setEnabledInteractionIfICan = function(state)
{
   if(DATACENTER.Player.isCurrentPlayer)
   {
      BATTLEFIELD.setInteraction(state);
   }
};
Class_Kernel.prototype.forceOver = function()
{
   ROOT.attachMovie("clipOver","clipOver",10,{_x:ROOT._xmouse,_y:ROOT._ymouse});
};
Class_Kernel.prototype.animAllCharacters = function(anim)
{
   var _loc3_ = anim;
   var _loc2_;
   var _loc1_;
   for(var k in DATACENTER.Characters.keys)
   {
      _loc1_ = DATACENTER.Characters.getItemAt(k);
      _loc2_ = _loc1_.clip;
      if(!_loc1_.iDied)
      {
         _loc2_.setAnim(_loc3_);
      }
   }
};
Class_Kernel.prototype.addToCharacteristicsManager = function(characData, type, value, turnCount, bOnItSelf)
{
   var _loc2_ = characData.CharacteristicsManager;
   var _loc1_ = new Class_DataCenter_Effect();
   _loc1_.type = type;
   _loc1_.value = value;
   _loc1_.remainingTurn = !bOnItSelf ? Number(turnCount) - 1 : turnCount;
   _loc2_.addEffect(_loc1_);
};
Class_Kernel.prototype.quit = function()
{
   var _loc1_ = this;
   _loc1_.oAskListener = new Object();
   _loc1_.oAskListener.yes = function()
   {
      AKS.disconnect(true);
      AKS.m_bSkipMenu = true;
      AKS.connect(dofus.Constants.SERVER_NAME,dofus.Constants.SERVER_PORT);
      delete this;
   };
   var _loc2_ = GAPI.loadUIComponent("AskYesNo","AskYesNoQuit",{title:getText("CAUTION"),text:getText("DO_U_QUIT")});
   _loc2_.addEventListener("yes",_loc1_.oAskListener);
};
Class_Kernel.prototype.disconnect = function()
{
   var _loc1_ = this;
   _loc1_.oAskListener = new Object();
   _loc1_.oAskListener.yes = function()
   {
      AKS.disconnect();
      delete this;
   };
   var _loc2_ = GAPI.loadUIComponent("AskYesNo","AskYesNoDisconnect",{title:getText("CAUTION"),text:getText("DO_U_DISCONNECT")});
   _loc2_.addEventListener("yes",_loc1_.oAskListener);
};
Class_Kernel.prototype.showSoundOptions = function()
{
   INTERFACE.optionsBox();
};
Class_Kernel.prototype.showMenu = function()
{
   INTERFACE.menuBox();
};
Class_Kernel.prototype.giveUpGame = function()
{
   this.yes = function()
   {
      AKS.Game.leave();
   };
   var _loc1_ = GAPI.loadUIComponent("AskYesNo","AskYesNoGiveUp",{title:getText("CAUTION"),text:getText("DO_U_GIVEUP")});
   _loc1_.addEventListener("yes",this);
};
Class_Kernel.prototype.useRessource = function(cellMC, cellNum, skillID)
{
   if(BATTLEFIELD.onCellRelease(cellMC))
   {
      AKS.Game.sendActions(500,[cellNum,skillID]);
   }
};
Class_Kernel.prototype.useSkill = function(skillID)
{
   AKS.Game.sendActions(507,[skillID]);
};
Class_Kernel.prototype.askPrivateMessage = function(playerName)
{
   var _loc1_ = this;
   _loc1_.tmpListener = new Object();
   var _loc2_ = GAPI.loadUIComponent("AskPrivateChat","AskPrivateChat",{title:getText("WISPER_MESSAGE") + " " + getText("TO") + " " + playerName});
   _loc2_.addEventListener("send",_loc1_.tmpListener);
   _loc2_.addEventListener("addfriend",_loc1_.tmpListener);
   _loc1_.tmpListener.send = function(oEvent)
   {
      if(oEvent.message.length != 0)
      {
         AKS.Chat.send(oEvent.message,playerName);
      }
      delete this;
   };
   _loc1_.tmpListener.addfriend = function(oEvent)
   {
      AKS.Account.addFriend(playerName);
      delete this;
   };
};
Class_Kernel.prototype.boom = function()
{
   var _loc1_;
   for(var _loc2_ in DATACENTER.Sprites.getItems())
   {
      _loc1_ = DATACENTER.Sprites.getItemAt(_loc2_).id;
      if(_loc1_ != undefined)
      {
         BATTLEFIELD.setSpriteAnim(_loc1_,"Hit");
         BATTLEFIELD.showSpritePoints(_loc1_,"-8",16777215);
      }
   }
};
Class_Kernel.prototype.offlineExchange = function()
{
   var _loc1_ = this;
   _loc1_.yes = function()
   {
      AKS.Exchange.offlineExchange();
      delete this.yes;
   };
   var _loc2_ = GAPI.loadUIComponent("AskYesNo","AskYesNoOfflineExchange",{title:getText("CAUTION"),text:getText("DO_U_OFFLINEEXCHANGE")});
   _loc2_.addEventListener("yes",_loc1_);
};
Class_Kernel.prototype.setChatFilters = function(aFilters)
{
   var _loc1_ = aFilters;
   CHAT.setTypes(_loc1_[0],_loc1_[1],_loc1_[2],_loc1_[3]);
};
CLass_Kernel.prototype.removeCursor = function(oEvent)
{
   if(BATTLEFIELD != undefined)
   {
      BATTLEFIELD.clearZoneLayer("spell");
      BATTLEFIELD.clearPointer();
   }
};
