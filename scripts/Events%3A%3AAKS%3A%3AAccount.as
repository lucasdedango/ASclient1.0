AKS.Account.onGetCharacters = function(aSprites, nRemainingTime)
{
   INTERFACE.clear();
   GAPI.unloadUIComponent("CreateCharacter");
   GAPI.loadUIComponent("MainMenu","MainMenu",null,{bStayIfPresent:true,bAlwaysOnTop:true});
   var _loc1_ = GAPI.getUIComponent("ChooseCharacter");
   if(_loc1_ == undefined)
   {
      GAPI.loadUIComponent("ChooseCharacter","ChooseCharacter",{spriteList:aSprites,remainingTime:nRemainingTime});
   }
   else
   {
      _loc1_.spriteList = aSprites;
   }
};
AKS.Account.onSetCharacter = function(success, param1)
{
   if(success)
   {
      GAPI.unloadUIComponent("ChooseCharacter");
      AKS.Game.createSolo();
   }
   else
   {
      this.onError(param1);
   }
};
AKS.Account.onError = function(msg)
{
   GAPI.loadUIComponent("AskOk","AskOkOnError",{title:getText("ERROR"),text:msg});
};
AKS.Account.onWhoAmI = function(playerName, characterName, state)
{
   var _loc1_ = playerName;
   var _loc2_ = characterName;
   switch(state)
   {
      case "1":
         KERNEL.traceToChat(getText("I_AM_IN_SINGLE_GAME",[_loc2_,_loc1_]),dofus.Constants.INFO_CHAT_COLOR);
         return;
      case "2":
         KERNEL.traceToChat(getText("I_AM_IN_GAME",[_loc2_,_loc1_]),dofus.Constants.INFO_CHAT_COLOR);
         return;
      default:
         KERNEL.traceToChat(getText("I_AM_BUT_WHERE",[_loc2_,_loc1_]),dofus.Constants.ERROR_CHAT_COLOR);
         return;
   }
};
AKS.Account.onWhoIs = function(playerName, characterName, state)
{
   var _loc1_ = playerName;
   var _loc2_ = characterName;
   switch(state)
   {
      case "1":
         KERNEL.traceToChat(getText("IS_IN_SINGLE_GAME",[_loc2_,_loc1_]),dofus.Constants.INFO_CHAT_COLOR);
         return;
      case "2":
         KERNEL.traceToChat(getText("IS_IN_GAME",[_loc2_,_loc1_,param]),dofus.Constants.INFO_CHAT_COLOR);
         return;
      default:
         KERNEL.traceToChat(getText("IS_BUT_WHERE",[_loc2_,_loc1_]),dofus.Constants.ERROR_CHAT_COLOR);
         return;
   }
};
AKS.Account.onAddFriend = function(success, name)
{
   if(success)
   {
      KERNEL.traceToChat(getText("ADD_TO_FRIEND_LIST",[name]),dofus.Constants.INFO_CHAT_COLOR);
   }
   else
   {
      switch(name)
      {
         case "f":
            KERNEL.traceToChat(getText("CANT_ADD_FRIEND_NOT_FOUND"),dofus.Constants.ERROR_CHAT_COLOR);
            break;
         case "y":
            KERNEL.traceToChat(getText("CANT_ADD_YOU"),dofus.Constants.ERROR_CHAT_COLOR);
            break;
         case "a":
            KERNEL.traceToChat(getText("ALREADY_YOUR_FRIEND"),dofus.Constants.ERROR_CHAT_COLOR);
            break;
         case "m":
            GAPI.loadUIComponent("AskOk","AskOk",{title:getText("FRIENDS"),text:getText("FRIENDS_LIST_FULL")});
         default:
            return;
      }
   }
};
AKS.Account.onFriendslist = function()
{
   var out = AKS.Account.output;
   var _loc2_ = DATACENTER.Player.Friends;
   var _loc3_ = "";
   var _loc1_;
   if(out._name != undefined)
   {
      out.friendsList = _loc2_;
   }
   else
   {
      if(_loc2_.length != 0)
      {
         KERNEL.traceToChat("<b>" + getText("YOUR_FRIEND_LIST") + " :</b>",dofus.Constants.INFO_CHAT_COLOR);
      }
      else
      {
         KERNEL.traceToChat(getText("EMPTY_FRIEND_LIST"),dofus.Constants.ERROR_CHAT_COLOR);
      }
      _loc1_ = 0;
      while(_loc1_ < _loc2_.length)
      {
         _loc3_ = " - " + _loc2_[_loc1_].account;
         if(_loc2_[_loc1_].state != "DISCONNECT")
         {
            _loc3_ += " (" + _loc2_[_loc1_].name + ") " + getText("LEVEL") + ":" + _loc2_[_loc1_].level + ", " + getText(_loc2_[_loc1_].state);
         }
         KERNEL.traceToChat(_loc3_,dofus.Constants.INFO_CHAT_COLOR);
         _loc1_ = _loc1_ + 1;
      }
   }
};
AKS.Account.onRemoveFriend = function(success, data)
{
   if(success)
   {
      KERNEL.traceToChat(getText("REMOVE_FRIEND_OK"),dofus.Constants.INFO_CHAT_COLOR);
      AKS.Account.getFriendsList();
   }
   else if(data === "f")
   {
      KERNEL.traceToChat(getText("CANT_ADD_FRIEND_NOT_FOUND"),dofus.Constants.ERROR_CHAT_COLOR);
   }
};
AKS.Account.onFirendIn = function(data)
{
   if(AKS.Account.output._name != undefined)
   {
      this.getFriendsList();
   }
   var _loc1_ = data.split(";");
   KERNEL.traceToChat(getText("ENTER_DOFUS",[_loc1_[0],_loc1_[1]]),dofus.Constants.INFO_CHAT_COLOR);
};
AKS.Account.onFirendOut = function(data)
{
   if(AKS.Account.output._name != undefined)
   {
      this.getFriendsList();
   }
   var _loc1_ = data.split(";");
   KERNEL.traceToChat(getText("LEAVE_DOFUS",[_loc1_[0],_loc1_[1]]),dofus.Constants.INFO_CHAT_COLOR);
};
AKS.Account.onFirendsListForRandomGame = function(fArray)
{
   AKS.Game.output.onFriendsList(fArray);
};
AKS.Account.onNewLevel = function(level)
{
   GAPI.loadUIComponent("AskOK","AskOKNewLevel",{title:getText("INFORMATIONS"),text:"vous passez niveau " + level});
};
AKS.Account.onAddCharacter = function(success)
{
   if(!success)
   {
      GAPI.loadUIComponent("AskOk","AskOkAlereadyExist",{title:getText("ERROR_WORD"),text:getText("NAME_ALEREADY_EXISTS")});
   }
};
AKS.Account.onStats = function(statsArray)
{
   var _loc2_ = statsArray;
   var _loc1_ = DATACENTER.Player;
   _loc1_.BonusPoints = _loc2_[20];
   _loc1_.BonusPointsSpell = _loc2_[21];
   _loc1_.XPlow = _loc2_[0];
   _loc1_.XPhigh = _loc2_[2];
   _loc1_.XP = _loc2_[1];
   _loc1_.LP = _loc2_[3];
   _loc1_.LPmax = _loc2_[4];
   _loc1_.data.LP = _loc2_[3];
   _loc1_.data.LPmax = _loc2_[4];
   _loc1_.data.AP = _loc2_[5];
   _loc1_.AP = _loc2_[5];
   _loc1_.data.MP = _loc2_[6];
   _loc1_.MP = _loc2_[6];
   _loc1_.Kama = _loc2_[7];
   _loc1_.Force = _loc2_[8];
   _loc1_.ForceXtra = _loc2_[9];
   _loc1_.Vitality = _loc2_[10];
   _loc1_.VitalityXtra = _loc2_[11];
   _loc1_.Wisdom = _loc2_[12];
   _loc1_.WisdomXtra = _loc2_[13];
   _loc1_.Chance = _loc2_[14];
   _loc1_.ChanceXtra = _loc2_[15];
   _loc1_.Agility = _loc2_[16];
   _loc1_.AgilityXtra = _loc2_[17];
   _loc1_.Intelligence = _loc2_[18];
   _loc1_.IntelligenceXtra = _loc2_[19];
   _loc1_.RangeModerator = _loc2_[22];
   _loc1_.Energy = _loc2_[23];
   _loc1_.data.Alignment = _loc2_[24];
};
