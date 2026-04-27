class dofus.datacenter.Exchange extends Object
{
   var _eaDistantGarbage;
   var _eaInventory;
   var _eaLocalGarbage;
   var _eaReadyStates;
   var _nDistantPlayerID;
   var _nLocalKama = 0;
   var _nDistantKama = 0;
   function Exchange(nDistantPlayerID)
   {
      super();
      this.initialize(nDistantPlayerID);
   }
   function set inventory(eaInventory)
   {
      this._eaInventory = eaInventory;
   }
   function get inventory()
   {
      return this._eaInventory;
   }
   function get localGarbage()
   {
      return this._eaLocalGarbage;
   }
   function get distantGarbage()
   {
      return this._eaDistantGarbage;
   }
   function get readyStates()
   {
      return this._eaReadyStates;
   }
   function get distantPlayerID()
   {
      return this._nDistantPlayerID;
   }
   function set localKama(nLocalKama)
   {
      var _loc1_ = this;
      _loc1_._nLocalKama = nLocalKama;
      _loc1_.dispatchEvent({type:"localKamaChange",value:nLocalKama});
   }
   function get localKama()
   {
      return this._nLocalKama;
   }
   function set distantKama(nDistantKama)
   {
      var _loc1_ = this;
      _loc1_._nDistantKama = nDistantKama;
      _loc1_.dispatchEvent({type:"distantKamaChange",value:nDistantKama});
   }
   function get distantKama()
   {
      return this._nDistantKama;
   }
   function initialize(nDistantPlayerID)
   {
      var _loc1_ = this;
      mx.events.EventDispatcher.initialize(_loc1_);
      _loc1_._nDistantPlayerID = nDistantPlayerID;
      _loc1_._eaLocalGarbage = new ank.utils.ExtendedArray();
      _loc1_._eaDistantGarbage = new ank.utils.ExtendedArray();
      _loc1_._eaReadyStates = new ank.utils.ExtendedArray();
      _loc1_._eaReadyStates[0] = false;
      _loc1_._eaReadyStates[1] = false;
   }
   function clearLocalGarbage()
   {
      this._eaLocalGarbage.removeAll();
   }
   function clearDistantGarbage()
   {
      this._eaDistantGarbage.removeAll();
   }
}
