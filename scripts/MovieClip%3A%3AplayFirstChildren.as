MovieClip.prototype.playFirstChildren = function()
{
   var _loc1_ = this;
   for(var _loc2_ in _loc1_)
   {
      trace(_loc2_);
      if(_loc1_[_loc2_].__proto__ == MovieClip.prototype)
      {
         _loc1_[_loc2_].gotoAndPlay(1);
         break;
      }
   }
};
