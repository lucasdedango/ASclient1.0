class ank.battlefield.OverHeadHandler
{
   var _battlefield;
   var _container;
   function OverHeadHandler(b, c)
   {
      this.initialize(b,c);
   }
   function initialize(b, c)
   {
      this._battlefield = b;
      this._container = c;
   }
   function clear()
   {
      var _loc1_ = this;
      for(var _loc2_ in _loc1_._container)
      {
         if(typeof _loc1_._container[_loc2_] == "movieclip")
         {
            _loc1_._container[_loc2_].swapDepths(0);
            _loc1_._container[_loc2_].removeMovieClip();
         }
      }
   }
   function addOverHeadItem(id, x, y, sprite, layerName, className, args, delay)
   {
      var _loc3_ = id;
      var _loc1_ = this._container["oh" + _loc3_];
      if(_loc1_ == undefined)
      {
         _loc1_ = this._container.attachClassMovie(ank.battlefield.mc.OverHead,"oh" + _loc3_,_loc3_,[sprite]);
      }
      _loc1_._x = x;
      _loc1_._y = y;
      var _loc2_ = this._battlefield.getZoom();
      if(_loc2_ < 100)
      {
         _loc1_._xscale = _loc1_._yscale = 10000 / _loc2_;
      }
      _loc1_.addItem(layerName,className,args,delay);
   }
   function removeOverHeadLayer(id, layerName)
   {
      var _loc1_ = this._container["oh" + id];
      _loc1_.removeLayer(layerName);
   }
   function removeOverHead(id)
   {
      var _loc1_ = this._container["oh" + id];
      _loc1_.remove();
   }
}
