class dofus.datacenter.Accessory extends Object
{
   var _nUnicID;
   var _oItemText;
   function Accessory(nUnicID)
   {
      super();
      this.initialize(nUnicID);
   }
   function get unicID()
   {
      return this._nUnicID;
   }
   function get type()
   {
      return this._oItemText.t;
   }
   function get gfxID()
   {
      return this._oItemText.g;
   }
   function get gfx()
   {
      return this.type + "_" + this.gfxID;
   }
   function initialize(nUnicID)
   {
      this._nUnicID = nUnicID;
      this._oItemText = _global.getItemUnicText(nUnicID);
   }
}
