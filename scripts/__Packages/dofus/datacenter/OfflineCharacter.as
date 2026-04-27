class dofus.datacenter.OfflineCharacter extends ank.battlefield.datacenter.Sprite
{
   var __proto__;
   var _gfxID;
   var _sName;
   function OfflineCharacter(id, clipClass, gfxFile, cellNum, dir, gfxID)
   {
      super();
      if(this.__proto__ == dofus.datacenter.OfflineCharacter.prototype)
      {
         this.initialize(id,clipClass,gfxFile,cellNum,dir,gfxID);
      }
   }
   function set name(sName)
   {
      this._sName = sName;
   }
   function get name()
   {
      return this._sName;
   }
   function get gfxID()
   {
      return this._gfxID;
   }
   function set gfxID(value)
   {
      this._gfxID = value;
   }
   function initialize(id, clipClass, gfxFile, cellNum, dir, gfxID)
   {
      super.initialize(id,clipClass,gfxFile,cellNum,dir);
      this._gfxID = gfxID;
   }
}
