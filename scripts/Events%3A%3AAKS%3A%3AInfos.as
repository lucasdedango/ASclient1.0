AKS.Infos.onPlayerCount = function(count)
{
   var _loc1_ = count;
   var _loc2_;
   if(AKS.Infos.output._target != undefined)
   {
      _loc1_ = Number(_loc1_);
      if(Number(_loc1_) > 1)
      {
         _loc2_ = getText("PLAYERS");
      }
      else
      {
         _loc2_ = getText("PLAYER");
      }
      AKS.Infos.output._parent.playerCount_txt.setText(_loc1_ + " " + _loc2_,"Font1");
   }
   else
   {
      KERNEL.traceToChat(getText("PLAYER_CONNECTED",[_loc1_]),dofus.Constants.INFO_CHAT_COLOR);
   }
};
AKS.Infos.onMessage = function(type, messageID, params)
{
   var _loc1_ = params;
   var _loc2_ = messageID;
   var _loc3_;
   switch(Number(type))
   {
      case 0:
         if(!isNaN(Number(_loc2_)))
         {
            switch(Number(_loc2_))
            {
               case 17:
                  _loc1_ = [_loc1_[0],getJobText(_loc1_[1]).n];
                  break;
               case 2:
                  _loc1_ = [getJobText(_loc1_).n];
                  break;
               case 3:
                  _loc1_ = [getSpellText(_loc1_).n];
            }
            _loc3_ = getText("INFOS_" + _loc2_,_loc1_);
         }
         else
         {
            _loc3_ = getText(_loc2_,_loc1_);
         }
         KERNEL.traceToChat(_loc3_,dofus.Constants.INFO_CHAT_COLOR);
         break;
      case 1:
         if(!isNaN(Number(_loc2_)))
         {
            switch(Number(_loc2_))
            {
               case 1:
                  _loc1_ = [getJobText(_loc1_).n];
                  break;
               case 2:
                  _loc1_ = [getSpellText(_loc1_).n];
            }
            _loc3_ = getText("ERROR_" + _loc2_,_loc1_);
         }
         else
         {
            _loc3_ = getText(_loc2_,_loc1_);
         }
         KERNEL.traceToChat(_loc3_,dofus.Constants.ERROR_CHAT_COLOR);
      default:
         return;
   }
};
