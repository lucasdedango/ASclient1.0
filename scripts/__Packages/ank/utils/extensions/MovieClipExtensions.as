class ank.utils.extensions.MovieClipExtensions extends MovieClip
{
   function MovieClipExtensions()
   {
      super();
   }
   function attachClassMovie(className, instanceName, depth, argv)
   {
      var _loc1_ = this.createEmptyMovieClip(instanceName,depth);
      _loc1_.__proto__ = className.prototype;
      className.apply(_loc1_,argv);
      return _loc1_;
   }
   function alignOnPixel()
   {
      var _loc2_ = this;
      var _loc1_ = new Object({x:0,y:0});
      _loc2_.localToGlobal(_loc1_);
      _loc1_.x = Math.floor(_loc1_.x);
      _loc1_.y = Math.floor(_loc1_.y);
      _loc2_.globalToLocal(_loc1_);
      _loc2_._x -= _loc1_.x;
      _loc2_._y -= _loc1_.y;
   }
   function playFirstChildren()
   {
      var _loc1_ = this;
      for(var _loc2_ in _loc1_)
      {
         if(_loc1_[_loc2_].__proto__ == MovieClip.prototype)
         {
            _loc1_[_loc2_].gotoAndPlay(1);
         }
      }
   }
   function end(seq)
   {
      var _loc1_ = seq;
      var _loc2_ = this.getFirstParentProperty("_ACTION");
      if(_loc1_ == undefined)
      {
         _loc1_ = _loc2_.sequencer;
      }
      _loc1_.onActionEnd();
   }
   function getFirstParentProperty(prop)
   {
      var _loc3_ = prop;
      var _loc2_ = 20;
      var _loc1_ = this;
      while(_loc2_ >= 0)
      {
         if(_loc1_[_loc3_] != undefined)
         {
            return _loc1_[_loc3_];
         }
         _loc1_ = _loc1_._parent;
         _loc2_ = _loc2_ - 1;
      }
   }
   function getActionClip(Void)
   {
      return this.getFirstParentProperty("_ACTION");
   }
}
