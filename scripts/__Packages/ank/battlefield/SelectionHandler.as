class ank.battlefield.SelectionHandler
{
   var _battlefield;
   var _container;
   function SelectionHandler(b, c, d)
   {
      this.initialize(b,c,d);
   }
   function initialize(b, c, d)
   {
      var _loc1_ = this;
      _loc1_._battlefield = b;
      _loc1_._datacenter = d;
      _loc1_._container = c;
      _loc1_.clear();
   }
   function clear(Void)
   {
      this._container.clear();
   }
   function select(bool, cellNum, col)
   {
      var _loc2_ = this._battlefield.mapHandler.getCellData(cellNum);
      var _loc3_;
      var _loc1_;
      if(_loc2_ != undefined)
      {
         _loc3_ = "cell" + String(cellNum);
         if(bool)
         {
            _loc1_ = this._container.attach(ank.battlefield.Constants.SELECTION_CELL_CLIP_ID,_loc3_,cellNum * 100);
            _loc1_._x = _loc2_.x;
            _loc1_._y = _loc2_.y;
            _loc1_.c = new Color(_loc1_);
            _loc1_.c.setRGB(col);
            _loc1_.gotoAndStop(_loc2_.groundSlope);
         }
         else
         {
            this._container.Selection[_loc3_].removeMovieClip();
         }
      }
   }
   function selectMultiple(bool, cellList, col)
   {
      var _loc1_ = cellList;
      var _loc2_ = bool;
      var _loc3_ = this;
      for(var i in _loc1_)
      {
         _loc3_.select(_loc2_,_loc1_[i],col);
      }
   }
}
