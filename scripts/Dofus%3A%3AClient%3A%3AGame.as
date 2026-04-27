Class_Client_Game = function(parent)
{
   var _loc1_ = this;
   _loc1_._parent = parent;
   _loc1_.m_bInGame = false;
   _loc1_.STATE_UNKNOWN = 0;
   _loc1_.STATE_SOLO = 1;
   _loc1_.STATE_FREE = 2;
   _loc1_.STATE_RANDOM_TEAM = 3;
   _loc1_.m_MapsList = null;
   _loc1_.m_state = _loc1_.STATE_UNKNOWN;
};
Object.registerClass("Dofus::Client::Game",Class_Client_Game);
Class_Client_Game.prototype.onList = null;
Class_Client_Game.prototype.onCreate = null;
Class_Client_Game.prototype.onJoin = null;
Class_Client_Game.prototype.onMovement = null;
Class_Client_Game.prototype.onMapsList = null;
Class_Client_Game.prototype.onChangeTeam = null;
Class_Client_Game.prototype.send = function(data, bWaiting)
{
   this._parent.send(data,bWaiting);
};
Class_Client_Game.prototype.getList = function(gameType)
{
   this.send("GL" + gameType + "\n");
};
Class_Client_Game.prototype.createFree = function(gameName, gameType, gameMap, gameOptions, gamePassword)
{
   gameType = 2;
   this.send("GC" + gameType + gameName + "|" + gameMap + "|" + gameOptions + "|" + gamePassword + "\n");
};
Class_Client_Game.prototype.createSolo = function()
{
   this.send("GC" + this.STATE_SOLO + "\n");
};
Class_Client_Game.prototype.createRandom = function()
{
   if(!DATACENTER.Game.isRandom)
   {
      this.send("GC" + this.STATE_RANDOM_TEAM + "\n");
   }
};
Class_Client_Game.prototype.invite = function(characID)
{
   this.send("Gi" + characID + "\n",false);
};
Class_Client_Game.prototype.refuseInvite = function(characID)
{
   this.send("GY" + characID + "\n",false);
};
Class_Client_Game.prototype.getMapsList = function()
{
   this.send("BL\n");
};
Class_Client_Game.prototype.getMapData = function(nMapID)
{
   this.send("GD" + (nMapID == undefined ? "\n" : nMapID + "\n"));
};
Class_Client_Game.prototype.GetPlayersCoordinate = function()
{
   this.send("Gc\n");
};
Class_Client_Game.prototype.join = function(gameType, gameName, gamePassword)
{
   this.send("GJ" + gameType + gameName + "|" + gamePassword + "\n");
};
Class_Client_Game.prototype.getExtraInformations = function()
{
   this.send("GI\n");
};
Class_Client_Game.prototype.start = function()
{
   if(DATACENTER.Game.isFull)
   {
      this.send("GS\n");
   }
};
Class_Client_Game.prototype.ready = function(bool)
{
   this.send("GR" + (!bool ? "0" : "1") + "\n");
};
Class_Client_Game.prototype.setPlayerPosition = function(cell)
{
   this.send("Gp" + cell + "\n");
};
Class_Client_Game.prototype.sendActions = function(actionType, params)
{
   this.send("GA" + String(actionType).getAddLeftChar("0",3) + params.join(";") + "\n");
};
Class_Client_Game.prototype.leave = function(characID)
{
   this.send("GQ" + (characID != undefined ? characID : "") + "\n");
};
Class_Client_Game.prototype.invitationUndo = function(characID)
{
   this.send("GU" + characID + "\n");
};
Class_Client_Game.prototype.ActionAck = function(idAction)
{
   this.send("GKK" + idAction + "\n",false);
   KERNEL.GameActionsManager.end();
};
Class_Client_Game.prototype.ActionCancel = function(idAction, param)
{
   this.send("GKE" + idAction + "|" + param + "\n",false);
};
Class_Client_Game.prototype.turnEnd = function()
{
   if(DATACENTER.Player.isCurrentPlayer)
   {
      this.send("Gt\n",false);
   }
};
Class_Client_Game.prototype.turnOk = function(nID)
{
   this.send("GT" + nID + "\n",false);
};
Class_Client_Game.prototype.challenge = function(id)
{
   this.sendActions(900,id);
};
Class_Client_Game.prototype.acceptChallenge = function(id)
{
   this.sendActions(901,id);
};
Class_Client_Game.prototype.refuseChallenge = function(id)
{
   this.sendActions(902,id);
};
Class_Client_Game.prototype.joinChallenge = function(challengeID, id)
{
   this.sendActions(903,[challengeID,id]);
};
Class_Client_Game.prototype.attack = function(id)
{
   this.sendActions(906,id);
};
Class_Client_Game.prototype.sendPeace = function()
{
   this.send("BP\n",false);
};
Class_Client_Game.prototype.innerOnCreate = function(success, name, state, params)
{
   var _loc1_ = this;
   var _loc2_ = success;
   var _loc3_ = state;
   DATACENTER.Game = new Class_Datacenter_Game();
   DATACENTER.Player.data.initAP(false);
   DATACENTER.Player.data.initMP(false);
   DATACENTER.Player.SpellsManager.clear();
   DATACENTER.Player.data.CharacteristicsManager.initialize();
   DATACENTER.Player.data.EffectsManager.initialize();
   BATTLEFIELD.cleanMap(1);
   switch(Number(_loc3_))
   {
      case _loc1_.STATE_SOLO:
         DATACENTER.Game.state = _loc3_;
         DATACENTER.Game.currentPlayerID = DATACENTER.Player.ID;
         _loc1_.onCreateSolo(_loc2_,params);
         return;
      case _loc1_.STATE_FREE:
      case _loc1_.STATE_RANDOM_TEAM:
         _loc1_.innerOnJoin(_loc2_,name,_loc3_,params,true);
         return;
      default:
         if(!_loc2_)
         {
            _loc1_.onCreateMulti(false,params);
            return;
         }
         return;
   }
};
Class_Client_Game.prototype.innerOnJoin = function(success, data)
{
   var _loc1_ = data.split("|");
   var _loc2_ = _loc1_[0];
   var bCanBeCanceled = _loc1_[1] != "0" ? true : false;
   var _loc3_ = Number(_loc1_[2]);
   DATACENTER.Game = new Class_Datacenter_Game();
   DATACENTER.Game.state = _loc2_;
   DATACENTER.Player.data.initAP(false);
   DATACENTER.Player.data.initMP(false);
   DATACENTER.Player.SpellsManager.init();
   BATTLEFIELD.cleanMap(1);
   if(!success)
   {
      this.onJoin(false);
   }
   else
   {
      this.onJoin(true,_loc2_,bCanBeCanceled,_loc3_);
   }
};
Class_Client_Game.prototype.innerOnMovement = function(data)
{
   var dataArray = data.split("|");
   var len = dataArray.length;
   var i = 0;
   var _loc1_;
   var _loc3_;
   var _loc2_;
   while(i < len)
   {
      var str = dataArray[i];
      if(str.length == 0)
      {
         break;
      }
      if(str.charAt(0) == "+")
      {
         _loc1_ = str.substring(1).split(";");
         var c;
         var bAdd = true;
         if(_loc1_[0] == 0)
         {
            c = {num:0};
         }
         else
         {
            var sCellNum = _loc1_[0];
            var sDir = _loc1_[1];
            var sID = _loc1_[2];
            var sName = _loc1_[3];
            _loc3_ = _loc1_[4];
            var sGfx = _loc1_[5];
            switch(_loc3_)
            {
               case "-1":
                  _loc2_ = new Object();
                  _loc2_.spriteType = _loc3_;
                  _loc2_.gfxID = sGfx;
                  _loc2_.cell = sCellNum;
                  _loc2_.dir = sDir;
                  _loc2_.level = _loc1_[6];
                  if(DATACENTER.Game.isMultiplayer)
                  {
                     _loc2_.LP = _loc1_[7];
                     _loc2_.AP = _loc1_[8];
                     _loc2_.MP = _loc1_[9];
                     _loc2_.team = _loc1_[10];
                  }
                  var c = KERNEL.CharactersManager.createCreature(sID,sName,_loc2_);
                  break;
               case "-2":
                  _loc2_ = new Object();
                  _loc2_.spriteType = _loc3_;
                  _loc2_.gfxID = sGfx;
                  _loc2_.cell = sCellNum;
                  _loc2_.dir = sDir;
                  _loc2_.level = _loc1_[6];
                  if(DATACENTER.Game.isMultiplayer)
                  {
                     _loc2_.LP = _loc1_[7];
                     _loc2_.AP = _loc1_[8];
                     _loc2_.MP = _loc1_[9];
                     _loc2_.team = _loc1_[10];
                  }
                  var c = KERNEL.CharactersManager.createMonster(sID,sName,_loc2_);
                  break;
               case "-3":
                  _loc2_ = new Object();
                  _loc2_.spriteType = _loc3_;
                  _loc2_.level = _loc1_[6];
                  _loc2_.gfxID = sGfx;
                  _loc2_.cell = sCellNum;
                  _loc2_.dir = sDir;
                  var c = KERNEL.CharactersManager.createMonsterGroup(sID,sName,_loc2_);
                  break;
               case "-4":
                  _loc2_ = new Object();
                  _loc2_.spriteType = _loc3_;
                  _loc2_.gfxID = sGfx;
                  _loc2_.cell = sCellNum;
                  _loc2_.dir = sDir;
                  _loc2_.sex = _loc1_[6];
                  var c = KERNEL.CharactersManager.createNonPlayableCharacter(sID,sName,_loc2_);
                  break;
               case "-5":
                  _loc2_ = new Object();
                  _loc2_.spriteType = _loc3_;
                  _loc2_.gfxID = sGfx;
                  _loc2_.cell = sCellNum;
                  _loc2_.dir = sDir;
                  _loc2_.color1 = _loc1_[6];
                  _loc2_.color2 = _loc1_[7];
                  _loc2_.color3 = _loc1_[8];
                  _loc2_.accessories = _loc1_[9];
                  var c = KERNEL.CharactersManager.createOfflineCharacter(sID,sName,_loc2_);
                  break;
               default:
                  _loc2_ = new Object();
                  _loc2_.spriteType = _loc3_;
                  _loc2_.gfxID = sGfx;
                  _loc2_.cell = sCellNum;
                  _loc2_.dir = sDir;
                  _loc2_.sex = _loc1_[6];
                  if(DATACENTER.Game.isMultiplayer)
                  {
                     _loc2_.level = _loc1_[7];
                     _loc2_.alignment = _loc1_[8];
                     _loc2_.color1 = _loc1_[9];
                     _loc2_.color2 = _loc1_[10];
                     _loc2_.color3 = _loc1_[11];
                     _loc2_.accessories = _loc1_[12];
                     _loc2_.LP = _loc1_[13];
                     _loc2_.AP = _loc1_[14];
                     _loc2_.MP = _loc1_[15];
                     _loc2_.team = _loc1_[16];
                  }
                  else
                  {
                     _loc2_.alignment = _loc1_[7];
                     _loc2_.color1 = _loc1_[8];
                     _loc2_.color2 = _loc1_[9];
                     _loc2_.color3 = _loc1_[10];
                     _loc2_.accessories = _loc1_[11];
                  }
                  var c = KERNEL.CharactersManager.createCharacter(sID,sName,_loc2_);
            }
         }
         this.onMovement(bAdd,c);
      }
      else
      {
         var bAdd = false;
         var pID = dataArray[0].substring(1);
         var c;
         if(pID == 0)
         {
            c = {num:0};
         }
         else
         {
            c = DATACENTER.Sprites.getItemAt(pID);
         }
         this.onMovement(bAdd,c);
      }
      i++;
   }
};
Class_Client_Game.prototype.innerOnMapsList = function(list)
{
   var _loc1_ = this;
   _loc1_.m_MapsList = list.split("|");
   _loc1_.onMapsList(_loc1_.m_MapsList);
};
Class_Client_Game.prototype.innerOnMapData = function(data)
{
   var _loc1_ = data.split("|");
   var _loc2_ = _loc1_[1];
   var _loc3_ = _loc1_[2];
   this.onMapData(_loc2_,_loc3_);
};
Class_Client_Game.prototype.innerOnCellData = function(data)
{
   var dataArray = data.split("|");
   var _loc2_ = 0;
   var _loc1_;
   var _loc3_;
   while(_loc2_ < dataArray.length)
   {
      _loc1_ = dataArray[_loc2_].split(";");
      _loc3_ = Number(_loc1_[0]);
      var compressData = _loc1_[1].substring(0,10);
      var mask = _loc1_[1].substring(10);
      var bPermanante = _loc1_[2] != "1" ? false : true;
      this.onCellData(_loc3_,compressData,mask,bPermanante);
      _loc2_ = _loc2_ + 1;
   }
};
Class_Client_Game.prototype.innerOnMapInformations = function(data)
{
   var _loc1_ = data.split("|");
   var state = Number(_loc1_[1]);
   DATACENTER.Game.m_maxPlayerCount = _loc1_[4].charCodeAt(0) - 64 + (_loc1_[4].charCodeAt(1) - 64);
   this.onMapInformations({gameName:_loc1_[2],gameMap:_loc1_[3],gameOptions:_loc1_[4]});
};
Class_Client_Game.prototype.innerOnActions = function(data)
{
   var _loc1_ = data;
   var _loc2_;
   _loc1_ = _loc1_.substr(2);
   _loc2_ = _loc1_.indexOf(";");
   var actionID = _loc1_.substring(0,_loc2_);
   _loc1_ = _loc1_.substring(_loc2_ + 1);
   _loc2_ = _loc1_.indexOf(";");
   var actionType = _loc1_.substring(0,_loc2_);
   _loc1_ = _loc1_.substring(_loc2_ + 1);
   _loc2_ = _loc1_.indexOf(";");
   var _loc3_ = _loc1_.substring(0,_loc2_);
   var params = _loc1_.substring(_loc2_ + 1);
   this.onActions(actionID,actionType,_loc3_,params);
};
Class_Client_Game.prototype.innerOnPlayersCoordinates = function(data)
{
   var _loc2_ = data.split("|");
   var updatedData = new Array();
   var _loc3_;
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.length)
   {
      _loc3_ = _loc2_[_loc1_].split(";");
      updatedData.push(_loc3_);
      _loc1_ = _loc1_ + 1;
   }
   this.onPlayersCoordinates(updatedData);
};
Class_Client_Game.prototype.innerOnPlayersInformations = function(data)
{
   var Players = data.split("|");
   var _loc1_;
   var _loc2_ = 0;
   var _loc3_;
   while(_loc2_ < Players.length)
   {
      _loc1_ = Players[_loc2_].split(";");
      var ID = _loc1_[0];
      _loc3_ = _loc1_[1];
      var Guild = _loc1_[2];
      var Color1 = _loc1_[3];
      var Color2 = _loc1_[4];
      var Color3 = _loc1_[5];
      var LP = _loc1_[6];
      var AP = _loc1_[7];
      var GP = _loc1_[8];
      var team = _loc1_[11];
      KERNEL.CharactersManager.createCharacter(ID,_loc3_,Guild,Color1,Color2,Color3,LP,AP,GP);
      _loc2_ = _loc2_ + 1;
   }
};
Class_Client_Game.prototype.innerOnPositionStart = function(codeSubAction, data)
{
   this.onPositionStart(data);
};
Class_Client_Game.prototype.innerOnTurnStart = function(data)
{
   var _loc1_ = data.split("|");
   this.onTurnStart(_loc1_[0],Number(_loc1_[1]) / 1000);
};
Class_Client_Game.prototype.innerOnTurnFinish = function(characID)
{
   this.onTurnFinish(characID);
};
Class_Client_Game.prototype.innerOnTurnlist = function(characIDList)
{
   DATACENTER.Game.turnSequence = characIDList.split("|");
   this.onTurnList();
};
Class_Client_Game.prototype.innerOnChangeTeam = function(bool, playerID, team)
{
   var _loc1_;
   var _loc2_;
   if(bool)
   {
      _loc1_ = DATACENTER.Characters.getItemAt(playerID);
      _loc1_.team = Number(team);
      _loc2_ = AKS.Game.output.players["player" + _loc1_.joinPosition];
      this.onChangeTeam(true,_loc2_,team);
   }
   else
   {
      this.onChangeTeam(false);
   }
};
Class_Client_Game.prototype.innerOnEnd = function(data)
{
   var aTmp = data.split("|");
   var idSender = Number(aTmp.shift(0));
   DATACENTER.Game.Results = new Object();
   DATACENTER.Game.Results.winners = new ank.utils.ExtendedArray();
   DATACENTER.Game.Results.loosers = new ank.utils.ExtendedArray();
   var i = 0;
   var _loc2_;
   var _loc1_;
   var _loc3_;
   while(i < aTmp.length)
   {
      _loc2_ = aTmp[i].split(";");
      var bWinner = _loc2_[0] != "2" ? false : true;
      _loc1_ = new Object();
      _loc1_.id = Number(_loc2_[1]);
      _loc1_.name = _loc1_.id <= 0 ? getMonstersText(Number(_loc2_[2])) : _loc2_[2];
      _loc1_.level = Number(_loc2_[3]);
      _loc1_.bDead = _loc2_[4] != "1" ? false : true;
      _loc1_.minxp = Number(_loc2_[5]);
      _loc1_.xp = Number(_loc2_[6]);
      _loc1_.maxxp = Number(_loc2_[7]);
      _loc1_.winxp = Number(_loc2_[8]);
      var aItems = _loc2_[9].split(",");
      var nLen = aItems.length;
      _loc1_.items = new Array();
      while(--nLen >= 0)
      {
         _loc3_ = Number(aItems[nLen]);
         if(_loc3_ == undefined)
         {
            break;
         }
         var oItem = new dofus.datacenter.Item(0,_loc3_,1);
         _loc1_.items.push(oItem);
      }
      _loc1_.kama = _loc2_[10];
      if(bWinner)
      {
         DATACENTER.Game.Results.winners.push(_loc1_);
      }
      else
      {
         DATACENTER.Game.Results.loosers.push(_loc1_);
      }
      i++;
   }
   this.onEnd(idSender);
};
Class_Client_Game.prototype.innerOnInvitationDemandRejected = function(data)
{
   var why = data.substring(0,1);
   var _loc1_ = data.substr(1).split("|");
   var _loc2_ = _loc1_[1];
   var _loc3_ = _loc1_[0];
   this.onInvitationRejected(why,_loc3_,_loc2_);
};
Class_Client_Game.prototype.innerOnInvitationResponse = function(data)
{
   var _loc1_ = data.split("|");
   var _loc2_ = _loc1_[0];
   var _loc3_ = _loc1_[1];
   this.onInvitation(_loc2_,_loc3_);
};
Class_Client_Game.prototype.innerOnEffect = function(data)
{
   var characData;
   var _loc1_ = data.split(";");
   var players = _loc1_[1].split(",");
   var len = players.length;
   var _loc2_;
   var playerID;
   var _loc3_;
   _loc2_ = 0;
   while(_loc2_ < len)
   {
      _loc3_ = new dofus.datacenter.Effect(_loc1_[0],_loc1_[2],_loc1_[3],_loc1_[4],_loc1_[5],_loc1_[6],_loc1_[7]);
      playerID = Number(players[_loc2_]);
      characData = DATACENTER.Sprites.getItemAt(playerID);
      characData.EffectsManager.addEffect(_loc3_);
      _loc2_ = _loc2_ + 1;
   }
};
Class_Client_Game.prototype.innerOnZoneData = function(data)
{
   var splitArray = data.split("|");
   var _loc2_ = 0;
   var _loc3_;
   var _loc1_;
   while(_loc2_ < splitArray.length)
   {
      _loc3_ = splitArray[_loc2_];
      var bAdd = _loc3_.substring(0,1) != "+" ? false : true;
      _loc1_ = _loc3_.substring(1).split(";");
      this.onZoneData(bAdd,_loc1_[0],_loc1_[1],_loc1_[2]);
      _loc2_ = _loc2_ + 1;
   }
};
Class_Client_Game.prototype.innerOnChallenge = function(data)
{
   var bAdd = data.charAt(0) == "+";
   var dataArray = data.substr(1).split("|");
   var challengeID = Number(dataArray[0]);
   var col = (Math.cos(challengeID) + 1) * 8388607;
   dataArray.shift();
   var _loc2_;
   var _loc1_;
   var _loc3_;
   if(bAdd)
   {
      var cd = new dofus.datacenter.Challenge(challengeID);
      DATACENTER.Challenges.addItemAt(challengeID,cd);
      _loc2_ = 0;
      while(_loc2_ < dataArray.length)
      {
         var team = dataArray[_loc2_];
         _loc1_ = team.split(";");
         _loc3_ = Number(_loc1_[0]);
         var cellNum = _loc1_[1];
         var alignment = _loc1_[2];
         switch(alignment)
         {
            case "1":
               var gfxFile = dofus.Constants.CHALLENGE_CLIP_FILE_ANGEL;
               break;
            case "2":
               var gfxFile = dofus.Constants.CHALLENGE_CLIP_FILE_DEMON;
               break;
            default:
               var gfxFile = dofus.Constants.CHALLENGE_CLIP_FILE_NORMAL;
         }
         if(_loc3_ < 0)
         {
            var gfxFile = dofus.Constants.CHALLENGE_CLIP_FILE_MONSTER;
         }
         var t = new dofus.datacenter.Team(_loc3_,ank.battlefield.mc.Sprite,gfxFile,cellNum,col,alignment);
         cd.addTeam(t);
         this.onChallenge(true,t);
         _loc2_ = _loc2_ + 1;
      }
   }
   else
   {
      var teams = DATACENTER.Challenges.getItemAt(challengeID).teams;
      for(var k in teams)
      {
         var t = teams[k];
         this.onChallenge(false,t);
      }
      DATACENTER.Challenges.removeItemAt(challengeID);
   }
};
Class_Client_Game.prototype.innerOnTeam = function(data)
{
   var dataArray = data.split("|");
   var teamID = Number(dataArray[0]);
   var td = DATACENTER.Sprites.getItemAt(teamID);
   dataArray.shift();
   var _loc3_ = 0;
   var _loc1_;
   var _loc2_;
   while(_loc3_ < dataArray.length)
   {
      _loc1_ = dataArray[_loc3_].split(";");
      var bAdd = _loc1_[0].charAt(0) == "+";
      if(bAdd)
      {
         _loc2_ = new Object();
         _loc2_.id = Number(_loc1_[0].substr(1));
         _loc2_.name = isNaN(Number(_loc1_[1])) ? _loc1_[1] : getMonstersText(_loc1_[1]);
         _loc2_.level = Number(_loc1_[2]);
         td.addPlayer(_loc2_);
      }
      else
      {
         td.removePlayer(_loc1_[0].substr(1));
      }
      _loc3_ = _loc3_ + 1;
   }
};
Class_Client_Game.prototype.onInnerReady = function(data)
{
   var _loc1_ = data.charAt(0) == "1";
   var _loc2_ = Number(data.substr(1));
   this.onReady(_loc1_,_loc2_);
};
Class_Client_Game.prototype.innerOnCellObject = function(data)
{
   var bNew = data.charAt(0) == "+";
   var aTmp = data.substr(1).split("|");
   var _loc1_ = 0;
   var _loc2_;
   var _loc3_;
   while(_loc1_ < aTmp.length)
   {
      _loc2_ = aTmp[_loc1_].split(";");
      _loc3_ = Number(_loc2_[0]);
      var itemUnicID = Number(_loc2_[1]);
      this.onCellObject(bNew,_loc3_,itemUnicID);
      _loc1_ = _loc1_ + 1;
   }
};
Class_Client_Game.prototype.innerOnFrameObject2 = function(data)
{
   var aTmp = data.split("|");
   var _loc2_ = 0;
   var _loc3_;
   var _loc1_;
   while(_loc2_ < aTmp.length)
   {
      var aTmp2 = aTmp[_loc2_].split(";");
      _loc3_ = aTmp2[0];
      _loc1_ = aTmp2[1];
      BATTLEFIELD.setObject2Interactive(_loc3_,_loc1_ == "1" || _loc1_ == "4",2);
      BATTLEFIELD.setObject2Frame(_loc3_,_loc1_);
      _loc2_ = _loc2_ + 1;
   }
};
Class_Client_Game.prototype.innerOnTurnReady = function(data)
{
   this.onTurnReady(data);
};
Class_Client_Game.prototype.innerOnTurnMiddle = function(data)
{
   var _loc2_;
   var _loc1_;
   var _loc3_;
   if(!DATACENTER.Game.isRunning)
   {
      ank.utils.Logger.err("[innerOnTurnMiddle] on est pas en combat");
   }
   else
   {
      var aTmp = data.split("|");
      _loc2_ = 0;
      while(_loc2_ < aTmp.length)
      {
         _loc1_ = aTmp[_loc2_].split(";");
         if(_loc1_.length != 0)
         {
            var nId = Number(_loc1_[0]);
            var bDied = _loc1_[1] != "1" ? false : true;
            var nLP = Number(_loc1_[2]);
            _loc3_ = Number(_loc1_[3]);
            var nMP = Number(_loc1_[4]);
            var nCellNum = Number(_loc1_[5]);
            var nDir = Number(_loc1_[6]);
            this.onTurnMiddle(nId,bDied,nLP,_loc3_,nMP,nCellNum,nDir);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
};
Class_Client_Game.prototype.innerOnActionsFinish = function(data)
{
   var _loc1_ = data.split("|");
   var _loc2_ = Number(_loc1_[0]);
   var _loc3_ = Number(_loc1_[1]);
   this.onActionsFinish(_loc3_,_loc2_);
};
