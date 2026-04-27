class ank.battlefield.utils.SpriteDepthFinder
{
   function SpriteDepthFinder()
   {
   }
   static function getFreeDepthOnCell(mapHandler, spritesData, cellNum, bGhostView)
   {
      if(cellNum < 0)
      {
         ank.utils.Logger.err("[getFreeDepthOnCell] La cellule ne doit pas être < 0.");
         cellNum = 0;
      }
      if(cellNum > mapHandler.getCellCount())
      {
         ank.utils.Logger.err("[getFreeDepthOnCell] La cellule ne doit pas être > " + mapHandler.getCellCount());
         cellNum = 0;
      }
      var allSpritesOn = mapHandler.getCellData(cellNum).allSpritesOn;
      var _loc2_ = new Object();
      for(var k in allSpritesOn)
      {
         _loc2_[spritesData.getItemAt(k).sprite_mc.getDepth()] = true;
      }
      var _loc3_ = cellNum * 100 + ank.battlefield.Constants.FIRST_SPRITE_DEPTH_ON_CELL + (!bGhostView ? 0 : ank.battlefield.Constants.MAX_DEPTH_IN_MAP);
      var _loc1_ = 0;
      while(_loc1_ < ank.battlefield.Constants.MAX_SPRITES_ON_CELL)
      {
         if(_loc2_[_loc3_ + _loc1_] == undefined)
         {
            break;
         }
         _loc1_ = _loc1_ + 1;
      }
      if(_loc1_ == ank.battlefield.Constants.MAX_SPRITES_ON_CELL)
      {
         ank.utils.Logger.err("[getFreeDepthOnCell] plus de place sur cette cellule");
      }
      return _loc3_ + _loc1_;
   }
}
