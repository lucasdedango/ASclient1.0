class ank.battlefield.GridHandler
{
   var _container;
   var _datacenter;
   var _grid;
   var bGridVisible;
   function GridHandler(c, d)
   {
      this.initialize(c,d);
   }
   function initialize(c, d)
   {
      this._container = c;
      this._datacenter = d;
   }
   function draw(Void)
   {
      var _loc3_ = this;
      _loc3_._grid = _loc3_._container.createEmptyMovieClip("grid",10);
      var _loc1_ = _loc3_._datacenter.Map.data;
      var _loc2_ = ank.battlefield.Constants.CELL_COORD;
      _loc3_._grid.lineStyle(1,ank.battlefield.Constants.GRID_COLOR,ank.battlefield.Constants.GRID_ALPHA);
      for(var i in _loc1_)
      {
         if(_loc1_[i].movement != 0 && _loc1_[i].lineOfSight)
         {
            _loc3_._grid.moveTo(_loc2_[_loc1_[i].groundSlope][0][0] + _loc1_[i].x,_loc2_[_loc1_[i].groundSlope][0][1] + _loc1_[i].y);
            _loc3_._grid.lineTo(_loc2_[_loc1_[i].groundSlope][1][0] + _loc1_[i].x,_loc2_[_loc1_[i].groundSlope][1][1] + _loc1_[i].y);
            _loc3_._grid.lineTo(_loc2_[_loc1_[i].groundSlope][2][0] + _loc1_[i].x,_loc2_[_loc1_[i].groundSlope][2][1] + _loc1_[i].y);
         }
      }
      _loc3_.bGridVisible = true;
   }
   function clear(Void)
   {
      this._grid.removeMovieClip();
      this.bGridVisible = false;
   }
}
