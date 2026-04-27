class ank.battlefield.GlobalSpriteHandler
{
   var _oSprites;
   function GlobalSpriteHandler()
   {
      this.initialize();
   }
   function initialize()
   {
      this._oSprites = new Object();
   }
   function addSprite(mcSprite, oSpriteData)
   {
      this._oSprites[mcSprite._target] = {mc:mcSprite,data:oSpriteData};
      this.garbageCollector();
   }
   function setColors(mc, color1, color2, color3)
   {
      var _loc1_ = this._oSprites[mc._target].data;
      if(color1 != -1)
      {
         _loc1_.Color1 = color1;
      }
      if(color2 != -1)
      {
         _loc1_.Color2 = color2;
      }
      if(color3 != -1)
      {
         _loc1_.Color3 = color3;
      }
   }
   function setAccessories(mc, aAccessories)
   {
      var _loc1_ = this._oSprites[mc._target].data;
      if(aAccessories != undefined)
      {
         _loc1_.Accessories = aAccessories;
      }
   }
   function applyColor(mc, nZone)
   {
      var _loc3_ = this.getSpriteData(mc);
      var _loc1_;
      var _loc2_;
      if(_loc3_ != undefined)
      {
         _loc1_ = _loc3_["Color" + nZone];
         if(_loc1_ != undefined && _loc1_ != -1)
         {
            var r = (_loc1_ & 0xFF0000) >> 16;
            var v = (_loc1_ & 0xFF00) >> 8;
            var b = _loc1_ & 0xFF;
            var c = new Color(mc);
            _loc2_ = new Object();
            _loc2_ = {ra:"0",rb:r,ga:"0",gb:v,ba:"0",bb:b,aa:"100",ab:"0"};
            c.setTransform(_loc2_);
         }
      }
   }
   function applyAccessory(mc, accessoryID, side)
   {
      var _loc2_ = mc;
      var _loc1_ = this.getSpriteData(_loc2_);
      var _loc3_;
      if(_loc1_ != undefined)
      {
         _loc2_.clip.removeMovieClip();
         switch(accessoryID)
         {
            case 0:
               _loc3_ = _loc1_.Accessories[0].gfx;
               break;
            case 1:
               _loc3_ = _loc1_.Accessories[1].gfx;
               break;
            case 2:
               _loc3_ = _loc1_.Accessories[2].gfx;
         }
         _loc2_.attachMovie(_loc3_,"clip",10);
         _loc2_.clip.gotoAndStop(side);
      }
   }
   function applyAnim(mc, sAnim)
   {
      var _loc1_ = this.getSpriteData(mc);
      if(_loc1_ != undefined)
      {
         if(!_loc1_.bAnimLoop)
         {
            _loc1_.sprite_mc.setAnim(sAnim);
         }
      }
   }
   function applyEnd(mc)
   {
      var _loc1_ = this.getSpriteData(mc);
      if(_loc1_ != undefined)
      {
         if(!_loc1_.bAnimLoop)
         {
            _loc1_.sequencer.onActionEnd();
         }
      }
   }
   function getSpriteData(mc)
   {
      var _loc1_ = this;
      var _loc2_ = mc._target;
      for(var _loc3_ in _loc1_._oSprites)
      {
         if(_loc2_.substring(0,_loc3_.length) == _loc3_)
         {
            if(_loc2_.charAt(_loc3_.length) != "/")
            {
               continue;
            }
            if(_loc1_._oSprites[_loc3_] != undefined)
            {
               return _loc1_._oSprites[_loc3_].data;
            }
         }
      }
   }
   function garbageCollector(Void)
   {
      var _loc1_ = this;
      for(var _loc2_ in _loc1_._oSprites)
      {
         if(_loc1_._oSprites[_loc2_].mc._target == undefined)
         {
            delete _loc1_._oSprites[_loc2_];
         }
      }
   }
}
