AKS.Chat.onSmiley = function(characID, smileyID)
{
   BATTLEFIELD.addSpriteOverHeadItem(characID,"smiley",dofus.graphics.battlefield.SmileyOverHead,[dofus.Constants.SMILEY_FILE,smileyID],dofus.Constants.SMILEY_DELAY);
};
AKS.Chat.onMessage = function(msg, fromName, fromID, bWhisper)
{
   var _loc3_ = fromName;
   var _loc2_ = false;
   var _loc1_ = "";
   switch(bWhisper)
   {
      case 70:
         _loc2_ = true;
         _loc1_ = getText("FROM",[]) + " ";
         AKS.Console.pushWhisper("/w " + _loc3_ + " ");
         break;
      case 84:
         _loc2_ = true;
         _loc1_ = getText("TO",[]) + " ";
         break;
      case 35:
         if(DATACENTER.Game.isMultiplayer)
         {
            _loc2_ = true;
            _loc1_ = "Equipe ";
         }
   }
   if(_loc2_)
   {
      KERNEL.traceToChat(_loc1_ + "<b>" + _loc3_ + " : " + msg + "</b>",dofus.Constants.MSGCHUCHOTE_CHAT_COLOR,fromID);
   }
   else
   {
      KERNEL.traceToChat(_loc1_ + "<b>" + _loc3_ + "</b> : " + msg,dofus.Constants.MSG_CHAT_COLOR,fromID);
      if(!DATACENTER.Game.isRunning)
      {
         BATTLEFIELD.addSpriteBubble(fromID,msg);
      }
   }
};
AKS.Chat.onError = function(msg)
{
   KERNEL.traceToChat(getText("ERROR",[msg]),dofus.Constants.ERROR_CHAT_COLOR);
};
AKS.Chat.onServerMessage = function(msg)
{
   if(msg != undefined)
   {
      KERNEL.traceToChat(msg,dofus.Constants.INFO_CHAT_COLOR);
   }
};
