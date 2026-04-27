class ank.battlefield.PointerHandler
{
   var _battlefield;
   var _shapes;
   var _zones;
   function PointerHandler(b, c)
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
      this.hide();
      this._shapes = new Array();
   }
   function hide(Void)
   {
      var _loc1_ = this;
      _loc1_._zones.removeMovieClip();
      _loc1_._zones = _loc1_._container.createEmptyMovieClip("zones",2);
   }
   function addShape(shape, size, col, cellNumRef)
   {
      this._shapes.push({shape:shape,size:size,col:col,cellNumRef:cellNumRef});
   }
   function draw(cellNum)
   {
      var _loc2_ = this._shapes;
      var _loc1_;
      var _loc3_;
      if(_loc2_.length != 0)
      {
         this.hide();
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc3_ = this._zones.attachClassMovie(ank.battlefield.mc.Zone,"zone" + _loc1_,10 * _loc1_,[this._battlefield.mapHandler]);
            switch(_loc2_[_loc1_].shape)
            {
               case "P":
                  _loc3_.drawCircle(0,_loc2_[_loc1_].col,cellNum);
                  break;
               case "C":
                  _loc3_.drawCircle(_loc2_[_loc1_].size,_loc2_[_loc1_].col,cellNum);
                  break;
               case "L":
                  _loc3_.drawLine(_loc2_[_loc1_].size,_loc2_[_loc1_].col,cellNum,_loc2_[_loc1_].cellNumRef);
                  break;
               case "X":
                  _loc3_.drawCross(_loc2_[_loc1_].size,_loc2_[_loc1_].col,cellNum);
            }
            this.movePointerTo(_loc3_,cellNum);
            _loc1_ = _loc1_ + 1;
         }
      }
   }
   function movePointerTo(zone, cellNum)
   {
      var _loc1_ = this._battlefield.mapHandler.getCellData(cellNum);
      zone._x = _loc1_.x;
      zone._y = _loc1_.y + ank.battlefield.Constants.LEVEL_HEIGHT * (_loc1_.groundLevel - 7);
   }
}
