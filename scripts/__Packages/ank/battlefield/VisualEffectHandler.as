class ank.battlefield.VisualEffectHandler
{
   var _incIndex;
   static var MAX_INDEX = 21;
   function VisualEffectHandler(b, c)
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
      this._incIndex = 0;
   }
   function addEffect(sprite, effectData, cellNum, displayType)
   {
      var _loc3_ = this;
      var _loc2_;
      var _loc1_;
      if(displayType >= 10)
      {
         var d = !effectData.bInFrontOfSprite ? -1 : 1;
         _loc2_ = _loc3_.getNextIndex() + ank.battlefield.Constants.MAX_SPRITES_ON_CELL / 2 + 1;
         _loc3_._container["eff" + _loc2_].removeMovieClip();
         _loc1_ = _loc3_._container.attachClassMovie(ank.utils.SWFLoader,"eff" + _loc2_,cellNum * 100 + 50 + d * _loc2_);
         _loc1_.addListener(_loc3_);
         _loc1_.loadSWF(effectData.file,undefined,[sprite,cellNum,displayType,effectData.level]);
         ank.utils.Timer.setTimer(_loc1_,_loc1_,_loc1_.remove,ank.battlefield.Constants.VISUAL_EFFECT_MAX_TIMER);
      }
   }
   function onLoadComplete(mc, args)
   {
      var _loc1_ = mc;
      var _loc3_ = this;
      var sprite = args[0];
      var cellNumTo = args[1];
      var displayType = args[2];
      var level = args[3];
      var cellNumFrom = sprite.CellNum;
      var _loc2_ = _loc3_._battlefield.mapHandler.getCellData(cellNumFrom);
      var cellDataTo = _loc3_._battlefield.mapHandler.getCellData(cellNumTo);
      _loc1_._ACTION = sprite;
      _loc1_.level = level;
      _loc1_.angle = Math.atan2(cellDataTo.y - _loc2_.y,cellDataTo.x - _loc2_.x) * 180 / 3.141592653589793;
      switch(displayType)
      {
         case 10:
         case 12:
            _loc1_._x = _loc2_.x;
            _loc1_._y = _loc2_.y;
            break;
         case 11:
            _loc1_._x = cellDataTo.x;
            _loc1_._y = cellDataTo.y;
            break;
         case 20:
         case 21:
            _loc1_._x = _loc2_.x;
            _loc1_._y = _loc2_.y;
            var PI2 = 1.5707963267948966;
            var dirx = cellDataTo.x - _loc2_.x;
            var diry = cellDataTo.y - _loc2_.y;
            _loc1_.rotate._rotation = _loc1_.angle;
            var shoot = _loc1_.attachMovie("shoot","shoot",10);
            shoot._x = dirx;
            shoot._y = diry;
            break;
         case 30:
         case 31:
            _loc1_._x = _loc2_.x;
            _loc1_._y = _loc2_.y;
            _loc1_.level = level;
            var startangle = !(displayType == 31 || displayType == 33) ? 0.5 : 0.9;
            var speed = !(displayType == 31 || displayType == 33) ? 0.5 : 0.4;
            var PI2 = 1.5707963267948966;
            var dirx = cellDataTo.x - _loc2_.x;
            var diry = cellDataTo.y - _loc2_.y;
            var tmpangle = (Math.atan2(diry,Math.abs(dirx)) + PI2) * startangle;
            var angle = tmpangle - PI2;
            var xDest = Math.abs(dirx);
            var yDest = diry;
            if(dirx <= 0)
            {
               if(dirx == 0 && diry < 0)
               {
                  _loc1_._yscale = - _loc1_._yscale;
                  yDest = - yDest;
               }
               _loc1_._xscale = - _loc1_._xscale;
            }
            _loc1_.attachMovie("move","move",2);
            var vyi;
            var x;
            var y;
            var g = 9.81;
            var halfg = g / 2;
            var t = 0;
            var vx = Math.sqrt(Math.abs(halfg * Math.pow(xDest,2) / Math.abs(yDest - Math.tan(angle) * xDest)));
            var vy = Math.tan(angle) * vx;
            _loc1_.onEnterFrame = function()
            {
               var _loc1_ = this;
               vyi = vy + g * t;
               x = t * vx;
               y = halfg * Math.pow(t,2) + vy * t;
               t += speed;
               if(Math.abs(y) >= Math.abs(yDest) && x >= xDest || x > xDest)
               {
                  _loc1_.attachMovie("shoot","shoot",2);
                  _loc1_.shoot._x = xDest;
                  _loc1_.shoot._y = yDest;
                  _loc1_.shoot._rotation = Math.atan(vyi / vx) * 180 / 3.141592653589793;
                  _loc1_.end();
                  delete _loc1_.onEnterFrame;
               }
               else
               {
                  _loc1_.move._x = x;
                  _loc1_.move._y = y;
                  _loc1_.move._rotation = Math.atan(vyi / vx) * 180 / 3.141592653589793;
               }
            };
            break;
         case 40:
         case 41:
            _loc1_._x = _loc2_.x;
            _loc1_._y = _loc2_.y;
            var speed = 20;
            var xStart = _loc2_.x;
            var yStart = _loc2_.y;
            var xDest = cellDataTo.x;
            var yDest = cellDataTo.y;
            var rot = Math.atan2(yDest - yStart,xDest - xStart);
            var fullDist = Math.sqrt(Math.pow(xStart - xDest,2) + Math.pow(yStart - yDest,2));
            var interval = fullDist / Math.floor(fullDist / speed);
            var dist = 0;
            var inc = 1;
            _loc1_.onEnterFrame = function()
            {
               var _loc1_ = this;
               dist += interval;
               var _loc2_;
               if(dist > fullDist)
               {
                  _loc1_.end();
                  if(displayType == 41)
                  {
                     _loc1_.attachMovie("shoot","shoot",10);
                     _loc1_.shoot._x = xDest - xStart;
                     _loc1_.shoot._y = yDest - yStart;
                  }
                  delete _loc1_.onEnterFrame;
               }
               else
               {
                  _loc2_ = _loc1_.attachMovie("duplicate","duplicate" + inc,inc);
                  _loc2_._x = dist * Math.cos(rot);
                  _loc2_._y = dist * Math.sin(rot);
                  inc++;
               }
            };
            break;
         case 50:
         case 51:
            _loc1_.cellFrom = {x:_loc2_.x,y:_loc2_.y};
            _loc1_.cellTo = {x:cellDataTo.x,y:cellDataTo.y};
         default:
            return;
      }
   }
   function getNextIndex(Void)
   {
      var _loc1_ = this;
      _loc1_._incIndex = _loc1_._incIndex + 1;
      if(_loc1_._incIndex > ank.battlefield.VisualEffectHandler.MAX_INDEX)
      {
         _loc1_._incIndex = 0;
      }
      return _loc1_._incIndex;
   }
}
