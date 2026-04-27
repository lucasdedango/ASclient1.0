Class_Chat = function()
{
   var _loc1_ = this;
   _loc1_.TYPE_MESSAGES = 3;
   _loc1_.TYPE_WISP = 4;
   _loc1_.TYPE_INFOS = 1;
   _loc1_.TYPE_ERRORS = 2;
   _loc1_.MAX_LENGTH = 100;
   _loc1_.MAX_VISIBLE = 50;
   _loc1_.EMPTY_ZONE_LENGTH = 31;
   _loc1_.STOP_SCROLL_LENGTH = 6;
   _loc1_.init();
};
Object.registerClass("Dofus::Chat",Class_Chat);
Class_Chat.prototype.init = function()
{
   this.clear();
   this.setTypes(true,true,true,true);
};
Class_Chat.prototype.clear = function()
{
   this.All = new Array();
};
Class_Chat.prototype.setTypes = function(bType1, bType2, bType3, bType4)
{
   var _loc1_ = this;
   if(bType1 != undefined)
   {
      _loc1_.bType1 = bType1;
   }
   if(bType2 != undefined)
   {
      _loc1_.bType2 = bType2;
   }
   if(bType3 != undefined)
   {
      _loc1_.bType3 = bType3;
   }
   if(bType4 != undefined)
   {
      _loc1_.bType4 = bType4;
   }
   _loc1_.refresh();
};
Class_Chat.prototype.addText = function(text, col)
{
   var _loc1_ = this;
   var index;
   var type;
   switch(col)
   {
      case dofus.Constants.MSG_CHAT_COLOR:
         type = _loc1_.TYPE_MESSAGES;
         break;
      case dofus.Constants.MSGCHUCHOTE_CHAT_COLOR:
         type = _loc1_.TYPE_WISP;
         SOMA.onChatWisper();
         break;
      case dofus.Constants.INFO_CHAT_COLOR:
         type = _loc1_.TYPE_INFOS;
         break;
      case dofus.Constants.ERROR_CHAT_COLOR:
         type = _loc1_.TYPE_ERRORS;
         SOMA.onError();
         break;
      default:
         ank.utils.Logger.err("[Chat] Erreur : mauvaise couleur " + text);
         return;
   }
   _loc1_.All.push({text:text,type:type,col:col});
   if(_loc1_.All.length > _loc1_.MAX_LENGTH)
   {
      _loc1_.All.shift();
   }
   _loc1_.refresh();
};
Class_Chat.prototype.refresh = function()
{
   var _loc3_ = this;
   var _loc1_;
   var len = _loc3_.All.length;
   var tmpContainer = new String();
   var _loc2_;
   var out = AKS.Chat.output._txtChat;
   var count = 0;
   _loc1_ = len - 1;
   while(count < _loc3_.MAX_VISIBLE && _loc1_ >= 0)
   {
      _loc2_ = _loc3_.All[_loc1_];
      if(_loc3_["bType" + _loc2_.type])
      {
         count++;
         tmpContainer = "<br><font color=\"#" + _loc2_.col + "\">" + _loc2_.text + "</font>" + tmpContainer;
      }
      _loc1_ = _loc1_ - 1;
   }
   out.text = tmpContainer;
};
