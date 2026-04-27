AKS.Game.onCreateSolo = function(success)
{
   DATACENTER.Player.InteractionsManager.setState(false);
   BATTLEFIELD.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT);
   GAPI.removeCursor();
   if(!BATTLEFIELD.bMapBuild)
   {
      INTERFACE.clear();
      if(GAPI.getUIComponent("Banner") == undefined)
      {
         KERNEL.drawPlayerInterface();
      }
      ROOT.onEnterFrame = function()
      {
         AKS.Game.getMapData(DATACENTER.Map.id);
         delete this.onEnterFrame;
      };
   }
   else
   {
      GAPI.getUIComponent("Banner").showPoints(false);
      GAPI.getUIComponent("Banner").showNextTurnButton(false);
      GAPI.getUIComponent("Banner").showGiveUpButton(false);
      GAPI.unloadUIComponent("ChallengeMenu");
      BATTLEFIELD.cleanMap(2);
      AKS.Game.GetMapData(DATACENTER.Map.id);
   }
};
AKS.Game.onMapLoaded = function()
{
   BATTLEFIELD.showContainer(true);
};
AKS.Game.onMapData = function(id, sDate)
{
   var _loc1_ = this;
   var _loc2_;
   var _loc3_;
   if(id == DATACENTER.Map.id)
   {
      trace("ICICICIC " + DATACENTER.Map.bOutdoor);
      if(!DATACENTER.Map.bOutdoor)
      {
         NIGHTMANAGER.noEffects();
      }
      BATTLEFIELD.onMapLoaded();
   }
   else
   {
      BATTLEFIELD.showContainer(false);
      _loc2_ = new ank.utils.SwfDataLoader();
      _loc1_.loaded = _loc1_.onMapDataFileLoaded;
      _loc1_.nofile = _loc1_.onMapNoDataFile;
      _loc2_.addEventListener("loaded",_loc1_);
      _loc2_.addEventListener("nofile",_loc1_);
      GAPI.loadUIComponent("Waiting","Waiting");
      _loc3_ = !dofus.Constants.DEBUG ? getConfigText("MAPS_DATA_PATH") : dofus.Constants.MAPS_DATA_PATH;
      _loc2_.load(_loc3_ + id + "_" + sDate + ".swf");
   }
};
AKS.Game.onMapNoDataFile = function(oEvent)
{
   INTERFACE.MainLayer_mc.waiting.close();
   GAPI.unloadUIComponent("Waiting");
   INTERFACE.Text.setText("",false);
   GAPI.loadUIComponent("AskOk","AskOkNoMapData",{title:getText("ERROR_WORD"),text:getText("NO_MAPDATA_FILE")});
};
AKS.Game.onMapDataFileLoaded = function(oEvent)
{
   INTERFACE.MainLayer_mc.waiting.close();
   GAPI.unloadUIComponent("Waiting");
   var _loc1_ = oEvent.data;
   var _loc2_ = _loc1_.id;
   var name = getMapText(_loc2_).n;
   var width = _loc1_.width;
   var height = _loc1_.height;
   var backgroundID = _loc1_.backgroundNum;
   var data = _loc1_.mapData;
   var ambianceID = _loc1_.ambianceId;
   var musicID = _loc1_.musicId;
   var _loc3_ = _loc1_.bOutdoor != 1 ? false : true;
   var bCanChallenge = (_loc1_.capabilities & 1) == 0;
   var bCanAttack = (_loc1_.capabilities >> 1 & 1) == 0;
   var bSaveTeleport = (_loc1_.capabilities >> 2 & 1) == 0;
   var bUseTeleport = (_loc1_.capabilities >> 3 & 1) == 0;
   BATTLEFIELD.buildMap(Number(_loc2_),name,Number(width),Number(height),Number(backgroundID),data);
   DATACENTER.Map.bCanChallenge = bCanChallenge;
   DATACENTER.Map.bCanAttack = bCanAttack;
   DATACENTER.Map.bSaveTeleport = bSaveTeleport;
   DATACENTER.Map.bUseTeleport = bUseTeleport;
   DATACENTER.Map.bOutdoor = _loc3_;
   DATACENTER.Map.musicID = musicID;
   SOMA.playAmbiance(ambianceID);
   SOMA.playMusic(musicID);
   if(!_loc3_)
   {
      NIGHTMANAGER.noEffects();
   }
};
AKS.Game.onCellData = function(cellNum, compressData, maskHexStr)
{
   BATTLEFIELD.updateCell(cellNum,compressData,maskHexStr,1);
};
AKS.Game.onCellObject = function(bNew, cellNum, itemUnicID)
{
   var _loc1_;
   if(bNew)
   {
      _loc1_ = new dofus.datacenter.Item(0,itemUnicID);
      BATTLEFIELD.updateCellObject2WithExternalClip(cellNum,_loc1_.iconFile,1);
   }
   else
   {
      BATTLEFIELD.initializeCell(cellNum,1);
   }
};
AKS.Game.onZoneData = function(bAdd, cellNum, radius, zoneID)
{
   var _loc1_ = zoneID;
   if(bAdd)
   {
      BATTLEFIELD.drawZone(cellNum,radius,_loc1_,dofus.Constants.ZONE_COLOR[_loc1_]);
   }
   else
   {
      BATTLEFIELD.clearZone(cellNum,radius,_loc1_);
   }
};
AKS.Game.onJoin = function(success, state, bCanBeCanceled, nTimer)
{
   if(success)
   {
      AKS.Chat.output.clearForNewChat();
      GAPI.loadUIComponent("ChallengeMenu","ChallengeMenu",{labelReady:getText("READY"),labelCancel:getText("CANCEL_SMALL"),cancelButton:bCanBeCanceled,ready:false});
      if(!isNaN(nTimer))
      {
         GAPI.getUIComponent("Banner").startTimer(nTimer / 1000);
      }
      DATACENTER.Player.bIsReady = false;
      BATTLEFIELD.setInteraction(ank.battlefield.Constants.INTERACTION_OBJECT_NONE);
   }
   else
   {
      KERNEL.traceToChat(getText("ERROR_JOINING_GAME",[]) + " : " + getText("ERROR_JOINING_" + params,[]),dofus.Constants.ERROR_CHAT_COLOR);
   }
};
AKS.Game.onChallenge = function(bAdd, spriteData)
{
   var _loc1_ = spriteData;
   if(badd)
   {
      BATTLEFIELD.addSprite(_loc1_.id,_loc1_);
   }
   else
   {
      BATTLEFIELD.removeSprite(_loc1_.id);
   }
};
AKS.Game.onMovement = function(badd, characData)
{
   DATACENTER.Game.playerCount += !badd ? -1 : 1;
   if(badd)
   {
      BATTLEFIELD.addSprite(characData.id);
      if(characData instanceof dofus.datacenter.OfflineCharacter)
      {
         characData.sprite_mc.addExtraClip(dofus.Constants.OFFLINE_FILE);
      }
      if(DATACENTER.Game.isRunning)
      {
         BATTLEFIELD.addSpriteExtraClip(characData.id,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[characData.Team]);
      }
      if(characData.id == DATACENTER.Player.ID)
      {
         var unicText = getItemUnicText(characData.Accessories[0].unicID);
         DATACENTER.Player.setCCData(unicText.a,unicText.r,unicText.e[0]);
      }
   }
   else if(!DATACENTER.Game.isMultiplayer || !DATACENTER.Game.isRunning)
   {
      BATTLEFIELD.removeSprite(characData.id);
   }
   else
   {
      var seq = characData.sequencer;
      var characClip = characData.sprite_mc;
      seq.addAction(false,KERNEL,KERNEL.traceToChat,[getText("LEAVE_GAME",[characData.name]),dofus.Constants.INFO_CHAT_COLOR]);
      seq.addAction(false,GAPI.getUIComponent("Timeline"),GAPI.getUIComponent("Timeline").hideItem,[characData.id]);
      seq.addAction(true,characClip,characClip.setAnim,["Die"],1500);
      seq.addAction(false,characClip,characClip.clear);
      seq.execute();
      if(DATACENTER.Game.currentPlayerID == characData.id)
      {
         GAPI.getUIComponent("Banner").stopTimer();
         GAPI.getUIComponent("Timeline").stopChrono();
      }
   }
   var _loc1_;
   var _loc3_;
   var _loc2_;
   if(!DATACENTER.Game.isMultiplayer)
   {
      var count = DATACENTER.Game.playerCount;
      if(count >= dofus.Constants.MAX_PLAYERS_ON_MAP)
      {
         var items = DATACENTER.Sprites.getItems();
         for(var k in items)
         {
            _loc1_ = items[k];
            if(_loc1_ instanceof dofus.datacenter.Character)
            {
               _loc3_ = items[k].id;
               if(!_loc1_.bInCreaturesMode)
               {
                  _loc1_.tmpGfxFile = _loc1_.gfxFile;
                  _loc2_ = dofus.Constants.CLIPS_PERSOS_PATH + items[k].guild + "2.swf";
                  BATTLEFIELD.setSpriteGfx(_loc3_,_loc2_);
                  _loc1_.bInCreaturesMode = true;
               }
            }
         }
         DATACENTER.Game.bInCreaturesMode = true;
      }
      if(count < dofus.Constants.MIN_CREATURES_ON_MAP)
      {
         var items = DATACENTER.Sprites.getItems();
         for(var k in items)
         {
            _loc1_ = items[k];
            if(_loc1_ instanceof dofus.datacenter.Character)
            {
               _loc3_ = _loc1_.id;
               if(_loc1_.bInCreaturesMode)
               {
                  _loc2_ = _loc1_.tmpGfxFile != undefined ? _loc1_.tmpGfxFile : _loc1_.gfxFile;
                  delete _loc1_.tmpGfxFile;
                  BATTLEFIELD.setSpriteGfx(_loc3_,_loc2_);
                  _loc1_.bInCreaturesMode = false;
               }
            }
         }
         DATACENTER.Game.bInCreaturesMode = false;
      }
   }
};
AKS.Game.onLeave = function()
{
   this.onActionsFinish(DATACENTER.Player.ID);
   var isMultiplayer = DATACENTER.Game.isMultiplayer;
   DATACENTER.Game = new Class_DataCenter_Game();
   DATACENTER.Player.reset();
   this.createSolo();
};
AKS.Game.onPositionStart = function(cells)
{
   var _loc2_ = cells;
   BATTLEFIELD.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
   DATACENTER.Game.setInteractionType("place");
   var localTeam = _loc2_[2];
   if(localTeam == undefined)
   {
      ank.utils.Logger.err("[onPositionStart] Impossible de trouver l\'équipe du joueur local !");
   }
   var _loc1_ = 0;
   var _loc3_ = 0;
   while(_loc3_ < _loc2_[0].length)
   {
      _loc1_ = ank.utils.Compressor.decode64(_loc2_[0].charAt(_loc3_)) << 6;
      _loc1_ += ank.utils.Compressor.decode64(_loc2_[0].charAt(_loc3_ + 1));
      if(localTeam == 0)
      {
         BATTLEFIELD.setInteractionOnCell(_loc1_,ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
      }
      BATTLEFIELD.select(_loc1_,dofus.Constants.TEAMS_COLOR[0]);
      _loc3_ += 2;
   }
   _loc3_ = 0;
   while(_loc3_ < _loc2_[1].length)
   {
      _loc1_ = ank.utils.Compressor.decode64(_loc2_[1].charAt(_loc3_)) << 6;
      _loc1_ += ank.utils.Compressor.decode64(_loc2_[1].charAt(_loc3_ + 1));
      if(localTeam == 1)
      {
         BATTLEFIELD.setInteractionOnCell(_loc1_,ank.battlefield.Constants.INTERACTION_CELL_RELEASE);
      }
      BATTLEFIELD.select(_loc1_,dofus.Constants.TEAMS_COLOR[1]);
      _loc3_ += 2;
   }
};
AKS.Game.onPlayersCoordinates = function(updatedData)
{
   var _loc3_ = updatedData;
   var _loc1_ = 0;
   var _loc2_;
   while(_loc1_ < _loc3_.length)
   {
      _loc2_ = _loc3_[_loc1_][0];
      var cell = _loc3_[_loc1_][1];
      BATTLEFIELD.setSpritePosition(_loc2_,cell);
      _loc1_ = _loc1_ + 1;
   }
};
AKS.Game.onEnd = function(idSender)
{
   var _loc1_ = this;
   if(isSender == DATACENTER.Player.ID)
   {
      _loc1_.onActionsFinish(DATACENTER.Player.ID);
   }
   DATACENTER.Game.m_bRunning = false;
   var _loc2_ = DATACENTER.Sprites.getItemAt(idSender).sequencer;
   if(_loc2_ != undefined)
   {
      _loc2_.addAction(false,_loc1_,_loc1_.end);
      _loc2_.execute(true);
   }
   else
   {
      ank.utils.Logger.err("[AKS.Game.onEnd] Impossible de trouver le sequencer");
      ank.utils.Timer.setTimer(_loc1_,_loc1_,_loc1_.end,6000);
   }
};
AKS.Game.end = function()
{
   GAPI.unloadUIComponent("Timeline");
   GAPI.getUIComponent("Banner").stopTimer();
   SOMA.onGameEnd();
   SOMA.playMusic(DATACENTER.Map.musicID);
   KERNEL.traceToChat("Fin de partie",dofus.Constants.INFO_CHAT_COLOR);
   GAPI.loadUIComponent("GameResult","GameResult",{data:DATACENTER.Game.Results});
   this.onLeave();
};
AKS.Game.onChangeTeam = function(bool, item, team)
{
   if(bool)
   {
      item.setPlayerTeam(team);
   }
   else
   {
      KERNEL.traceToChat(getText("CANT_CHANGE_TEAM"),dofus.Constants.ERROR_CHAT_COLOR);
   }
};
AKS.Game.onTurnList = function()
{
   GAPI.getUIComponent("Timeline").update();
};
AKS.Game.onStartToPlay = function()
{
   GAPI.getUIComponent("Banner").stopTimer();
   this.onActionsFinish(DATACENTER.Player.ID);
   SOMA.onGameStart();
   DATACENTER.Player.data.initAP();
   DATACENTER.Player.data.initMP();
   DATACENTER.Player.data.initLP();
   GAPI.getUIComponent("Banner").showPoints(true);
   GAPI.getUIComponent("Banner").showNextTurnButton(true);
   GAPI.getUIComponent("Banner").showGiveUpButton(true);
   GAPI.loadUIComponent("Timeline","Timeline");
   GAPI.unloadUIComponent("ChallengeMenu");
   INTERFACE.Text.setTextTimer(getText("GAME_LAUNCH",[]),2000,false,true);
   BATTLEFIELD.unSelect(true);
   BATTLEFIELD.drawGrid();
   DATACENTER.Game.setInteractionType("move");
   BATTLEFIELD.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
   DATACENTER.Game.m_bRunning = true;
   var _loc1_ = DATACENTER.Sprites.getItems();
   for(var _loc2_ in _loc1_)
   {
      BATTLEFIELD.addSpriteExtraClip(_loc2_,dofus.Constants.CIRCLE_FILE,dofus.Constants.TEAMS_COLOR[_loc1_[_loc2_].Team]);
   }
};
AKS.Game.onTurnStart = function(characID, duration)
{
   var _loc2_ = characID;
   var _loc1_ = DATACENTER.Sprites.getItemAt(_loc2_);
   _loc1_.GameActionsManager.clear();
   _loc1_.EffectsManager.nextTurn();
   GAPI.getUIComponent("Timeline").nextTurn(_loc2_);
   DATACENTER.Game.currentPlayerID = _loc2_;
   if(DATACENTER.Player.isCurrentPlayer)
   {
      GAPI.getUIComponent("Banner").startTimer(duration);
   }
   else
   {
      GAPI.getUIComponent("Timeline").startChrono(duration);
   }
   if(_loc2_ == DATACENTER.Player.ID)
   {
      BATTLEFIELD.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT);
      DATACENTER.Player.SpellsManager.nextTurn();
   }
   KERNEL.cleanPlayer(DATACENTER.Game.lastPlayerID);
   GAPI.loadUIComponent("StringCourse","StringCourse",{gfx:dofus.Constants.ARTWORKS_BIG_PATH + _loc1_.gfxID + ".swf",name:_loc1_.name,level:getText("LEVEL_SMALL") + " " + _loc1_.level},{bForceLoad:true});
   BATTLEFIELD.Selection.unSelectAll();
};
AKS.Game.onTurnReady = function(nID)
{
   var _loc1_ = DATACENTER.Sprites.getItemAt(nID);
   var _loc2_;
   if(_loc1_ != undefined)
   {
      _loc2_ = _loc1_.sequencer;
      _loc2_.addAction(false,AKS.Game,AKS.Game.turnOk);
      _loc2_.execute();
   }
   else
   {
      ank.utils.Logger.err("[onTurnReday] le sprite " + nID + " n\'existe pas");
   }
};
AKS.Game.onTurnMiddle = function(nID, bDied, nLP, nAP, nMP, nCellNum, nDir)
{
   var _loc1_ = DATACENTER.Sprites.getItemAt(nID);
   if(_loc1_ != undefined)
   {
      _loc1_.sequencer.clearAllNextActions();
      if(bDied)
      {
         _loc1_.sprite_mc.clear();
      }
      else
      {
         _loc1_.LP = nLP;
         _loc1_.AP = nAP;
         _loc1_.MP = nMP;
         if(!isNaN(nCellNum))
         {
            BATTLEFIELD.setSpritePosition(nId,nCellNum);
         }
      }
   }
   else
   {
      ank.utils.Logger.err("[onTurnMiddle] le sprite n\'existe pas");
   }
};
AKS.Game.onTurnFinish = function(characID)
{
   var _loc1_ = DATACENTER.Sprites.getItemAt(characID);
   _loc1_.EffectsManager.refresh();
   if(characID == DATACENTER.Player.ID)
   {
      BATTLEFIELD.setInteraction(ank.battlefield.Constants.INTERACTION_CELL_NONE);
   }
   DATACENTER.Game.lastPlayerID = DATACENTER.Game.currentPlayerID;
   DATACENTER.Game.currentPlayerID = null;
   GAPI.getUIComponent("Banner").stopTimer();
   GAPI.getUIComponent("Timeline").stopChrono();
   KERNEL.cleanUpGameArea(true);
};
AKS.Game.onActionsStart = function(characID)
{
   var _loc2_;
   var _loc1_;
   if(characID == DATACENTER.Player.ID)
   {
      _loc2_ = DATACENTER.Player.data;
      _loc2_.GameActionsManager.m_bNextAction = true;
      if(DATACENTER.Game.isFight)
      {
         _loc1_ = _loc2_.sequencer;
         _loc1_.addAction(false,BATTLEFIELD,BATTLEFIELD.setInteraction,[ank.battlefield.Constants.INTERACTION_CELL_NONE]);
         _loc1_.execute();
      }
   }
};
AKS.Game.onActionsFinish = function(nCharacID, nActionID)
{
   var _loc2_;
   var _loc1_;
   if(nCharacID == DATACENTER.Player.ID)
   {
      _loc2_ = DATACENTER.Player.data;
      _loc1_ = _loc2_.sequencer;
      _loc2_.GameActionsManager.m_bNextAction = false;
      if(DATACENTER.Game.isFight)
      {
         _loc1_.addAction(false,KERNEL,KERNEL.setEnabledInteractionIfICan,[ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT]);
         if(nActionID != undefined)
         {
            _loc1_.AddAction(false,AKS.Game,AKS.Game.ActionAck,[nActionID]);
         }
         _loc1_.addAction(false,KERNEL,KERNEL.cleanPlayer,[characID]);
         _loc1_.execute();
      }
   }
};
AKS.Game.onReady = function(bool, id)
{
   var _loc1_ = id;
   if(_loc1_ == DATACENTER.Player.ID)
   {
      DATACENTER.Player.bIsReady = bool;
   }
   if(bool)
   {
      BATTLEFIELD.addSpriteExtraClip(_loc1_,dofus.Constants.READY_FILE);
   }
   else
   {
      BATTLEFIELD.removeSpriteExtraClip(_loc1_);
   }
};
AKS.Game.onActions = function(idAction, typeAction, idSender, params)
{
   var _loc2_ = params;
   var _loc3_ = idSender;
   if(isNaN(Number(_loc3_)))
   {
      _loc3_ = DATACENTER.Player.ID;
   }
   var typeAction = Number(typeAction);
   var characData = DATACENTER.Sprites.getItemAt(_loc3_);
   var _loc1_ = characData.sequencer;
   var GameActionsManager = characData.GameActionsManager;
   var bSequence = true;
   GameActionsManager.onServerResponse(idAction);
   switch(typeAction)
   {
      case 0:
         return;
      case 1:
         BATTLEFIELD.moveSprite(_loc3_,_loc2_,_loc1_,!DATACENTER.Game.isMultiplayer,DATACENTER.Game.bInCreaturesMode,false,!DATACENTER.Game.isMultiplayer ? 6 : 8);
         if(DATACENTER.Game.isRunning)
         {
            _loc1_.addAction(false,BATTLEFIELD,BATTLEFIELD.unSelect,[true]);
         }
         break;
      case 2:
         _loc1_.addAction(false,INTERFACE.Text,INTERFACE.Text.setText,[getText("LOADING_MAP"),false]);
         _loc1_.addAction(false,BATTLEFIELD,BATTLEFIELD.Clear);
         _loc1_.addAction(false,DATACENTER,DATACENTER.clearGame);
         _loc1_.addAction(true,ank.utils.Timer,ank.utils.Timer.setTimer,[_loc1_,_loc1_,_loc1_.onActionEnd,50]);
         _loc1_.addAction(false,AKS.Game,AKS.Game.getMapData,[DATACENTER.Map.id]);
         break;
      case 4:
         var tmpArray = _loc2_.split(",");
         var characClip = DATACENTER.Sprites.getItemAt(tmpArray[0]).sprite_mc;
         _loc1_.addAction(false,characClip,characClip.setPosition,[tmpArray[1]]);
         break;
      case 5:
         var tmpArray = _loc2_.split(",");
         BATTLEFIELD.slideSprite(tmpArray[0],tmpArray[1],_loc1_);
         break;
      case 100:
      case 108:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
         var dLP = Number(tmpArray[1]);
         var txt = dLP >= 0 ? "WIN_LP" : "LOST_LP";
         if(dLP != 0)
         {
            _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText(txt,[characData.name,Math.abs(dLP)]),dofus.Constants.INFO_CHAT_COLOR]);
            _loc1_.addAction(false,characData,characData.updateLP,[dLP]);
         }
         else
         {
            _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("NOCHANGE_LP",[characData.name]),dofus.Constants.INFO_CHAT_COLOR]);
         }
         break;
      case 101:
      case 102:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
         var dAP = Number(tmpArray[1]);
         if(dAP == 0)
         {
            break;
         }
         if(typeAction == 101)
         {
            _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("LOST_AP",[characData.name,dAP]),dofus.Constants.INFO_CHAT_COLOR]);
         }
         _loc1_.addAction(false,characData,characData.updateAP,[dAP,typeAction == 102]);
         break;
      case 103:
         var characID = _loc2_;
         var characData = DATACENTER.Sprites.getItemAt(characID);
         var characClip = characData.sprite_mc;
         trace("mort : " + characClip);
         var sex = characData.sex != 1 ? "m" : "f";
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[ank.utils.PatternDecoder.combine(getText("DIE",[characData.name]),sex,true),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,GAPI.getUIComponent("Timeline"),GAPI.getUIComponent("Timeline").hideItem,[characData.id]);
         _loc1_.addAction(true,characClip,characClip.setAnim,["Die"],1500);
         _loc1_.addAction(false,characClip,characClip.clear);
         break;
      case 104:
         var characData = DATACENTER.Sprites.getItemAt(_loc3_);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("CANT_MOVEOUT"),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,characData.sprite_mc,characData.sprite_mc.setAnim,["hit"]);
         break;
      case 105:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("REDUCE_DAMAGES",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         break;
      case 106:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
         var txt = tmpArray[1] != 1 ? getText("RETURN_SPELL_NO",[characData.name]) : getText("RETURN_SPELL_OK",[characData.name]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[txt,dofus.Constants.INFO_CHAT_COLOR]);
         break;
      case 107:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
         var txt = getText("RETURN_DAMAGES",[characData.name,tmpArray[1]]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[txt,dofus.Constants.INFO_CHAT_COLOR]);
         break;
      case 110:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("BOOST_LIFE_POINTS",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,characData,characData.updateLP,[tmpArray[1]]);
         break;
      case 111:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("BOOST_ACTION_POINTS",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,characData,characData.updateAP,[tmpArray[1],false]);
         break;
      case 112:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("BOOST_DAMAGES",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,KERNEL,KERNEL.addToCharacteristicsManager,[characData,16,tmpArray[1],tmpArray[2],characID == _loc3_]);
         break;
      case 114:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("MULTIPLICATE_DAMAGES",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,KERNEL,KERNEL.addToCharacteristicsManager,[characData,17,tmpArray[1],tmpArray[2],characID == _loc3_]);
         break;
      case 115:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("BOOST_CRITICAL_HIT",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,KERNEL,KERNEL.addToCharacteristicsManager,[characData,18,tmpArray[1],tmpArray[2],characID == _loc3_]);
         break;
      case 117:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("MODERATE_RANGE",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,KERNEL,KERNEL.addToCharacteristicsManager,[characData,19,tmpArray[1],tmpArray[2],characID == _loc3_]);
         break;
      case 118:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("MODERATE_STRENGTH",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,DATACENTER.Player,DATACENTER.Player.update,["force",Number(tmpArray[1])]);
         _loc1_.addAction(false,KERNEL,KERNEL.addToCharacteristicsManager,[characData,10,tmpArray[1],tmpArray[2],characID == _loc3_]);
         break;
      case 119:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("MODERATE_AGILITY",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,DATACENTER,DATACENTER.Player,["agility",Number(tmpArray[1])]);
         _loc1_.addAction(false,KERNEL,KERNEL.addToCharacteristicsManager,[characData,14,tmpArray[1],tmpArray[2],characID == _loc3_]);
         break;
      case 120:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,characData,characData.updateLP,[tmpArray[1]]);
         if(tmpArray[0] == _loc3_)
         {
            _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("BOOST_FRIEND_LIFE_POINTS",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         }
         _loc1_.addAction(false,KERNEL,KERNEL.addToCharacteristicsManager,[characData,0,tmpArray[1],tmpArray[2],characID == _loc3_]);
         break;
      case 121:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,characData,characData.updateAP,[tmpArray[1]]);
         if(tmpArray[0] == _loc3_)
         {
            _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("BOOST_FRIEND_ACTION_POINTS",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         }
         break;
      case 122:
         if(tmpArray[0] == _loc3_)
         {
            var tmpArray = _loc2_.split(",");
            var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
            _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("BOOST_FRIEND_DAMAGES",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         }
         break;
      case 123:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("MODERATE_KARMA",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,DATACENTER,DATACENTER.Player,["karma",Number(tmpArray[1])]);
         _loc1_.addAction(false,KERNEL,KERNEL.addToCharacteristicsManager,[characData,13,tmpArray[1],tmpArray[2],characID == _loc3_]);
         break;
      case 124:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("MODERATE_CHARISM",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,DATACENTER,DATACENTER.Player,["charism",Number(tmpArray[1])]);
         _loc1_.addAction(false,KERNEL,KERNEL.addToCharacteristicsManager,[characData,12,tmpArray[1],tmpArray[2],characID == _loc3_]);
         break;
      case 125:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("MODERATE_VITALITY",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,DATACENTER,DATACENTER.Player,["vitality",Number(tmpArray[1])]);
         _loc1_.addAction(false,KERNEL,KERNEL.addToCharacteristicsManager,[characData,11,tmpArray[1],tmpArray[2],characID == _loc3_]);
         break;
      case 126:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("MODERATE_INTELLIGENCE",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,DATACENTER,DATACENTER.Player,["intelligence",Number(tmpArray[1])]);
         _loc1_.addAction(false,KERNEL,KERNEL.addToCharacteristicsManager,[characData,15,tmpArray[1],tmpArray[2],characID == _loc3_]);
         break;
      case 127:
      case 128:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var dMP = Number(tmpArray[1]);
         var characData = DATACENTER.Sprites.getItemAt(characID);
         _loc1_.addAction(false,characData,characData.updateMP,[dMP]);
         if(typeAction == 127)
         {
            var txt = dMP >= 0 ? "WIN_MP" : "LOST_MP";
            _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText(txt,[characData.name,Math.abs(dMP)]),dofus.Constants.INFO_CHAT_COLOR]);
         }
         else if(tmpArray[0] == _loc3_)
         {
            _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("BOOST_MOVE_POINTS",[characData.name,dMP]),dofus.Constants.INFO_CHAT_COLOR]);
         }
         break;
      case 129:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
         var dMP = Number(tmpArray[1]);
         if(dMP == 0)
         {
            break;
         }
         if(typeAction == 127)
         {
            _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("LOST_MP",[characData.name,dMP]),dofus.Constants.INFO_CHAT_COLOR]);
         }
         _loc1_.addAction(false,characData,characData.updateMP,[dMP,typeAction == 129]);
         break;
      case 130:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(_loc3_);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[ank.utils.PatternDecoder.combine(getText("STEAL_GOLD",[characData.name,tmpArray[0]]),"m",Number(tmpArray[0]) < 2),dofus.Constants.INFO_CHAT_COLOR]);
         break;
      case 132:
         var characDataFrom = DATACENTER.Sprites.getItemAt(_loc3_);
         var characDataTo = DATACENTER.Sprites.getItemAt(_loc2_);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("REMOVE_ALL_EFFECTS",[characDataFrom.name,characDataTo.name]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,characDataTo.CharacteristicsManager,characDataTo.CharacteristicsManager.terminateAllEffects);
         _loc1_.addAction(false,characDataTo.EffectsManager,characDataTo.EffectsManager.terminateAllEffects);
         break;
      case 138:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("BOOST_DAMAGES_PERCENT",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         break;
      case 150:
         var tmpArray = _loc2_.split(",");
         var characID = tmpArray[0];
         var characData = DATACENTER.Sprites.getItemAt(characID);
         var nDuration = Number(tmpArray[1]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("INVISIBILITY",[characData.name]),dofus.Constants.INFO_CHAT_COLOR]);
         if(nDuration > 0)
         {
            _loc1_.addAction(false,KERNEL,KERNEL.addToCharacteristicsManager,[characData,24,characID == DATACENTER.Player.ID,nDuration,characID == _loc3_]);
         }
         else
         {
            BATTLEFIELD.hideSprite(characID,false);
         }
         break;
      case 151:
         var spellID = _loc2_;
         var characData = DATACENTER.Sprites.getItemAt(_loc3_);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("INVISIBLE_OBSTACLE",[characData.name,getSpellText(spellID).n]),dofus.Constants.ERROR_CHAT_COLOR]);
         break;
      case 160:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("DODGE_AP_DAMAGES",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         break;
      case 161:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("DODGE_MP_DAMAGES",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         break;
      case 162:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
         var txt = getText("RETURN_AP",[characData.name,tmpArray[1]]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[txt,dofus.Constants.INFO_CHAT_COLOR]);
         break;
      case 163:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
         var txt = getText("RETURN_MP",[characData.name,tmpArray[1]]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[txt,dofus.Constants.INFO_CHAT_COLOR]);
         break;
      case 164:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("REDUCE_LP_DAMAGES",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         break;
      case 180:
      case 181:
         _loc1_.addAction(false,AKS.Game,AKS.Game.innerOnMovement,[_loc2_]);
         break;
      case 182:
         var tmpArray = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(tmpArray[0]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("INCREASE_INVOCATION_COUNT",[characData.name,tmpArray[1]]),dofus.Constants.INFO_CHAT_COLOR]);
         break;
      case 200:
         var aTmp = _loc2_.split(",");
         var cellNum = aTmp[0];
         var frame = aTmp[1];
         _loc1_.addAction(false,BATTLEFIELD,BATTLEFIELD.setObject2Frame,[cellNum,frame]);
         break;
      case 300:
         var spellParams = _loc2_.split(",");
         var characData = DATACENTER.Sprites.getItemAt(_loc3_);
         var characClip = characData.sprite_mc;
         var cellNum = spellParams[1];
         var eff = new ank.battlefield.datacenter.VisualEffect();
         eff.id = spellParams[0];
         eff.file = dofus.Constants.SPELLS_PATH + spellParams[2] + ".swf";
         eff.level = spellParams[3];
         eff.bInFrontOfSprite = spellParams[6] != "1" ? false : true;
         BATTLEFIELD.spriteLaunchVisualEffect(_loc3_,eff,Number(cellNum),Number(spellParams[4]),Number(spellParams[5]));
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("HAS_LAUNCH_SPELL",[characData.name,getSpellText(eff.id).n]),dofus.Constants.INFO_CHAT_COLOR]);
         if(_loc3_ == DATACENTER.Player.ID)
         {
            var spellsManager = DATACENTER.Player.SpellsManager;
            var spriteOnID = BATTLEFIELD.mapHandler.getCellData(cellNum).SpriteOnID;
            var spD = new Class_DataCenter_SpellLaunch(eff.id,spriteOnID);
            spellsManager.addLaunchedSpell(spD);
         }
         break;
      case 301:
         var spellID = _loc2_;
         var characData = DATACENTER.Sprites.getItemAt(_loc3_);
         var characClip = characData.sprite_mc;
         _loc1_.addAction(false,SOMA,SOMA.onGameCriticalHit,[]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[" (" + getText("CRITICAL_HIT") + ")",dofus.Constants.INFO_CHAT_COLOR,true]);
         _loc1_.addAction(false,characClip,characClip.setAnim,["bonus"]);
         break;
      case 302:
         var spellID = _loc2_;
         var characData = DATACENTER.Sprites.getItemAt(_loc3_);
         _loc1_.addAction(false,SOMA,SOMA.onGameCriticalMiss,[]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("HAS_LAUNCH_SPELL",[characData.name,getSpellText(spellID).n]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[" (" + getText("CRITICAL_MISS") + ")",dofus.Constants.INFO_CHAT_COLOR,true]);
         _loc1_.addAction(false,BATTLEFIELD,BATTLEFIELD.addSpriteBubble,[_loc3_,getText("CRITICAL_MISS")]);
         break;
      case 303:
         var destCell = _loc2_;
         var characData = DATACENTER.Sprites.getItemAt(_loc3_);
         var characClip = characData.sprite_mc;
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("HAS_ATTACK_CC",[characData.name]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,BATTLEFIELD,BATTLEFIELD.autoCalculateSpriteDirection,[_loc3_,destCell]);
         _loc1_.addAction(true,BATTLEFIELD,BATTLEFIELD.setSpriteAnim,[_loc3_,characData.ToolAnimation]);
         break;
      case 304:
         var characData = DATACENTER.Sprites.getItemAt(_loc3_);
         var characClip = characData.sprite_mc;
         _loc1_.addAction(false,SOMA,SOMA.onGameCriticalHit,[]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[" (" + getText("CRITICAL_HIT") + ")",dofus.Constants.INFO_CHAT_COLOR,true]);
         _loc1_.addAction(false,characClip,characClip.setAnim,["bonus"]);
         break;
      case 305:
         var characData = DATACENTER.Sprites.getItemAt(_loc3_);
         _loc1_.addAction(false,SOMA,SOMA.onGameCriticalMiss,[]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("HAS_ATTACK_CC",[characData.name]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[" (" + getText("CRITICAL_MISS") + ")",dofus.Constants.INFO_CHAT_COLOR,true]);
         _loc1_.addAction(false,BATTLEFIELD,BATTLEFIELD.addSpriteBubble,[_loc3_,getText("CRITICAL_MISS")]);
         break;
      case 306:
         var spellParams = _loc2_.split(",");
         var characHitData = DATACENTER.Sprites.getItemAt(_loc3_);
         var characShootData = DATACENTER.Sprites.getItemAt(spellParams[5]);
         var cellNum = spellParams[1];
         var eff = new ank.battlefield.datacenter.VisualEffect();
         eff.id = spellParams[0];
         eff.file = dofus.Constants.SPELLS_PATH + spellParams[2] + ".swf";
         eff.level = spellParams[3];
         eff.bInFrontOfPlayer = spellParams[4] != "1" ? false : true;
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("HAS_START_TRAP",[characHitData.name,getSpellText(eff.id).n,characShootData.name]),dofus.Constants.INFO_CHAT_COLOR]);
         _loc1_.addAction(true,BATTLEFIELD,BATTLEFIELD.addVisualEffectOnSprite,[spellParams[5],eff,cellNum,11],1000);
         break;
      case 307:
         var spellParams = _loc2_.split(",");
         var characHitData = DATACENTER.Sprites.getItemAt(_loc3_);
         var characShootData = DATACENTER.Sprites.getItemAt(spellParams[5]);
         var cellNum = spellParams[1];
         var sd = new Class_DataCenter_Spell();
         sd.m_ID = spellParams[0];
         sd.m_AnimID = spellParams[2];
         sd.m_Level = spellParams[3];
         sd.m_bInFrontOfPlayer = spellParams[4] != "1" ? false : true;
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("HAS_START_GLIPH",[characHitData.name,getSpellText(sd.m_ID).n,characShootData.name]),dofus.Constants.INFO_CHAT_COLOR]);
         break;
      case 308:
         var characData = DATACENTER.Sprites.getItemAt(_loc2_);
         _loc1_.addAction(false,KERNEL,KERNEL.traceToChat,[getText("HAS_DODGE_SPELL",[characData.name]),dofus.Constants.INFO_CHAT_COLOR]);
         break;
      case 501:
         var aTmp = _loc2_.split(",");
         var cellNum = aTmp[0];
         var nTimer = Number(aTmp[1]);
         var oCharacData = DATACENTER.Sprites.getItemAt(_loc3_);
         _loc1_.addAction(false,BATTLEFIELD,BATTLEFIELD.autoCalculateSpriteDirection,[_loc3_,cellNum]);
         _loc1_.addAction(_loc3_ == DATACENTER.Player.ID,BATTLEFIELD,BATTLEFIELD.setSpriteLoopAnim,[_loc3_,oCharacData.ToolAnimation,nTimer],nTimer);
         break;
      case 900:
         bSequence = false;
         var characDataFrom = DATACENTER.Sprites.getItemAt(_loc3_);
         var characDataTo = DATACENTER.Sprites.getItemAt(Number(_loc2_));
         if(characDataFrom == undefined || characDataTo == undefined)
         {
            AKS.Game.refuseChallenge([_loc3_]);
            return;
         }
         KERNEL.traceToChat(getText("A_CHALENGE_B",[characDataFrom.name,characDataTo.name]),dofus.Constants.INFO_CHAT_COLOR);
         if(characDataFrom.id == DATACENTER.Player.ID)
         {
            INTERFACE.cancel = function()
            {
               AKS.Game.refuseChallenge([characDataFrom.id]);
            };
            var cmp = GAPI.loadUIComponent("AskCancel","AskCancelChalenge",{title:getText("CHALENGE"),text:getText("YOU_CHALENGE_B",[characDataTo.name])});
            cmp.addEventListener("cancel",INTERFACE);
         }
         if(characDataTo.id == DATACENTER.Player.ID)
         {
            INTERFACE.yes = function()
            {
               AKS.Game.acceptChallenge([characDataFrom.id]);
            };
            INTERFACE.no = function()
            {
               AKS.Game.refuseChallenge([characDataFrom.id]);
            };
            var cmp = GAPI.loadUIComponent("AskYesNo","AskYesNoChalenge",{title:getText("CHALENGE"),text:getText("A_CHALENGE_YOU",[characDataFrom.name])});
            cmp.addEventListener("yes",INTERFACE);
            cmp.addEventListener("no",INTERFACE);
            SONA.onGameInvitation();
         }
         break;
      case 901:
         bSequence = false;
         if(Number(_loc3_) == DATACENTER.Player.ID || Number(_loc2_) == DATACENTER.Player.ID)
         {
            GAPI.unloadUIComponent("AskCancelChalenge");
         }
         break;
      case 902:
         bSequence = false;
         GAPI.unloadUIComponent("AskYesNoChalenge");
         GAPI.unloadUIComponent("AskCancelChalenge");
         break;
      case 903:
         bSequence = false;
         switch(_loc2_)
         {
            case "c":
               KERNEL.traceToChat(getText("CHALENGE_FULL"),dofus.Constants.ERROR_CHAT_COLOR);
               break;
            case "t":
               KERNEL.traceToChat(getText("TEAM_FULL"),dofus.Constants.ERROR_CHAT_COLOR);
               break;
            case "a":
               KERNEL.traceToChat(getText("TEAM_DIFFERENT_ALIGNMENT"),dofus.Constants.ERROR_CHAT_COLOR);
         }
         break;
      case 904:
         bSequence = false;
         var characDataTo = DATACENTER.Sprites.getItemAt(Number(_loc2_));
         KERNEL.traceToChat(getText("CANT_CHALENGE_B",[characDataTo.name]),dofus.Constants.ERROR_CHAT_COLOR);
         break;
      case 905:
         INTERFACE.Text.setTextTimer(getText("YOU_ARE_ATTAC"),2000,false,true);
         break;
      case 906:
         var characDataFrom = DATACENTER.Sprites.getItemAt(_loc3_);
         var characDataTo = DATACENTER.Sprites.getItemAt(Number(_loc2_));
         if(characDataTo.Alignment < 0)
         {
            KERNEL.traceToChat(getText("A_PUNISH_B",[characDataFrom.name,characDataTo.name]),dofus.Constants.INFO_CHAT_COLOR);
         }
         else
         {
            KERNEL.traceToChat(getText("A_ATTACK_B",[characDataFrom.name,characDataTo.name]),dofus.Constants.INFO_CHAT_COLOR);
         }
         if(Number(_loc2_) == DATACENTER.Player.ID)
         {
            INTERFACE.Text.setTextTimer(getText("YOU_ARE_ATTAC"),2000,false,true);
         }
         break;
      case 999:
         var cmd = _loc2_;
         _loc1_.addAction(false,AKS.DataProcessor,AKS.DataProcessor.process,[cmd]);
   }
   if(!isNaN(Number(idAction)) && _loc3_ == DATACENTER.Player.ID)
   {
      _loc1_.addAction(false,GameActionsManager,GameActionsManager.ack,[idAction]);
   }
   else
   {
      GameActionsManager.end(_loc3_ == DATACENTER.Player.ID);
   }
   if(!_loc1_.isPlaying() && bSequence)
   {
      _loc1_.execute(true);
   }
};
