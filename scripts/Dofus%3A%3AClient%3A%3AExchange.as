Class_Client_Exchange = function(parent)
{
   this._parent = parent;
};
Object.registerClass("Dofus::Client::Exchange",Class_Client_Exchange);
Class_Client_Exchange.prototype.send = function(data, waiting)
{
   this._parent.send(data,waiting);
};
Class_Client_Exchange.prototype.leave = function()
{
   this.send("EV\n",false);
};
Class_Client_Exchange.prototype.request = function(type, id, cellNum)
{
   var _loc1_ = id;
   if(_loc1_ == undefined)
   {
      _loc1_ = "";
   }
   this.send("ER" + type + _loc1_ + (cellNum != undefined ? "|" + cellNum : "") + "\n",true);
};
Class_Client_Exchange.prototype.shop = function(id)
{
   this.send("Es" + id + "\n",true);
};
Class_Client_Exchange.prototype.accept = function()
{
   this.send("EA\n",false);
};
Class_Client_Exchange.prototype.ready = function()
{
   this.send("EK\n",false);
};
Class_Client_Exchange.prototype.movementItem = function(bAdd, id, quantity, price)
{
   this.send("EMO" + (!bAdd ? "-" : "+") + id + "|" + quantity + (price != undefined ? "|" + price : "") + "\n",false);
};
Class_Client_Exchange.prototype.movementKama = function(quantity)
{
   this.send("EMG" + quantity + "\n",false);
};
Class_Client_Exchange.prototype.sell = function(id, quantity)
{
   this.send("ES" + id + "|" + quantity + "\n",true);
};
Class_Client_Exchange.prototype.buy = function(id, quantity)
{
   this.send("EB" + id + "|" + quantity + "\n",true);
};
Class_CLient_Exchange.prototype.offlineExchange = function()
{
   this.send("EQ\n",false);
};
Class_Client_Exchange.prototype.innerOnCreate = function(error, data)
{
   var _loc1_ = data.split("|");
   var _loc2_ = Number(_loc1_[0]);
   var _loc3_ = _loc1_[1];
   this.onCreate(error,_loc2_,_loc3_);
};
Class_Client_Exchange.prototype.innerOnList = function(data)
{
   var _loc2_;
   var _loc1_;
   var _loc3_;
   switch(DATACENTER.GlobalExchangeType)
   {
      case 0:
         var aTmp = data.split("|");
         var eaTmp = new ank.utils.ExtendedArray();
         for(var k in aTmp)
         {
            var o = new dofus.datacenter.Item(0,aTmp[k]);
            o.PriceMultiplicator = getConfigText("BUY_PRICE_MULTIPLICATOR");
            eaTmp.push(o);
         }
         break;
         DATACENTER.Temporary.Shop.inventory = eaTmp;
      case 5:
         _loc2_ = data.split(";");
         var eaTmp = new ank.utils.ExtendedArray();
         for(var k in _loc2_)
         {
            switch(_loc2_[k].charAt(0))
            {
               case "O":
                  var o = KERNEL.CharactersManager.getItemObjectFromData(_loc2_[k].substr(1));
                  eaTmp.push(o);
                  break;
               case "G":
                  this.onStorageKama(_loc2_[k].substr(1));
            }
         }
         break;
         DATACENTER.Temporary.Storage.inventory = eaTmp;
      case 4:
      case 6:
         var aTmp = data.split("|");
         var eaTmp = new ank.utils.ExtendedArray();
         for(var k in aTmp)
         {
            _loc1_ = aTmp[k].split(";");
            var nID = Number(_loc1_[0]);
            var nQuantity = Number(_loc1_[1]);
            var nUnicID = Number(_loc1_[2]);
            var sEffects = _loc1_[3];
            _loc3_ = Number(_loc1_[4]);
            var oItem = new dofus.datacenter.Item(nID,nUnicID,nQuantity,-1,sEffects,_loc3_);
            eaTmp.push(oItem);
         }
         DATACENTER.Temporary.Shop.inventory = eaTmp;
      default:
         return;
   }
};
Class_Client_Exchange.prototype.innerOnSell = function(bError, data)
{
   this.onSell(bError);
};
Class_Client_Exchange.prototype.innerOnBuy = function(bError, data)
{
   this.onBuy(bError);
};
Class_Client_Exchange.prototype.innerOnRequest = function(bError, data)
{
   var _loc1_;
   var _loc3_;
   var _loc2_;
   if(bError)
   {
      this.onRequestError(data);
   }
   else
   {
      _loc1_ = data.split("|");
      _loc3_ = _loc1_[0];
      _loc2_ = _loc1_[1];
      this.onRequest(_loc3_,_loc2_);
   }
};
Class_Client_Exchange.prototype.innerOnReady = function(data)
{
   var _loc1_ = data.charAt(0) == "1";
   var _loc2_ = Number(data.substr(1));
   this.onReady(_loc1_,_loc2_);
};
Class_Client_Exchange.prototype.innerOnLeave = function(bError, data)
{
   this.onLeave();
};
Class_Client_Exchange.prototype.innerOnLocalMovement = function(bError, data)
{
   var _loc2_ = data;
   var sType = _loc2_.charAt(0);
   var _loc3_;
   var _loc1_;
   switch(sType)
   {
      case "O":
         _loc3_ = _loc2_.charAt(1) == "+";
         _loc1_ = _loc2_.substr(2).split("|");
         this.onLocalMovement(_loc3_,_loc1_[0],_loc1_[1],_loc1_[2],_loc1_[3]);
         break;
      case "G":
         this.onLocalKama(_loc2_.substr(1));
      default:
         return;
   }
};
Class_Client_Exchange.prototype.innerOnDistantMovement = function(bError, data)
{
   var _loc2_ = data;
   var sType = _loc2_.charAt(0);
   var _loc3_;
   var _loc1_;
   switch(sType)
   {
      case "O":
         _loc3_ = _loc2_.charAt(1) == "+";
         _loc1_ = _loc2_.substr(2).split("|");
         this.onDistantMovement(_loc3_,_loc1_[0],_loc1_[1],_loc1_[2],_loc1_[3]);
         break;
      case "G":
         this.onDistantKama(_loc2_.substr(1));
      default:
         return;
   }
};
Class_Client_Exchange.prototype.innerOnCraft = function(bError, data)
{
   if(bError)
   {
      switch(data)
      {
         case "I":
            this.onCraftImpossible();
            break;
         case "F":
            this.onCraftFailed();
         default:
            return;
      }
   }
};
Class_Client_Exchange.prototype.innerOnStorageMovement = function(bError, data)
{
   var _loc2_ = data;
   var sType = _loc2_.charAt(0);
   var _loc3_;
   var _loc1_;
   switch(sType)
   {
      case "O":
         _loc3_ = _loc2_.charAt(1) == "+";
         _loc1_ = _loc2_.substr(2).split("|");
         this.onStorageMovement(_loc3_,_loc1_[0],_loc1_[1],_loc1_[2],_loc1_[3]);
         break;
      case "G":
         this.onStorageKama(_loc2_.substr(1));
      default:
         return;
   }
};
Class_Client_Exchange.prototype.innerOnPlayerShopMovement = function(bError, data)
{
   var bAdd = data.charAt(0) == "+";
   var _loc1_ = data.substr(1).split("|");
   var nID = Number(_loc1_[0]);
   var _loc3_ = Number(_loc1_[1]);
   var nUnicID = Number(_loc1_[2]);
   var sEffects = _loc1_[3];
   var _loc2_ = Number(_loc1_[4]);
   this.onPlayerShopMovement(bAdd,nID,_loc3_,nUnicID,sEffects,_loc2_);
};
