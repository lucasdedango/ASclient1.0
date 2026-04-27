Class_Client_Storages = function(parent)
{
   this._parent = parent;
};
Object.registerClass("Dofus::Client::Storages",Class_Client_Storages);
Class_Client_Storages.prototype.send = function(data, waiting)
{
   this._parent.send(data,waiting);
};
Class_Client_Storages.prototype.innerOnList = function(data)
{
   var bAdd = data.charAt(0) == "+";
   var aTmp = data.substring(1).split("|");
   var _loc1_ = 0;
   var _loc2_;
   var _loc3_;
   while(_loc1_ < aTmp.length)
   {
      _loc2_ = aTmp[_loc1_].split(";");
      var sStorageID = _loc2_[0];
      _loc3_ = _loc2_[1] == "1";
      this.onStorage(bAdd,sStorageID,_loc3_);
      _loc1_ = _loc1_ + 1;
   }
};
Class_Client_Storages.prototype.innerOnLockedProperty = function(data)
{
   var _loc1_ = data.split("|");
   var _loc3_ = _loc1_[0];
   var _loc2_ = _loc1_[1] == "1";
   this.onLockedPorperty(_loc3_,_loc2_);
};
