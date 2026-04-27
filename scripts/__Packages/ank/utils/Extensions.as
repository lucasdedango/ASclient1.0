class ank.utils.Extensions
{
   static var bExtended = false;
   function Extensions()
   {
   }
   static function addExtensions()
   {
      if(ank.utils.Extensions.bExtended == true)
      {
         return true;
      }
      var _loc2_ = ank.utils.extensions.MovieClipExtensions.prototype;
      var _loc1_ = MovieClip.prototype;
      _loc1_.attachClassMovie = _loc2_.attachClassMovie;
      _loc1_.alignOnPixel = _loc2_.alignOnPixel;
      _loc1_.playFirstChildren = _loc2_.playFirstChildren;
      _loc1_.getFirstParentProperty = _loc2_.getFirstParentProperty;
      _loc1_.getActionClip = _loc2_.getActionClip;
      _loc1_.end = _loc2_.end;
      var se = ank.utils.extensions.StringExtensions.prototype;
      var _loc3_ = String.prototype;
      _loc3_.replace = se.replace;
   }
}
