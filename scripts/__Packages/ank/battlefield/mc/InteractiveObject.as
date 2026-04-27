class ank.battlefield.mc.InteractiveObject extends MovieClip
{
   var _battlefield;
   var _cellData;
   function InteractiveObject()
   {
      super();
   }
   function initialize(b, cd)
   {
      this._battlefield = b;
      this._cellData = cd;
   }
   function select(bool)
   {
      var _loc1_ = new Color(this);
      var _loc2_ = new Object();
      if(bool)
      {
         _loc2_ = {ra:60,rb:80,ga:60,gb:80,ba:60,bb:80};
      }
      else
      {
         _loc2_ = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
      }
      _loc1_.setTransform(_loc2_);
   }
   function loadExternalClip(sFile)
   {
      var _loc1_ = this;
      _loc1_._loader = _loc1_.attachClassMovie(ank.utils.SWFLoader,"loader",10);
      _loc1_._loader.addListener(_loc1_);
      _loc1_._loader.loadSWF(sFile);
   }
   function get cellData()
   {
      return this._cellData;
   }
   function _release(Void)
   {
      this._battlefield.onObjectRelease(this);
   }
   function _rollOver(Void)
   {
      this._battlefield.onObjectRollOver(this);
   }
   function _rollOut(Void)
   {
      this._battlefield.onObjectRollOut(this);
   }
   function onLoadComplete(mc)
   {
      var _loc1_ = mc;
      var hw = _loc1_._width;
      var hh = _loc1_._height;
      var _loc2_ = hw / hh;
      var cRatio = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE / ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
      if(_loc2_ == cRatio)
      {
         _loc1_._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
         _loc1_._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
      }
      else if(_loc2_ > cRatio)
      {
         _loc1_._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
         _loc1_._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE / _loc2_;
      }
      else
      {
         _loc1_._width = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE * _loc2_;
         _loc1_._height = ank.battlefield.Constants.EXTERNAL_OBJECT2_SIZE;
      }
      var _loc3_ = _loc1_.getBounds(_loc1_._parent);
      _loc1_._x = - _loc3_.xMin - _loc1_._width / 2;
      _loc1_._y = - _loc3_.yMin - _loc1_._height;
   }
}
