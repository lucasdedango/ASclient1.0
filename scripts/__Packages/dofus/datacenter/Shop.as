class dofus.datacenter.Shop extends Object
{
   var _eaInventory;
   var _sGfx;
   var _sName;
   function Shop()
   {
      super();
   }
   function Storage()
   {
      this.initialize();
   }
   function set name(sName)
   {
      this._sName = sName;
   }
   function get name()
   {
      return this._sName;
   }
   function set gfx(sGfx)
   {
      this._sGfx = sGfx;
   }
   function get gfx()
   {
      return this._sGfx;
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
   function initialize()
   {
      mx.events.EventDispatcher.initialize(this);
   }
}
