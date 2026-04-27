Class_Client_Houses = function(parent)
{
   this._parent = parent;
};
Object.registerClass("Dofus::Client::Houses",Class_Client_Houses);
Class_Client_Houses.prototype.send = function(data, waiting)
{
   this._parent.send(data,waiting);
};
Class_Client_Houses.prototype.kick = function(id)
{
   this.send("hQ" + id + "\n");
};
Class_Client_Houses.prototype.leave = function(id)
{
   this.send("hV\n");
};
Class_Client_Houses.prototype.sell = function(nPrice)
{
   this.send("hS" + nPrice + "\n");
};
Class_Client_Houses.prototype.buy = function(nPrice)
{
   this.send("hB" + nPrice + "\n");
};
Class_Client_Houses.prototype.innerOnList = function(data)
{
   var bAdd = data.charAt(0) == "+";
   var aTmp = data.substring(1).split("|");
   var _loc2_ = 0;
   var _loc1_;
   var _loc3_;
   while(_loc2_ < aTmp.length)
   {
      _loc1_ = aTmp[_loc2_].split(";");
      var nHouseID = _loc1_[0];
      _loc3_ = _loc1_[1] == "1";
      var bForSale = _loc1_[2] == "1";
      this.onHouse(bAdd,nHouseID,_loc3_,bForSale);
      _loc2_ = _loc2_ + 1;
   }
};
Class_Client_Houses.prototype.innerOnProperties = function(data)
{
   var _loc1_ = data.split("|");
   var nHouseID = Number(_loc1_[0]);
   var _loc2_ = _loc1_[1].split(";");
   var _loc3_ = _loc2_[0];
   var bForSale = _loc2_[1] == "1";
   this.onProperties(nHouseID,_loc3_,bForSale);
};
Class_Client_Houses.prototype.innerOnLockedProperty = function(data)
{
   var _loc1_ = data.split("|");
   var _loc3_ = Number(_loc1_[0]);
   var _loc2_ = _loc1_[1] == "1";
   this.onLockedPorperty(_loc3_,_loc2_);
};
Class_Client_Houses.prototype.innerOnCreate = function(data)
{
   var _loc1_ = data.split("|");
   var _loc3_ = Number(_loc1_[0]);
   var nPrice = Number(_loc1_[1]);
   var _loc2_ = DATACENTER.Houses.getItemAt(_loc3_);
   if(_loc2_ == undefined)
   {
      _loc2_ = new dofus.datacenter.House(_loc3_);
   }
   _loc2_.price = nPrice;
   this.onCreate(_loc2_);
};
Class_Client_Houses.prototype.innerOnSell = function(bError, data)
{
   var _loc3_ = data.split("|");
   var nHouseID = Number(_loc3_[0]);
   var _loc2_ = Number(_loc3_[1]);
   var _loc1_ = DATACENTER.Houses.getItemAt(nHouseID);
   if(_loc1_ == undefined)
   {
      _loc1_ = new dofus.datacenter.House(nHouseID);
   }
   _loc1_.isForSale = _loc2_ > 0;
   _loc1_.price = _loc2_;
   if(_loc2_ > 0)
   {
      this.onSell(bError,_loc1_);
   }
   else
   {
      this.onNoSell(_loc1_);
   }
};
Class_Client_Houses.prototype.innerOnBuy = function(bError, data)
{
   var _loc2_;
   var _loc3_;
   var _loc1_;
   if(bError)
   {
      this.onBuyError(data);
   }
   else
   {
      _loc2_ = data.split("|");
      _loc3_ = Number(_loc2_[0]);
      var nPrice = Number(_loc2_[1]);
      _loc1_ = DATACENTER.Houses.getItemAt(_loc3_);
      if(_loc1_ == undefined)
      {
         _loc1_ = new dofus.datacenter.House(_loc3_);
      }
      _loc1_.isForSale = false;
      _loc1_.price = 0;
      this.onBuy(_loc1_);
   }
};
