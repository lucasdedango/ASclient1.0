Class_Client_Chat = function(parent)
{
   this._parent = parent;
};
Object.registerClass("Dofus::Client::Chat",Class_Client_Chat);
Class_Client_Chat.prototype.onMessage = null;
Class_Client_Chat.prototype.onError = null;
Class_Client_Chat.prototype.send = function(msg, dest)
{
   var _loc1_ = msg;
   if(dest == DATACENTER.Player.name)
   {
      KERNEL.traceToChat(getText("CANT_WISP_YOURSELF"),dofus.Constants.ERROR_CHAT_COLOR);
   }
   else
   {
      _loc1_ = _loc1_.replace(["<",">","|"],["&lt;","&gt;"," "]);
      this._parent.send("BM" + dest + "|" + _loc1_ + "\n");
   }
};
Class_Client_Chat.prototype.smiley = function(smileyID)
{
   var _loc1_ = this;
   if(getTimer() - _loc1_.lastActionTime >= dofus.Constants.CLICK_MIN_DELAY)
   {
      _loc1_.lastActionTime = getTimer();
      _loc1_._parent.send("BS" + smileyID + "\n");
   }
};
Class_Client_Chat.prototype.innerOnSmiley = function(data)
{
   var _loc1_ = data.split("|");
   var _loc3_ = _loc1_[0];
   var _loc2_ = _loc1_[1];
   this.onSmiley(_loc3_,_loc2_);
};
