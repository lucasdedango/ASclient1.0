class dofus.datacenter.Character extends dofus.datacenter.PlayableCharacter
{
   var _alignment;
   var _bDied;
   var _bMerchant;
   var _guild;
   var _sex;
   function Character(id, clipClass, gfxFile, cellNum, dir, gfxID)
   {
      super();
      this.initialize(id,clipClass,gfxFile,cellNum,dir,gfxID);
   }
   function get Guild()
   {
      return this._guild;
   }
   function set Guild(value)
   {
      this._guild = Number(value);
   }
   function get Sex()
   {
      return this._sex;
   }
   function set Sex(value)
   {
      this._sex = Number(value);
   }
   function get Alignment()
   {
      return this._alignment;
   }
   function set Alignment(value)
   {
      var _loc1_ = this;
      _loc1_._alignment = Number(value);
      _loc1_.broadcastMessage("onSetAlignment",Number(value));
   }
   function get AlignmentFrame()
   {
      var _loc1_ = Math.abs(this._alignment);
      if(_loc1_ <= 20)
      {
         return 1;
      }
      if(_loc1_ <= 40)
      {
         return 2;
      }
      if(_loc1_ <= 60)
      {
         return 3;
      }
      if(_loc1_ <= 80)
      {
         return 4;
      }
      return 5;
   }
   function get Merchant()
   {
      return this._bMerchant;
   }
   function set Merchant(value)
   {
      this._bMerchant = value;
   }
   function get Died()
   {
      return this._bDied;
   }
   function set Died(value)
   {
      this._bDied = value;
   }
}
