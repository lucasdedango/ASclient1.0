class dofus.graphics.battlefield.EffectsOverHead extends MovieClip
{
   var effects_mc;
   static var ICON_WIDTH = 20;
   function EffectsOverHead(effects)
   {
      super();
      this.initialize();
      this.draw(effects);
   }
   function initialize()
   {
      this.createEmptyMovieClip("effects_mc",10);
   }
   function draw(effects)
   {
      var _loc1_ = effects.length - 1;
      var _loc3_;
      var _loc2_;
      while(_loc1_ >= 0)
      {
         _loc3_ = effects[_loc1_];
         _loc2_ = this.effects_mc.attachClassMovie(ank.utils.SWFLoader,"effect" + _loc1_ + "_mc",_loc1_);
         _loc2_._x = _loc1_ * dofus.graphics.battlefield.EffectsOverHead.ICON_WIDTH;
         _loc2_.addListener(this);
         _loc2_.loadSWF(dofus.Constants.EFFECTSICON_FILE,undefined,[_loc3_.characteristic,_loc3_.operator]);
         _loc1_ = _loc1_ - 1;
      }
      this._x = (- effects.length * dofus.graphics.battlefield.EffectsOverHead.ICON_WIDTH) / 2;
   }
   function onLoadComplete(mc, args)
   {
      mc.attachMovie("Icon_" + args[0],"icon_mc",10,{_operator:args[1]});
   }
}
