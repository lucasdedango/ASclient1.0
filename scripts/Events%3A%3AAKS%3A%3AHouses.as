AKS.Houses.onHouse = function(bAdd, nHouseID, bLocked, bForSale)
{
   var _loc1_ = nHouseID;
   var _loc2_ = DATACENTER.Houses;
   var _loc3_;
   if(bAdd)
   {
      var oHouse = _loc2_.getItemAt(_loc1_);
      if(oHouse == undefined)
      {
         var oHouse = new dofus.datacenter.House(_loc1_);
      }
      oHouse.localOwner = bAdd;
      oHouse.isLocked = bLocked;
      oHouse.isForSale = bForSale;
      _loc2_.addItemAt(_loc1_,oHouse);
   }
   else
   {
      var oHouse = _loc2_.getItemAt(_loc1_);
      oHouse.localOwner = false;
      _loc3_ = _global.getHousesMapText(DATACENTER.Map.id);
      if(_loc3_ == _loc1_)
      {
         GAPI.unloadUIComponent("HouseIndoor");
      }
   }
};
AKS.Houses.onProperties = function(nHouseID, sOwnerName, bForSale)
{
   var _loc2_ = nHouseID;
   var _loc1_ = DATACENTER.Houses.getItemAt(_loc2_);
   if(_loc1_ == undefined)
   {
      _loc1_ = new dofus.datacenter.House(_loc2_);
      DATACENTER.Houses.addItemAt(_loc2_,_loc1_);
   }
   _loc1_.ownerName = sOwnerName;
   _loc1_.isForSale = bForSale;
};
AKS.Houses.onLockedPorperty = function(nHouseID, bLocked)
{
   var _loc2_ = nHouseID;
   var _loc1_ = DATACENTER.Houses.getItemAt(_loc2_);
   if(_loc1_ == undefined)
   {
      _loc1_ = new dofus.datacenter.House(_loc2_);
      DATACENTER.Houses.addItemAt(_loc2_,_loc1_);
   }
   _loc1_.isLocked = bLocked;
};
AKS.Houses.onCreate = function(oHouse)
{
   GAPI.loadUIComponent("HouseSale","HouseSale",{house:oHouse});
};
AKS.Houses.onLeave = function()
{
   GAPI.unloadUIComponent("HouseSale");
};
AKS.Houses.onSell = function(bError, oHouse)
{
   if(!bError)
   {
      gapi.loadUIComponent("AskOk","AskOkSellHouse",{title:getText("INFORMATIONS"),text:getText("HOUSE_SELL",[oHouse.name,oHouse.price])});
   }
   else
   {
      gapi.loadUIComponent("AskOk","AskOkSellHouse",{title:getText("ERROR_WORD"),text:"impossible de mettre en vente"});
   }
};
AKS.Houses.onNoSell = function(oHouse)
{
   gapi.loadUIComponent("AskOk","AskOkNoSellHouse",{title:getText("INFORMATIONS"),text:getText("HOUSE_NOSELL",[oHouse.name])});
};
AKS.Houses.onBuy = function(oHouse)
{
   gapi.loadUIComponent("AskOk","AskOkBuyHouse",{title:getText("INFORMATIONS"),text:getText("HOUSE_BUY",[oHouse.name,oHouse.price])});
};
AKS.Houses.onBuyError = function(data)
{
   if(data.charAt(0) === "C")
   {
      gapi.loadUIComponent("AskOk","AskOkBuyHouse",{title:getText("ERROR_WORD"),text:getText("CANT_BUY_HOUSE",[data.substr(1)])});
   }
};
