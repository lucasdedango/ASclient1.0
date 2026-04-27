AKS.Items.onInventoryFull = function()
{
   GAPI.loadUIComponent("AskOk","AskOkOnConnect",{title:getText("ERROR_WORD"),text:getText("INVENTORY_FULL")});
};
AKS.Items.onTooLowLevel = function()
{
   GAPI.loadUIComponent("AskOk","AskOkOnConnect",{title:getText("ERROR_WORD"),text:getText("TOO_LOW_LEVEL_FOR_ITEM")});
};
AKS.Items.onAlreadyEquiped = function()
{
   GAPI.loadUIComponent("AskOk","AskOkOnConnect",{title:getText("ERROR_WORD"),text:getText("ALREADY_EQUIPED")});
};
AKS.Items.onAccessories = function(characID, aAccessories)
{
   var _loc3_ = characID;
   var _loc2_ = DATACENTER.Sprites.getItemAt(_loc3_);
   _loc2_.Accessories = aAccessories;
   BATTLEFIELD.setForcedSpriteAnim(_loc3_,"static");
   var _loc1_;
   if(_loc3_ == DATACENTER.Player.ID)
   {
      _loc1_ = getItemUnicText(aAccessories[0].unicID);
      DATACENTER.Player.setCCData(_loc1_.a,_loc1_.r,_loc1_.e[0]);
   }
};
AKS.Items.onDrop = function(bError, data)
{
   if(bError)
   {
      if(data === "F")
      {
         GAPI.loadUIComponent("AskOk","AskOkDropFull",{title:getText("ERROR_WORD"),text:getText("DROP_FULL")});
      }
   }
   else
   {
      DATACENTER.Player.dropItem(Number(data));
   }
};
AKS.Items.onRemove = function(data)
{
   DATACENTER.Player.dropItem(Number(data));
};
AKS.Items.onQuantity = function(nId, nQuantity)
{
   DATACENTER.Player.updateItemQuantity(nId,nQuantity);
};
AKS.Items.onMovement = function(nId, nPosition)
{
   DATACENTER.Player.updateItemPosition(nId,nPosition);
};
AKS.Items.onTool = function(nJobID)
{
   if(isNaN(nJobID))
   {
      DATACENTER.Player.currentJobID = undefined;
   }
   else
   {
      DATACENTER.Player.currentJobID = nJobID;
   }
};
AKS.Items.onWeight = function(nCurrentWeight, nMaxWeight)
{
   DATACENTER.Player.maxWeight = nMaxWeight;
   DATACENTER.Player.currentWeight = nCurrentWeight;
};
