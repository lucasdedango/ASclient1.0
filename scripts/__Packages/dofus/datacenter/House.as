class dofus.datacenter.House extends Object
{
   var _nID;
   var _nPrice;
   var _sDescription;
   var _sName;
   var _bLocalOwner = false;
   var _sOwnerName = new String();
   var _bForSale = false;
   var _bLocked = false;
   function House(nID)
   {
      super();
      this.initialize(nID);
   }
   function get id()
   {
      return this._nID;
   }
   function get name()
   {
      return this._sName;
   }
   function get description()
   {
      return this._sDescription;
   }
   function set price(nPrice)
   {
      this._nPrice = Number(nPrice);
   }
   function get price()
   {
      return this._nPrice;
   }
   function set localOwner(bLocalOwner)
   {
      this._bLocalOwner = bLocalOwner;
   }
   function get localOwner()
   {
      return this._bLocalOwner;
   }
   function set ownerName(sOwnerName)
   {
      this._sOwnerName = sOwnerName;
   }
   function get ownerName()
   {
      var _loc1_ = this;
      if(typeof _loc1_._sOwnerName == "string")
      {
         if(_loc1_._sOwnerName.length > 0)
         {
            return _loc1_._sOwnerName;
         }
      }
   }
   function set isForSale(bForSale)
   {
      var _loc1_ = this;
      _loc1_._bForSale = bForSale;
      _loc1_.dispatchEvent({type:"forsale",value:bForSale});
   }
   function get isForSale()
   {
      return this._bForSale;
   }
   function set isLocked(bLocked)
   {
      var _loc1_ = this;
      _loc1_._bLocked = bLocked;
      _loc1_.dispatchEvent({type:"locked",value:bLocked});
   }
   function get isLocked()
   {
      return this._bLocked;
   }
   function initialize(nID)
   {
      var _loc1_ = this;
      mx.events.EventDispatcher.initialize(_loc1_);
      _loc1_._nID = nID;
      _loc1_._sName = _global.getHouseText(nID).n;
      _loc1_._sDescription = _global.getHouseText(_loc1_._nID).d;
   }
}
