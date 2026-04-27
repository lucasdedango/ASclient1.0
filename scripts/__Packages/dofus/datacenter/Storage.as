class dofus.datacenter.Storage extends Object
{
   var _eaInventory;
   var _nKamas;
   var _bLocalOwner = false;
   var _bLocked = false;
   function Storage()
   {
      super();
      this.initialize();
   }
   function set localOwner(bLocalOwner)
   {
      this._bLocalOwner = bLocalOwner;
   }
   function get localOwner()
   {
      return this._bLocalOwner;
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
   function set inventory(eaInventory)
   {
      var _loc1_ = this;
      _loc1_._eaInventory = eaInventory;
      _loc1_.dispatchEvent({type:"modelChanged"});
   }
   function get inventory()
   {
      return this._eaInventory;
   }
   function set Kama(nKamas)
   {
      var _loc1_ = this;
      _loc1_._nKamas = nKamas;
      _loc1_.dispatchEvent({type:"kamaChanged",value:nKamas});
   }
   function get Kama()
   {
      return this._nKamas;
   }
   function initialize()
   {
      mx.events.EventDispatcher.initialize(this);
   }
}
