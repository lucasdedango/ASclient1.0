class ank.battlefield.TextHandler
{
   var _container;
   function TextHandler(b, c, d)
   {
      this.initialize(b,c,d);
   }
   function initialize(b, c, d)
   {
      var _loc1_ = this;
      _loc1_._battlefield = b;
      _loc1_._container = c;
      _loc1_._datacenter = d;
   }
   function clear()
   {
      var _loc1_ = this;
      for(var _loc2_ in _loc1_._container)
      {
         _loc1_._container[_loc2_].removeMovieClip();
      }
   }
   function addBubble(id, x, y, text)
   {
      var _loc3_ = this;
      var mapW = (_loc3_._datacenter.Map.width - 1) * ank.battlefield.Constants.CELL_WIDTH;
      var _loc1_ = _loc3_._container.attachClassMovie(ank.battlefield.mc.Bubble,"bubble" + id,id,[text,x,y,mapW]);
      var _loc2_ = _loc3_._battlefield.getZoom();
      if(_loc2_ < 100)
      {
         _loc1_._xscale = _loc1_._yscale = 10000 / _loc2_;
      }
   }
   function removeBubble(id)
   {
      var _loc1_ = this._container["bubble" + id];
      _loc1_.remove();
   }
}
