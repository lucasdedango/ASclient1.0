AKS.Exchange.onCreate = function(error, type, params)
{
   var _loc1_;
   var _loc2_;
   var _loc3_;
   if(!error)
   {
      DATACENTER.GlobalExchangeType = type;
      switch(type)
      {
         case 0:
         case 4:
            var aTmp = params.split(",");
            DATACENTER.Temporary.Shop = new dofus.datacenter.Shop();
            var oNPC = DATACENTER.Sprites.getItemAt(params);
            DATACENTER.Temporary.Shop.name = oNPC.name;
            DATACENTER.Temporary.Shop.gfx = oNPC.GfxID;
            if(type == 0)
            {
               GAPI.loadUIComponent("NpcShop","NpcShop",{data:DATACENTER.Temporary.Shop});
            }
            else
            {
               GAPI.loadUIComponent("PlayerShop","PlayerShop",{data:DATACENTER.Temporary.Shop});
            }
            break;
         case 1:
            var eaInventory = DATACENTER.Player.Inventory;
            var eaInventoryClone = new ank.utils.ExtendedArray();
            _loc1_ = 0;
            while(_loc1_ < eaInventory.length)
            {
               _loc2_ = eaInventory[_loc1_];
               if(_loc2_.Position == -1)
               {
                  _loc3_ = _loc2_.clone();
                  eaInventoryClone.push(_loc3_);
               }
               _loc1_ = _loc1_ + 1;
            }
            DATACENTER.Exchange.inventory = eaInventoryClone;
            GAPI.unloadUIComponent("AskYesNoExchange");
            GAPI.unloadUIComponent("AskCancelExchange");
            GAPI.loadUIComponent("Exchange","Exchange");
            break;
         case 2:
         case 3:
            if(type == 2)
            {
               DATACENTER.Exchange = new dofus.datacenter.Exchange(params);
            }
            else
            {
               DATACENTER.Exchange = new dofus.datacenter.Exchange();
            }
            var eaInventory = DATACENTER.Player.Inventory;
            var eaInventoryClone = new ank.utils.ExtendedArray();
            _loc1_ = 0;
            while(_loc1_ < eaInventory.length)
            {
               _loc2_ = eaInventory[_loc1_];
               if(_loc2_.Position == -1)
               {
                  _loc3_ = _loc2_.clone();
                  eaInventoryClone.push(_loc3_);
               }
               _loc1_ = _loc1_ + 1;
            }
            DATACENTER.Exchange.inventory = eaInventoryClone;
            if(type == 2)
            {
               GAPI.unloadUIComponent("AskYesNoExchange");
               GAPI.unloadUIComponent("AskCancelExchange");
               GAPI.loadUIComponent("Exchange","Exchange");
            }
            else
            {
               GAPI.loadUIComponent("Craft","Craft",{maxItem:params});
            }
            break;
         case 5:
            DATACENTER.Temporary.Storage = new dofus.datacenter.Storage();
            GAPI.loadUIComponent("Storage","Storage",{data:DATACENTER.Temporary.Storage});
            break;
         case 6:
            DATACENTER.Temporary.Shop = new dofus.datacenter.Shop();
            GAPI.loadUIComponent("PlayerShopModifier","PlayerShopModifier",{data:DATACENTER.Temporary.Shop});
         default:
            return;
      }
   }
};
AKS.Exchange.onSell = function(error)
{
   if(!error)
   {
      KERNEL.traceToChat("Vente effectuée",dofus.Constants.INFO_CHAT_COLOR);
      AKS.Exchange.output.hideItemViewer();
   }
   else
   {
      GAPI.loadUIComponent("AskOk","AskOkSell",{title:getText("EXCHANGE"),text:getText("CANT_SELL")});
   }
};
AKS.Exchange.onBuy = function(error)
{
   if(!error)
   {
      KERNEL.traceToChat("Achat effectué",dofus.Constants.INFO_CHAT_COLOR);
      AKS.Exchange.output.hideItemViewer();
   }
   else
   {
      GAPI.loadUIComponent("AskOk","AskOkBuy",{title:getText("EXCHANGE"),text:getText("CANT_BUY")});
   }
};
AKS.Exchange.onRequestError = function(sCodeError)
{
   switch(sCodeError)
   {
      case "O":
         KERNEL.traceToChat(getText("ALREADY_EXCHANGE"),dofus.Constants.ERROR_CHAT_COLOR);
         return;
      case "I":
      default:
         KERNEL.traceToChat(getText("CANT_EXCHANGE"),dofus.Constants.ERROR_CHAT_COLOR);
         return;
   }
};
AKS.Exchange.onRequest = function(nID1, nID2)
{
   var _loc1_ = nID1;
   var nDistantPLayerID = DATACENTER.Player.ID != _loc1_ ? _loc1_ : nID2;
   var s = DATACENTER.Exchange = new dofus.datacenter.Exchange(nDistantPLayerID);
   var _loc2_;
   var _loc3_;
   if(DATACENTER.Player.ID == _loc1_)
   {
      var oCharacData2 = DATACENTER.Sprites.getItemAt(nID2);
      _loc2_ = GAPI.loadUIComponent("AskCancel","AskCancelExchange",{title:getText("EXCHANGE"),text:getText("WAIT_FOR_EXCHANGE",[oCharacData2.name])});
      _loc2_.addEventListener("cancel",this);
   }
   else
   {
      _loc3_ = DATACENTER.Sprites.getItemAt(_loc1_);
      _loc2_ = GAPI.loadUIComponent("AskYesNo","AskYesNoExchange",{title:getText("EXCHANGE"),text:getText("A_WANT_EXCHANGE",[_loc3_.name])});
      _loc2_.addEventListener("yes",this);
      _loc2_.addEventListener("no",this);
   }
};
AKS.Exchange.onLeave = function()
{
   delete DATACENTER.GlobalExchangeType;
   delete DATACENTER.Exchange;
   GAPI.unloadUIComponent("AskYesNoExchange");
   GAPI.unloadUIComponent("AskCancelExchange");
   GAPI.unloadUIComponent("Exchange");
   GAPI.unloadUIComponent("Craft");
   GAPI.unloadUIComponent("NpcShop");
   GAPI.unloadUIComponent("PlayerShop");
   GAPI.unloadUIComponent("PlayerShopModifier");
   GAPI.unloadUIComponent("Storage");
};
AKS.Exchange.onLocalKama = function(nQuantity)
{
   DATACENTER.Exchange.localKama = nQuantity;
};
AKS.Exchange.onLocalMovement = function(bAdd, id, nQuantity)
{
   var _loc3_ = id;
   var oItemFinderOrigin = DATACENTER.Player.Inventory.findFirstItem("ID",_loc3_);
   var _loc1_ = DATACENTER.Exchange.inventory.findFirstItem("ID",_loc3_);
   var _loc2_ = DATACENTER.Exchange.localGarbage.findFirstItem("ID",_loc3_);
   if(bAdd)
   {
      var oInventoryItem = _loc1_.item;
      var oItem = new dofus.datacenter.Item(_loc3_,oInventoryItem.unicID,nQuantity,-2,oInventoryItem.compressedEffects);
      var p = -1;
      var q = oItemFinderOrigin.item.Quantity - nQuantity;
      if(q == 0)
      {
         p = -3;
      }
      _loc1_.item.Quantity = q;
      _loc1_.item.Position = p;
      DATACENTER.Exchange.inventory.updateItem(_loc1_.index,_loc1_.item);
      if(_loc2_.index != -1)
      {
         DATACENTER.Exchange.localGarbage.updateItem(_loc2_.index,oItem);
      }
      else
      {
         DATACENTER.Exchange.localGarbage.push(oItem);
      }
   }
   else if(_loc2_.index != -1)
   {
      _loc1_.item.Position = -1;
      _loc1_.item.Quantity = oItemFinderOrigin.item.Quantity;
      DATACENTER.Exchange.inventory.updateItem(_loc1_.index,_loc1_.item);
      DATACENTER.Exchange.localGarbage.removeItems(_loc2_.index,1);
   }
};
AKS.Exchange.onDistantKama = function(nQuantity)
{
   DATACENTER.Exchange.distantKama = nQuantity;
};
AKS.Exchange.onDistantMovement = function(bAdd, id, nQuantity, nUnicID, sEffects)
{
   var _loc2_ = DATACENTER.Exchange.distantGarbage.findFirstItem("ID",id);
   var _loc3_;
   var _loc1_;
   if(bAdd)
   {
      _loc3_ = new dofus.datacenter.Item(id,nUnicID,nQuantity,-3,sEffects);
      var bInCraft = DATACENTER.Exchange.distantPlayerID == undefined;
      if(bIncraft)
      {
         _loc1_ = DATACENTER.Exchange.inventory.findFirstItem("unicID",nUnicID);
         if(_loc1_.index != -1)
         {
            _loc1_.item.Position = -1;
            _loc1_.item.Quantity = Number(_loc1_.item.Quantity) + Number(nQuantity);
            DATACENTER.Exchange.inventory.updateItem(_loc1_.index,_loc1_.item);
         }
         else
         {
            DATACENTER.Exchange.inventory.push(_loc3_);
         }
      }
      if(_loc2_.index != -1)
      {
         DATACENTER.Exchange.distantGarbage.updateItem(_loc2_.index,_loc3_);
      }
      else
      {
         DATACENTER.Exchange.distantGarbage.push(_loc3_);
      }
   }
   else if(_loc2_.index != -1)
   {
      DATACENTER.Exchange.distantGarbage.removeItems(_loc2_.index,1);
   }
};
AKS.Exchange.onStorageKama = function(nQuantity)
{
   DATACENTER.Temporary.Storage.Kama = Number(nQuantity);
};
AKS.Exchange.onStorageMovement = function(bAdd, id, nQuantity, nUnicID, sEffects)
{
   var _loc3_ = id;
   var _loc1_ = DATACENTER.Temporary.Storage.inventory.findFirstItem("ID",_loc3_);
   var _loc2_;
   if(bAdd)
   {
      _loc2_ = new dofus.datacenter.Item(_loc3_,nUnicID,nQuantity,-1,sEffects);
      if(_loc1_.index != -1)
      {
         trace("update");
         DATACENTER.Temporary.Storage.inventory.updateItem(_loc1_.index,_loc2_);
      }
      else
      {
         trace("add");
         DATACENTER.Temporary.Storage.inventory.push(_loc2_);
      }
   }
   else if(_loc1_.index != -1)
   {
      trace("remove");
      DATACENTER.Temporary.Storage.inventory.removeItems(_loc1_.index,1);
   }
   else
   {
      ank.utils.Logger.err("[onStorageMovement] cet objet n\'existe pas id=" + _loc3_);
   }
};
AKS.Exchange.onPlayerShopMovement = function(bAdd, id, nQuantity, nUnicID, sEffects, nPrice)
{
   var _loc3_ = id;
   var _loc1_ = DATACENTER.Temporary.Shop.inventory.findFirstItem("ID",_loc3_);
   var _loc2_;
   if(bAdd)
   {
      _loc2_ = new dofus.datacenter.Item(_loc3_,nUnicID,nQuantity,-1,sEffects,nPrice);
      if(_loc1_.index != -1)
      {
         DATACENTER.Temporary.Shop.inventory.updateItem(_loc1_.index,_loc2_);
      }
      else
      {
         DATACENTER.Temporary.Shop.inventory.push(_loc2_);
      }
   }
   else if(_loc1_.index != -1)
   {
      DATACENTER.Temporary.Shop.inventory.removeItems(_loc1_.index,1);
   }
   else
   {
      ank.utils.Logger.err("[onPlayerShopMovement] cet objet n\'existe pas id=" + _loc3_);
   }
};
AKS.Exchange.onReady = function(bReady, nPlayerID)
{
   var _loc1_ = nPlayerID != DATACENTER.Player.ID ? 1 : 0;
   DATACENTER.Exchange.readyStates.updateItem(_loc1_,bReady);
};
AKS.Exchange.onCraftImpossible = function()
{
   GAPI.loadUIComponent("AskOk","AskOkCraftImpossible",{title:getText("CRAFT"),text:getText("NO_CRAFT_RESULT")});
};
AKS.Exchange.onCraftFailed = function()
{
   GAPI.loadUIComponent("AskOk","AskOkCraftFailed",{title:getText("CRAFT"),text:getText("CRAFT_FAILED")});
};
AKS.Exchange.yes = function()
{
   AKS.Exchange.accept();
};
AKS.Exchange.no = AKS.Exchange.cancel = function()
{
   AKS.Exchange.leave();
};
