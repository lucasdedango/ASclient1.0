Class_Client_Key = function(parent)
{
   this._parent = parent;
};
Object.registerClass("Dofus::Client::Key",Class_Client_Key);
Class_Client_Key.prototype.send = function(data, waiting)
{
   this._parent.send(data,waiting);
};
Class_Client_Key.prototype.leave = function()
{
   this.send("KV\n",false);
};
Class_Client_Key.prototype.sendKey = function(nType, sKeyCode)
{
   this.send("KK" + nType + "|" + sKeyCode + "\n");
};
Class_Client_Key.prototype.innerOnCreate = function(data)
{
   var _loc1_ = data.split("|");
   var _loc3_ = Number(_loc1_[0]);
   var _loc2_ = Number(_loc1_[1]);
   this.onCreate(_loc3_,_loc2_);
};
Class_Client_Key.prototype.innerOnKey = function(error)
{
   this.onKey(error);
};
