Class_Client_DataProcessor = function(parent)
{
   this._parent = parent;
};
Object.registerClass("Dofus::Client::DataProcessor",Class_Client_DataProcessor);
Class_Client_DataProcessor.prototype.process = function(data)
{
   var _loc1_ = this;
   var _loc2_ = data;
   ank.utils.Logger.log(">> " + _loc2_);
   INTERFACE.MainLayer_mc.waiting.close();
   GAPI.unloadUIComponent("Waiting");
   var codeRubrique = _loc2_.charCodeAt(0);
   var codeAction = _loc2_.charCodeAt(1);
   if(_loc2_.charCodeAt(2) == 75)
   {
      codeErreur = false;
   }
   else
   {
      codeErreur = true;
   }
   var msg;
   var i;
   var _loc3_;
   loop1:
   switch(codeRubrique)
   {
      case 72:
         _loc1_._parent.m_UID = _loc2_.substr(1);
         _loc1_._parent.m_bConnected = true;
         _loc1_._parent.onConnect(true);
         break;
      case 112:
         _loc1_._parent.onPong();
         break;
      case 77:
         _loc1_._parent.m_serverMessageID = _loc2_.substr(2);
         _loc1_._parent.onServerMessage(_loc2_.substring(1,2),_loc2_.substr(2));
         break;
      case 66:
         switch(codeAction)
         {
            case 65:
               KERNEL.traceToChat(getText("UNKNOW_COMMAND",["/a"]),dofus.Constants.ERROR_CHAT_COLOR);
               break;
            case 84:
               if(NIGHTMANAGER == undefined)
               {
                  var oTz = getTimeZoneText();
                  _global.NIGHTMANAGER = new dofus.managers.NightManager(oTz.mspd,oTz.hpd,oTz.tz,BATTLEFIELD);
               }
               NIGHTMANAGER.setReferenceTime(Number(_loc2_.substr(2)));
         }
         break;
      case 73:
         switch(codeAction)
         {
            case 67:
               _loc1_._parent.Infos.innerOnPlayerCount(_loc2_.substr(2));
               break;
            case 77:
               _loc1_._parent.Infos.innerOnInfoMaps(_loc2_.substr(2));
               break;
            case 109:
               _loc1_._parent.Infos.innerOnMessage(_loc2_.substr(2));
         }
         break;
      case 83:
         switch(codeAction)
         {
            case 73:
               _loc1_._parent.Spells.innerOnInfos(_loc2_.substr(2));
               break;
            case 77:
               _loc1_._parent.Spells.innerOnMovement(_loc2_);
               break;
            case 85:
               if(!codeErreur)
               {
                  _loc1_._parent.Spells.innerOnUpgradeSpell(_loc2_.substr(3));
               }
         }
         break;
      case 65:
         switch(codeAction)
         {
            case 108:
               if(!codeErreur)
               {
                  _loc1_._parent.m_bAuthentified = true;
                  _loc1_._parent.onLogin(true,null,_loc2_.substr(3));
               }
               else
               {
                  errNumber = _loc2_.charCodeAt(3);
                  switch(errNumber)
                  {
                     case 97:
                        var msg = getText("ALREADY_LOGGED");
                        break;
                     case 118:
                        var msg = getText("BAD_VERSION",[dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + dofus.Constants.BETAVERSION,_loc2_.substr(4) + dofus.Constants.BETAVERSION]);
                        _loc1_._parent.onBadVersion();
                        break;
                     case 112:
                        var msg = getText("NOT_PLAYER");
                        break;
                     default:
                        var msg = getText("ACCESS_DENIED");
                  }
                  _loc1_._parent.onLogin(false,msg,codeErreur);
               }
               break;
            case 87:
               var whoisData = _loc2_.substr(2).split("|");
               var __characterName;
               var __playerName;
               var __state;
               var __param;
               if(whoisData.length == 2)
               {
                  _loc1_._parent.Account.onWhoIs(whoisData[1],"!",null);
                  break;
               }
               if(whoisData.length != 3)
               {
                  trace("Infos Whois Erronées");
                  break;
               }
               __playerName = whoisData[0];
               __state = whoisData[1];
               __characterName = whoisData[2];
               if(__playerName == _loc1_._parent.m_login)
               {
                  _loc1_._parent.Account.onWhoAmI(__playerName,__characterName,__state);
               }
               else
               {
                  _loc1_._parent.Account.onWhoIs(__playerName,__characterName,__state);
               }
               break;
            case 76:
               if(codeErreur)
               {
                  break;
               }
               var aSpritesList = new Array();
               var aTmp = _loc2_.substr(3).split("|");
               var nRemainingTime = Number(aTmp[0]);
               trace(nRemainingTime);
               i = 1;
               while(i < aTmp.length)
               {
                  _loc3_ = aTmp[i].split(";");
                  var oData = new Object();
                  var nID = Number(_loc3_[0]);
                  var sName = _loc3_[1];
                  oData.level = _loc3_[2];
                  oData.gfxID = _loc3_[3];
                  oData.color1 = _loc3_[4];
                  oData.color2 = _loc3_[5];
                  oData.color3 = _loc3_[6];
                  oData.accessories = _loc3_[7];
                  oData.merchant = _loc3_[8];
                  oData.died = _loc3_[9];
                  var oSprite = KERNEL.CharactersManager.createCharacter(nID,sName,oData);
                  aSpritesList.push(oSprite);
                  i++;
               }
               _loc1_._parent.Account.onGetCharacters(aSpritesList,nRemainingTime);
               break;
            case 83:
               if(!codeErreur)
               {
                  var dataArray = _loc2_.split("|");
                  _loc1_._parent.Account.isSet = false;
                  var c = new Object();
                  c.level = dataArray[3];
                  c.guild = dataArray[4];
                  c.sex = dataArray[5];
                  c.gfxID = dataArray[6];
                  c.color1 = dataArray[7];
                  c.color2 = dataArray[8];
                  c.color3 = dataArray[9];
                  c.cc = dataArray[10];
                  c.spells = dataArray[11];
                  c.items = dataArray[12];
                  KERNEL.CharactersManager.setLocalPlayerData(dataArray[1],dataArray[2],c);
                  _loc1_.onStats(dataArray.slice(11,25));
                  _loc1_._parent.Account.onSetCharacter(true,"");
               }
               else
               {
                  _loc1_._parent.Account.onSetCharacter(false,"Erreur lors de la sélection du personnage");
               }
               break;
            case 78:
               _loc1_._parent.Account.innerOnNewLevel(_loc2_.substr(2));
               break;
            case 66:
               _loc1_._parent.Account.innerOnBoost(_loc2_.substr(3));
               break;
            case 65:
               _loc1_._parent.Account.onAddCharacter(!codeErreur);
               break;
            case 115:
               _loc1_._parent.Account.innerOnStats(_loc2_.substr(2));
         }
         break;
      case 71:
         switch(codeAction)
         {
            case 67:
               var dataArray = _loc2_.split("|");
               if(codeErreur)
               {
                  _loc1_._parent.Game.innerOnCreate(false,null,null,_loc2_.charAt(3));
               }
               else
               {
                  DATACENTER.Channel.m_name = null;
                  var __name;
                  var __state;
                  var __params;
                  __state = Number(dataArray[1]);
                  __name = dataArray[2];
                  __params = dataArray.slice(3,dataArray.length);
                  _loc1_._parent.Game.innerOnCreate(true,__name,__state,__params);
               }
               break;
            case 74:
               if(codeErreur)
               {
                  _loc1_._parent.Game.innerOnJoin(false);
               }
               else
               {
                  _loc1_._parent.Game.innerOnJoin(true,_loc2_.substr(3));
               }
               break;
            case 69:
               _loc1_._parent.Game.innerOnEnd(_loc2_.substr(2));
               break;
            case 73:
               switch(_loc2_.charCodeAt(2))
               {
                  case 80:
                     _loc1_._parent.Game.innerOnPlayersInformations(_loc2_.substring(4,_loc2_.length));
                     break;
                  case 67:
                     _loc1_._parent.Game.innerOnPlayersCoordinates(_loc2_.substring(4,_loc2_.length));
                     break;
                  case 69:
                     _loc1_._parent.Game.innerOnEffect(_loc2_.substr(3));
               }
               break;
            case 77:
               _loc1_._parent.Game.innerOnMovement(_loc2_.substring(3));
               break;
            case 99:
               _loc1_._parent.Game.innerOnChallenge(_loc2_.substring(2));
               break;
            case 116:
               _loc1_._parent.Game.innerOnTeam(_loc2_.substring(2));
               break;
            case 86:
               _loc1_._parent.Game.onLeave();
               break;
            case 68:
               switch(_loc2_.charCodeAt(2))
               {
                  case 75:
                     _loc1_._parent.Game.onMapLoaded();
                     break;
                  case 77:
                     _loc1_._parent.Game.innerOnMapData(_loc2_);
                     break;
                  case 67:
                     _loc1_._parent.Game.innerOnCellData(_loc2_.substr(3));
                     break;
                  case 90:
                     _loc1_._parent.Game.innerOnZoneData(_loc2_.substring(3));
                     break;
                  case 79:
                     _loc1_._parent.Game.innerOnCellObject(_loc2_.substring(3));
                     break;
                  case 70:
                     _loc1_._parent.Game.innerOnFrameObject2(_loc2_.substring(4));
               }
               break;
            case 65:
               switch(_loc2_.charCodeAt(2))
               {
                  case 83:
                     _loc1_._parent.Game.onActionsStart(_loc2_.substr(3));
                     break;
                  case 70:
                     _loc1_._parent.Game.innerOnActionsFinish(_loc2_.substr(3));
                     break;
                  default:
                     _loc1_._parent.Game.innerOnActions(_loc2_);
               }
               break;
            case 80:
               _loc1_._parent.Game.innerOnPositionStart(_loc2_.charCodeAt(2),_loc2_.substr(2).split("|"));
               break;
            case 82:
               _loc1_._parent.Game.onInnerReady(_loc2_.substr(2));
               break;
            case 83:
               _loc1_._parent.Game.onStartToPlay();
               break;
            case 115:
               _loc1_._parent.Game.onStartSearch();
               break;
            case 84:
               switch(_loc2_.charCodeAt(2))
               {
                  case 83:
                     _loc1_._parent.Game.innerOnTurnStart(_loc2_.substr(3));
                     break;
                  case 70:
                     _loc1_._parent.Game.innerOnTurnFinish(_loc2_.substr(3));
                     break;
                  case 76:
                     _loc1_._parent.Game.innerOnTurnlist(_loc2_.substr(4));
                     break;
                  case 77:
                     _loc1_._parent.Game.innerOnTurnMiddle(_loc2_.substr(4));
                     break;
                  case 82:
                     _loc1_._parent.Game.innerOnTurnReady(_loc2_.substr(3));
               }
         }
         break;
      case 99:
         switch(codeAction)
         {
            case 77:
               if(!codeErreur)
               {
                  var msgData = _loc2_.split("|");
                  _loc1_._parent.Chat.onMessage(msgData[3],msgData[2],msgData[1],_loc2_.charCodeAt(3));
                  break loop1;
               }
               errNumber = _loc2_.charCodeAt(3);
               switch(errNumber)
               {
                  case 83:
                     _loc1_._parent.Chat.onError(getText("SYNTAX_ERROR",[" /w <" + getText("NAME",[]) + "> <" + getText("MSG",[]) + ">"]));
                     break;
                  case 102:
                     _loc1_._parent.Chat.onError(getText("USER_NOT_CONNECTED",[_loc2_.substring(4)]));
               }
               break loop1;
            case 83:
               _loc1_._parent.Chat.innerOnSmiley(_loc2_.substr(2));
               break loop1;
            case 115:
               _loc1_._parent.Chat.onServerMessage(_loc2_.substr(2));
               break loop1;
            default:
               break loop1;
         }
      case 70:
         break;
      case 79:
         switch(codeAction)
         {
            case 97:
               _loc1_._parent.Items.innerOnAccessories(_loc2_.substr(2));
               break;
            case 68:
               _loc1_._parent.Items.innerOnDrop(codeErreur,_loc2_.substr(3));
               break;
            case 65:
               _loc1_._parent.Items.innerOnAdd(codeErreur,_loc2_.substr(3));
               break;
            case 82:
               _loc1_._parent.Items.innerOnRemove(_loc2_.substr(2));
               break;
            case 81:
               _loc1_._parent.Items.innerOnQuantity(_loc2_.substr(2));
               break;
            case 77:
               _loc1_._parent.Items.innerOnMovement(_loc2_.substr(2));
               break;
            case 84:
               _loc1_._parent.Items.innerOnTool(_loc2_.substr(2));
               break;
            case 119:
               _loc1_._parent.Items.innerOnWeight(_loc2_.substr(2));
         }
         break;
      case 69:
         switch(codeAction)
         {
            case 82:
               _loc1_._parent.Exchange.innerOnRequest(codeErreur,_loc2_.substr(3));
               break;
            case 75:
               _loc1_._parent.Exchange.innerOnReady(_loc2_.substr(2));
               break;
            case 86:
               _loc1_._parent.Exchange.innerOnLeave(codeErreur,_loc2_.substr(3));
               break;
            case 67:
               _loc1_._parent.Exchange.innerOnCreate(codeErreur,_loc2_.substr(3));
               break;
            case 99:
               _loc1_._parent.Exchange.innerOnCraft(codeErreur,_loc2_.substr(3));
               break;
            case 77:
               _loc1_._parent.Exchange.innerOnLocalMovement(codeErreur,_loc2_.substr(3));
               break;
            case 109:
               _loc1_._parent.Exchange.innerOnDistantMovement(codeErreur,_loc2_.substr(3));
               break;
            case 115:
               _loc1_._parent.Exchange.innerOnStorageMovement(codeErreur,_loc2_.substr(3));
               break;
            case 105:
               _loc1_._parent.Exchange.innerOnPlayerShopMovement(codeErreur,_loc2_.substr(3));
               break;
            case 76:
               _loc1_._parent.Exchange.innerOnList(_loc2_.substr(2));
               break;
            case 83:
               _loc1_._parent.Exchange.innerOnSell(codeErreur,_loc2_.substr(3));
               break;
            case 66:
               _loc1_._parent.Exchange.innerOnBuy(codeErreur,_loc2_.substr(3));
         }
         break;
      case 74:
         switch(codeAction)
         {
            case 83:
               _loc1_._parent.Job.innerOnSkills(_loc2_.substr(3));
               break;
            case 88:
               _loc1_._parent.Job.innerOnXP(_loc2_.substr(3));
               break;
            case 78:
               _loc1_._parent.Job.innerOnLevel(_loc2_.substr(2));
         }
         break;
      case 68:
         switch(codeAction)
         {
            case 67:
               _loc1_._parent.Dialog.innerOnCreate(codeErreur,_loc2_.substr(3));
               break;
            case 81:
               _loc1_._parent.Dialog.innerOnQuestion(_loc2_.substr(2));
               break;
            case 86:
               _loc1_._parent.Dialog.onLeave();
         }
         break;
      case 75:
         switch(codeAction)
         {
            case 67:
               _loc1_._parent.Key.innerOnCreate(_loc2_.substr(3));
               break;
            case 75:
               _loc1_._parent.Key.innerOnKey(codeErreur);
               break;
            case 86:
               _loc1_._parent.Key.onLeave();
         }
         break;
      case 104:
         switch(codeAction)
         {
            case 76:
               _loc1_._parent.Houses.innerOnList(_loc2_.substr(2));
               break;
            case 80:
               _loc1_._parent.Houses.innerOnProperties(_loc2_.substr(2));
               break;
            case 88:
               _loc1_._parent.Houses.innerOnLockedProperty(_loc2_.substr(2));
               break;
            case 67:
               _loc1_._parent.Houses.innerOnCreate(_loc2_.substr(3));
               break;
            case 83:
               _loc1_._parent.Houses.innerOnSell(codeErreur,_loc2_.substr(3));
               break;
            case 66:
               _loc1_._parent.Houses.innerOnBuy(codeErreur,_loc2_.substr(3));
               break;
            case 86:
               _loc1_._parent.Houses.onLeave();
         }
         break;
      case 115:
         switch(codeAction)
         {
            case 76:
               _loc1_._parent.Storages.innerOnList(_loc2_.substr(2));
               break;
            case 88:
               _loc1_._parent.Storages.innerOnLockedProperty(_loc2_.substr(2));
         }
      default:
         return;
   }
   switch(codeAction)
   {
      case 65:
         if(codeErreur)
         {
            _loc1_._parent.Account.innerOnAddFirend(false,_loc2_.substr(3),false);
         }
         else
         {
            _loc1_._parent.Account.innerOnAddFirend(true,_loc2_.substr(3),false);
         }
         break;
      case 68:
         if(codeErreur)
         {
            _loc1_._parent.Account.onRemoveFriend(false,_loc2_.substr(3));
         }
         else
         {
            _loc1_._parent.Account.onRemoveFriend(true);
         }
         break;
      case 76:
         _loc1_._parent.Account.innerOnFirendsList(_loc2_.substr(3));
         break;
      case 73:
         _loc1_._parent.Account.onFirendIn(_loc2_.substr(2));
         break;
      case 79:
         _loc1_._parent.Account.onFirendOut(_loc2_.substr(2));
   }
};
