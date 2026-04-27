class dofus.datacenter.Creature extends dofus.datacenter.PlayableCharacter
{
   var _nameID;
   function Creature(id, clipClass, gfxFile, cellNum, dir, gfxID)
   {
      super();
      this.initialize(id,clipClass,gfxFile,cellNum,dir,gfxID);
   }
   function set name(value)
   {
      this._nameID = value;
   }
   function get name()
   {
      return _global.getMonstersText(this._nameID);
   }
}
