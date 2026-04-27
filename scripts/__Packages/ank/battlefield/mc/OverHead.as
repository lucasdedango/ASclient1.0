class ank.battlefield.mc.OverHead extends MovieClip
{
   var _currentItemID;
   var _layers;
   var _sprite;
   static var TOP_Y = -70;
   static var BOTTOM_Y = 10;
   function OverHead(sprite)
   {
      super();
      this._sprite = sprite;
      this.initialize();
   }
   function initialize()
   {
      this._currentItemID = 0;
      this.clear();
   }
   function clear()
   {
      this._layers = new Object();
      this.clearView();
   }
   function clearView()
   {
      this.createEmptyMovieClip("items_mc",10);
   }
   function setPosition()
   {
      var _loc1_ = this;
      _loc1_._x = _loc1_._sprite._x;
      _loc1_._y = _loc1_._sprite._y;
      if(_loc1_._sprite._y < - ank.battlefield.mc.OverHead.TOP_Y)
      {
         _loc1_._defaultY = ank.battlefield.mc.OverHead.BOTTOM_Y;
         _loc1_._inc = 1;
      }
      else
      {
         _loc1_._defaultY = ank.battlefield.mc.OverHead.TOP_Y;
         _loc1_._inc = -1;
      }
   }
   function addItem(layerName, className, args, delay)
   {
      var _loc2_ = this;
      var _loc1_ = new Object();
      _loc1_.ID = _loc2_._currentItemID;
      _loc1_.className = className;
      _loc1_.args = args;
      _loc1_.mc = new MovieClip();
      if(delay != undefined)
      {
         ank.utils.Timer.setTimer(_loc1_,_loc2_,_loc2_.removeItem,delay,[_loc2_._currentItemID]);
      }
      _loc2_._layers[layerName] = _loc1_;
      _loc2_._currentItemID = _loc2_._currentItemID + 1;
      _loc2_.refresh();
   }
   function remove(Void)
   {
      this.swapDepths(1);
      this.removeMovieClip();
   }
   function refresh()
   {
      var _loc1_ = this;
      _loc1_.setPosition();
      _loc1_.clearView();
      var _loc3_ = 0;
      var k;
      var item;
      var _loc2_;
      var currentY = _loc1_._defaultY;
      for(k in _loc1_._layers)
      {
         item = _loc1_._layers[k];
         _loc2_ = _loc1_.items_mc.attachClassMovie(item.className,"item" + _loc3_,_loc3_,item.args);
         _loc2_._y = currentY;
         currentY += _loc1_._inc * (_loc2_._height != 0 ? _loc2_._height : 20);
         _loc3_ = _loc3_ + 1;
      }
   }
   function removeLayer(layerName)
   {
      delete this._layers[layerName];
      this.refresh();
   }
   function removeItem(itemID)
   {
      var _loc1_ = this;
      var _loc3_ = itemID;
      var _loc2_;
      for(_loc2_ in _loc1_._layers)
      {
         if(_loc1_._layers[_loc2_].ID == _loc3_)
         {
            delete _loc1_._layers[_loc2_];
            _loc1_.refresh();
            break;
         }
      }
   }
}
