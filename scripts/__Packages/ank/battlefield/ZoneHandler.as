class ank.battlefield.ZoneHandler
{
   var _battlefield;
   var _zones;
   function ZoneHandler(b, c)
   {
      this.initialize(b,c);
   }
   function initialize(b, c)
   {
      var _loc1_ = this;
      _loc1_._battlefield = b;
      _loc1_._container = c;
      _loc1_.clear();
   }
   function clear(Void)
   {
      var _loc1_ = this;
      _loc1_._zones.removeMovieClip();
      _loc1_._zones = _loc1_._container.createEmptyMovieClip("zones",10);
      _loc1_._nextLayerDepth = 0;
   }
   function clearZone(cellNum, radius, layer)
   {
      var _loc1_ = cellNum;
      var _loc3_ = radius;
      _loc1_ = Number(_loc1_);
      _loc3_ = Number(_loc3_);
      var _loc2_;
      if(_loc1_ >= 0)
      {
         if(_loc1_ <= this._battlefield.mapHandler.getCellCount())
         {
            _loc2_ = _loc1_ * 1000 + _loc3_ * 100;
            this._zones[layer]["zone" + _loc2_].clear();
         }
      }
   }
   function clearZoneLayer(layer)
   {
      this._zones[layer].removeMovieClip();
   }
   function drawZone(cellNum, radius, layer, col, shape)
   {
      var _loc1_ = cellNum;
      var _loc2_ = this;
      _loc1_ = Number(_loc1_);
      radius = Number(radius);
      col = Number(col);
      var _loc3_;
      if(_loc1_ >= 0)
      {
         if(_loc1_ <= _loc2_._battlefield.mapHandler.getCellCount())
         {
            var zoneNameID = _loc1_ * 1000 + radius * 100;
            if(_loc2_._zones[layer] == undefined)
            {
               _loc2_._zones.createEmptyMovieClip(layer,_loc2_._nextLayerDepth++);
            }
            _loc3_ = _loc2_._zones[layer].attachClassMovie(ank.battlefield.mc.Zone,"zone" + zoneNameID,zoneNameID,[_loc2_._battlefield.mapHandler]);
            switch(shape)
            {
               case "C":
                  _loc3_.drawCircle(radius,col,_loc1_);
                  break;
               case "X":
                  _loc3_.drawCross(radius,col,_loc1_);
                  break;
               default:
                  _loc3_.drawCircle(radius,col,_loc1_);
            }
            _loc2_.moveZoneTo(_loc3_,_loc1_);
         }
      }
   }
   function moveZoneTo(zone, cellNum)
   {
      var _loc1_ = this._battlefield.mapHandler.getCellData(cellNum);
      zone._x = _loc1_.x;
      zone._y = _loc1_.y + ank.battlefield.Constants.LEVEL_HEIGHT * (_loc1_.groundLevel - 7);
   }
}
