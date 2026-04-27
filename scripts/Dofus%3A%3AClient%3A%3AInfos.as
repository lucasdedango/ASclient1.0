Class_Client_Infos = function(parent)
{
   this._parent = parent;
};
Object.registerClass("Dofus::Client::infos",Class_Client_Infos);
Class_Client_Infos.prototype.onPlayerCout = null;
Class_Client_Infos.prototype.send = function(data, bWaiting)
{
   this._parent.send(data,bWaiting);
};
Class_Client_Infos.prototype.getInfos = function()
{
   this.send("IC\n");
};
Class_Client_Infos.prototype.getMaps = function()
{
   this.send("IM\n");
};
Class_Client_Infos.prototype.getGeneral = function()
{
   this.send("IG\n");
};
Class_Client_Infos.prototype.innerOnPlayerCount = function(data)
{
   this.onPlayerCount(data);
};
Class_Client_Infos.prototype.innerOnInfoMaps = function(data)
{
   var _loc1_ = data.split("|");
   DATACENTER.Player.worldPosition = {area:Number(_loc1_[0]),x:Number(_loc1_[1]),y:Number(_loc1_[2])};
};
Class_Client_Infos.prototype.innerOnMessage = function(data)
{
   var _loc1_ = data.split("|");
   this.onMessage(_loc1_[0],_loc1_[1],_loc1_[2].split(";"));
};
