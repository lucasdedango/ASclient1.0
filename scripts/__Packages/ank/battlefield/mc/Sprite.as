class ank.battlefield.mc.Sprite extends MovieClip
{
   var _battlefield;
   var _data;
   var _extra_mc;
   var _nLastAlphaValue = 100;
   static var WALK_SPEEDS = [0.07,0.06,0.06,0.06,0.07,0.06,0.06,0.06];
   static var RUN_SPEEDS = [0.17,0.15,0.15,0.15,0.17,0.15,0.15,0.15];
   function Sprite(b, sd, d)
   {
      super();
      this.initialize(b,sd,d);
   }
   function initialize(b, sd, d)
   {
      var _loc1_ = this;
      _loc1_._battlefield = b;
      _loc1_._spritesData = sd;
      _loc1_._data = d;
      _loc1_._loader = _loc1_.attachClassMovie(ank.utils.SWFLoader,"loader",20);
      _loc1_._loader.addListener(_loc1_);
      _loc1_.createEmptyMovieClip("_points_mc",30);
      _loc1_._points_mc._y = - ank.battlefield.Constants.DEFAULT_SPRITE_HEIGHT;
      _loc1_._pointsStock = new Array();
      _loc1_.setPosition(_loc1_._data.CellNum);
      _loc1_.draw();
      _loc1_._ACTION = d;
   }
   function draw(Void)
   {
      var _loc1_ = this;
      _loc1_._loader.clear();
      _loc1_._loader.loadSWF(_loc1_._data.gfxFile);
   }
   function clear(Void)
   {
      var _loc1_ = this;
      _loc1_._battlefield.mapHandler.getCellData(_loc1_._data.CellNum).removeSpriteOnID(_loc1_._data.id);
      _loc1_._loader.remove();
      _loc1_._data.Direction = 1;
      _loc1_.removeExtraClip();
   }
   function select(bool)
   {
      var _loc1_ = new Object();
      if(bool)
      {
         _loc1_ = {ra:60,rb:102,ga:60,gb:102,ba:60,bb:102};
      }
      else
      {
         _loc1_ = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0};
      }
      this.setColorTransform(_loc1_);
   }
   function addExtraClip(clipFile, col)
   {
      var _loc2_ = this;
      _loc2_.removeExtraClip();
      _loc2_._extra_mc.loadMovie(clipFile);
      var _loc1_;
      if(col != undefined)
      {
         _loc1_ = new Color(_loc2_._extra_mc);
         _loc1_.setRGB(col);
      }
   }
   function removeExtraClip(Void)
   {
      this._extra_mc.removeMovieClip();
      this.createEmptyMovieClip("_extra_mc",10);
   }
   function showPoints(value, col)
   {
      var _loc1_ = this;
      var _loc3_;
      var _loc2_;
      if(_loc1_._data.bVisible)
      {
         var len = _loc1_._pointsStock.length;
         var depth = len == 0 ? 1 : _loc1_._pointsStock[len - 1].getDepth() + 1;
         _loc3_ = _loc1_._points_mc.createEmptyMovieClip("p" + depth,depth);
         _loc3_.createTextField("txtf",10,-25,0,60,20);
         _loc2_ = _loc3_.txtf;
         _loc2_.text = value;
         _loc2_.textColor = col;
         _loc2_.embedFonts = true;
         _loc2_.setTextFormat(ank.battlefield.Constants.SPRITE_POINTS_TEXTFORMAT);
         _loc3_._visible = false;
         _loc1_._pointsStock.push(_loc3_);
         if(_loc1_._points_mc.onEnterFrame == undefined)
         {
            _loc1_._pointsStock[0]._visible = true;
            _loc1_._points_mc.onEnterFrame = function()
            {
               var _loc2_ = this;
               if(_loc2_._parent._pointsStock.length == 0)
               {
                  delete _loc2_.onEnterFrame;
               }
               var _loc1_ = _loc2_._parent._pointsStock[0];
               _loc1_._y -= 3;
               if(_loc1_._y < - ank.battlefield.Constants.SPRITE_POINTS_OFFSET)
               {
                  _loc2_._parent._pointsStock.shift().removeMovieClip();
               }
               if(_loc1_._y < - ank.battlefield.Constants.SPRITE_POINTS_OFFSET + 10)
               {
                  _loc2_._parent._pointsStock[1]._visible = true;
               }
            };
         }
      }
   }
   function setColorTransform(t)
   {
      var _loc1_ = new Color(this);
      _loc1_.setTransform(t);
   }
   function setNewCellNum(cellNum)
   {
      this._data.CellNum = Number(cellNum);
   }
   function setDirection(dir)
   {
      var _loc1_ = this;
      var _loc2_ = dir;
      if(_loc2_ == undefined)
      {
         _loc2_ = _loc1_._data.Direction;
      }
      _loc1_._data.Direction = _loc2_;
      _loc1_.setAnim();
   }
   function setPosition(cellNum)
   {
      var _loc1_ = this;
      var _loc2_ = cellNum;
      _loc1_.setDepth(_loc2_);
      _loc1_.updateMap(_loc2_,_loc1_._data.bVisible);
      if(_loc2_ == undefined)
      {
         _loc2_ = _loc1_._data.CellNum;
      }
      else
      {
         _loc1_.setNewCellNum(_loc2_);
      }
      var cellData = _loc1_._battlefield.mapHandler.getCellData(_loc2_);
      var _loc3_ = _loc1_._battlefield.mapHandler.getCellHeight(_loc2_);
      var dh = _loc3_ - Math.floor(_loc3_);
      _loc1_._x = cellData.x;
      _loc1_._y = cellData.y - dh * ank.battlefield.Constants.LEVEL_HEIGHT;
   }
   function setDepth(cellNum)
   {
      var _loc1_ = this;
      var _loc2_ = cellNum;
      if(_loc2_ == undefined)
      {
         _loc2_ = _loc1_._data.CellNum;
      }
      var _loc3_ = ank.battlefield.utils.SpriteDepthFinder.getFreeDepthOnCell(_loc1_._battlefield.mapHandler,_loc1_._spritesData,_loc2_,_loc1_._battlefield.bGhostView);
      _loc1_.swapDepths(_loc3_);
   }
   function setVisible(bool)
   {
      var _loc1_ = this;
      var _loc2_ = bool;
      _loc1_._data.bVisible = _loc2_;
      _loc1_._clip._visible = _loc2_;
      _loc1_._extra_mc._visible = _loc2_;
      _loc1_.updateMap(_loc1_._data.CellNum,_loc2_);
   }
   function setAlpha(value)
   {
      this._alpha = value;
   }
   function setGhostView(bool)
   {
      var _loc1_ = this;
      _loc1_.setDepth();
      if(bool)
      {
         _loc1_._nLastAlphaValue = _loc1_._alpha;
         _loc1_.setAlpha(ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
      }
      else
      {
         _loc1_.setAlpha(_loc1_._nLastAlphaValue);
      }
   }
   function moveToCell(seq, cellNum, bStop, bRun, bSlide)
   {
      var _loc1_ = this;
      var _loc3_;
      var _loc2_;
      if(cellNum != _loc1_._data.CellNum)
      {
         _loc3_ = _loc1_._battlefield.mapHandler.getCellData(_loc1_._data.CellNum);
         _loc2_ = _loc1_._battlefield.mapHandler.getCellData(cellNum);
         var xDest = _loc2_.x;
         var yDest = _loc2_.y;
         var variation = 0.01;
         if(_loc2_.groundSlope != 1)
         {
            yDest -= ank.battlefield.Constants.HALF_LEVEL_HEIGHT;
         }
         if(!bSlide)
         {
            _loc1_._data.Direction = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(_loc3_.x,_loc3_.rootY,xDest,_loc2_.rootY,true);
         }
         var speed = !bSlide ? (!bRun ? ank.battlefield.mc.Sprite.WALK_SPEEDS[_loc1_._data.Direction] : ank.battlefield.mc.Sprite.RUN_SPEEDS[_loc1_._data.Direction]) : 0.25;
         if(_loc2_.groundLevel < _loc3_.groundLevel)
         {
            speed += variation;
         }
         else if(_loc2_.groundLevel > _loc3_.groundLevel)
         {
            speed -= variation;
         }
         else if(_loc3_.groundSlope != _loc2_.groundSlope)
         {
            if(_loc2_.groundSlope == 1)
            {
               speed += variation;
            }
            else if(_loc3_.groundSlope == 1)
            {
               speed -= variation;
            }
         }
         if(bSlide)
         {
            _loc1_.setAnim("Static");
         }
         else if(bRun)
         {
            _loc1_.setAnim("Run");
         }
         else
         {
            _loc1_.setAnim("Walk");
         }
         _loc1_._distance = Math.sqrt(Math.pow(_loc1_._x - xDest,2) + Math.pow(_loc1_._y - yDest,2));
         var r = Math.atan2(yDest - _loc1_._y,xDest - _loc1_._x);
         var cosRot = Math.cos(r);
         var sinRot = Math.sin(r);
         var bSetDepthBefore = Number(cellNum) > _loc1_._data.CellNum;
         if(bSetDepthBefore)
         {
            _loc1_.setDepth(cellNum);
         }
         _loc1_._lastTimer = getTimer();
         _loc1_.updateMap(cellNum,_loc1_._data.bVisible);
         _loc1_.setNewCellNum(cellNum);
         _loc1_._data.bInMove = true;
         ank.utils.CyclicTimer.addFunction(_loc1_,_loc1_,_loc1_.basicMove,[speed,cosRot,sinRot],_loc1_,_loc1_.basicMoveEnd,[seq,xDest,yDest,cellNum,bStop,bSlide,!bSetDepthBefore]);
      }
      else
      {
         seq.onActionEnd();
      }
   }
   function basicMove(speed, cosRot, sinRot)
   {
      var _loc1_ = this;
      var _loc3_ = getTimer() - _loc1_._lastTimer;
      var _loc2_ = speed * (_loc3_ <= 100 ? _loc3_ : 100);
      _loc1_._x += _loc2_ * cosRot;
      _loc1_._y += _loc2_ * sinRot;
      _loc1_._distance -= _loc2_;
      _loc1_._lastTimer = getTimer();
      if(_loc1_._distance <= _loc2_)
      {
         return false;
      }
      return true;
   }
   function basicMoveEnd(seq, xDest, yDest, cellNum, bStop, bSlide, bSetDepth)
   {
      var _loc1_ = this;
      if(bStop)
      {
         _loc1_._x = xDest;
         _loc1_._y = yDest;
         _loc1_.setAnim(_loc1_._data.defaultAnimation);
         _loc1_._data.bInMove = false;
      }
      if(bSetDepth)
      {
         _loc1_.setDepth(cellNum);
      }
      seq.onActionEnd();
   }
   function setAnim(anim, bLoop, bForced)
   {
      var _loc2_ = anim;
      var _loc3_ = this;
      if(_loc2_ == undefined)
      {
         _loc2_ = _loc3_._data.defaultAnimation;
      }
      if(bLoop == undefined)
      {
         bLoop = false;
      }
      if(bForced == undefined)
      {
         bForced = false;
      }
      _loc3_._data.bAnimLoop = bLoop;
      var _loc1_ = _loc3_._clip;
      if(bForced && _loc3_._data.animation.toLowerCase() == _loc2_.toLowerCase())
      {
         _loc1_.gotoAndStop("init");
      }
      switch(_loc3_._data.Direction)
      {
         case 0:
            _loc1_.gotoAndStop(_loc2_ + "S");
            _loc1_._xscale = 100;
            break;
         case 1:
            _loc1_.gotoAndStop(_loc2_ + "R");
            _loc1_._xscale = 100;
            break;
         case 2:
            _loc1_.gotoAndStop(_loc2_ + "F");
            _loc1_._xscale = 100;
            break;
         case 3:
            _loc1_.gotoAndStop(_loc2_ + "R");
            _loc1_._xscale = -100;
            break;
         case 4:
            _loc1_.gotoAndStop(_loc2_ + "S");
            _loc1_._xscale = -100;
            break;
         case 5:
            _loc1_.gotoAndStop(_loc2_ + "L");
            _loc1_._xscale = 100;
            break;
         case 6:
            _loc1_.gotoAndStop(_loc2_ + "B");
            _loc1_._xscale = 100;
            break;
         case 7:
            _loc1_.gotoAndStop(_loc2_ + "L");
            _loc1_._xscale = -100;
      }
      var oldAnim = _loc3_._data.animation.toLowerCase();
      if(oldAnim == "walk" || oldAnim == "run")
      {
         if(_loc2_.toLowerCase() == oldAnim)
         {
            return;
         }
      }
      _loc1_.playFirstChildren();
      _loc3_._data.animation = _loc2_;
   }
   function updateMap(cellNum, bVisible)
   {
      var _loc1_ = this;
      var _loc2_ = _loc1_._battlefield.mapHandler.getCellData(cellNum);
      if(_loc2_ == undefined)
      {
         if(bVisible)
         {
            _loc1_._battlefield.mapHandler.getCellData(_loc1_._data.CellNum).addSpriteOnID(_loc1_._data.id);
         }
         else
         {
            _loc1_._battlefield.mapHandler.getCellData(_loc1_._data.CellNum).removeSpriteOnID(_loc1_._data.id);
         }
      }
      else
      {
         _loc1_._battlefield.mapHandler.getCellData(_loc1_._data.CellNum).removeSpriteOnID(_loc1_._data.id);
         if(bVisible)
         {
            _loc2_.addSpriteOnID(_loc1_._data.id);
         }
      }
   }
   function onLoadComplete(mc)
   {
      var _loc1_ = this;
      _loc1_._clip = mc;
      _loc1_.setAnim(_loc1_._data.defaultAnimation);
   }
   function _release(Void)
   {
      this._battlefield.onSpriteRelease(this);
   }
   function _rollOver(Void)
   {
      this._battlefield.onSpriteRollOver(this);
   }
   function _rollOut(Void)
   {
      this._battlefield.onSpriteRollOut(this);
   }
}
