class ank.battlefield.datacenter.Cell extends Object
{
   var allSpritesOn;
   var groundLevel;
   var y;
   function Cell()
   {
      super();
   }
   function get rootY()
   {
      return this.y - (7 - this.groundLevel) * ank.battlefield.Constants.LEVEL_HEIGHT;
   }
   function addSpriteOnID(value)
   {
      var _loc1_ = this;
      var _loc2_ = value;
      if(_loc1_.allSpritesOn == undefined)
      {
         _loc1_.allSpritesOn = new Object();
      }
      if(_loc2_ != undefined)
      {
         if(!_loc1_.allSpritesOn[Number(_loc2_)])
         {
            _loc1_.allSpritesOn[Number(_loc2_)] = true;
         }
      }
   }
   function removeSpriteOnID(value)
   {
      delete this.allSpritesOn[Number(value)];
   }
   function get SpriteOnID()
   {
      var _loc1_ = this;
      if(_loc1_.allSpritesOn == undefined)
      {
         return undefined;
      }
      for(var _loc2_ in _loc1_.allSpritesOn)
      {
         if(_loc1_.allSpritesOn[_loc2_])
         {
            return Number(_loc2_);
         }
      }
      return undefined;
   }
}
