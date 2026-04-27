class dofus.datacenter.NonPlayableCharacter extends ank.battlefield.datacenter.Sprite
{
   var __proto__;
   var _gfxID;
   var _oNpcText;
   function NonPlayableCharacter(id, clipClass, gfxFile, cellNum, dir, gfxID)
   {
      super();
      if(this.__proto__ == dofus.datacenter.NonPlayableCharacter.prototype)
      {
         this.initialize(id,clipClass,gfxFile,cellNum,dir,gfxID);
      }
   }
   function set unicID(value)
   {
      this._oNpcText = _global.getNonPlayableCharactersText(value);
   }
   function get name()
   {
      return this._oNpcText.n;
   }
   function get actions()
   {
      var aTmp = new Array();
      var _loc2_ = this._oNpcText.a;
      var _loc1_ = _loc2_.length;
      while(_loc1_-- > 0)
      {
         aTmp.push({name:_global.getNonPlayableCharactersActionText(_loc2_[_loc1_]),action:this.getActionFunction(_loc2_[_loc1_])});
      }
      return aTmp;
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
   function getActionFunction(nActionID)
   {
      var _loc1_ = _global;
      var _loc3_ = this;
      switch(nActionID)
      {
         case 1:
            return {object:_loc1_.AKS.Exchange,method:_loc1_.AKS.Exchange.request,params:[0,_loc3_.id]};
         case 2:
            return {object:_loc1_.AKS.Exchange,method:_loc1_.AKS.Exchange.request,params:[2,_loc3_.id]};
         case 3:
            return {object:_loc1_.AKS.Dialog,method:_loc1_.AKS.Dialog.create,params:[_loc3_.id]};
         default:
            return new _loc2_();
      }
   }
}
