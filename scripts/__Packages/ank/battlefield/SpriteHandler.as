class ank.battlefield.SpriteHandler
{
   var _battlefield;
   var _data;
   static var DEFAULT_RUNLINIT = 6;
   function SpriteHandler(b, c, d)
   {
      this.initialize(b,c,d);
   }
   function initialize(b, c, d)
   {
      var _loc1_ = this;
      _loc1_._battlefield = b;
      _loc1_._data = d;
      _loc1_._container = c;
   }
   function clear(Void)
   {
      var _loc2_ = this;
      var _loc1_ = _loc2_._data.getItems();
      for(var _loc3_ in _loc1_)
      {
         _loc2_.removeSprite(_loc3_);
      }
   }
   function addSprite(id, spriteData)
   {
      var _loc1_ = spriteData;
      var _loc2_ = this;
      var _loc3_ = true;
      if(_loc1_ == undefined)
      {
         _loc3_ = false;
         _loc1_ = _loc2_._data.getItemAt(id);
      }
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[addSprite] pas de spriteData");
      }
      else
      {
         if(_loc3_)
         {
            _loc2_._data.addItemAt(id,_loc1_);
         }
         _loc2_._container["sprite" + id].removeMovieClip();
         var freeDepth = ank.battlefield.utils.SpriteDepthFinder.getFreeDepthOnCell(_loc2_._battlefield.mapHandler,_loc2_._data,_loc1_.CellNum,_loc2_._battlefield.bGhostView);
         _loc1_.sprite_mc = _loc2_._container.attachClassMovie(_loc1_.clipClass,"sprite" + id,freeDepth,[_loc2_._battlefield,_loc2_._data,_loc1_]);
         if(_loc2_._battlefield.bGhostView)
         {
            _loc1_.sprite_mc.setAlpha(ank.battlefield.Constants.GHOSTVIEW_SPRITE_ALPHA);
         }
         _global.GAC.addSprite(_loc1_.sprite_mc,_loc1_);
      }
   }
   function removeSprite(id, bKeepData)
   {
      var _loc1_ = this;
      var _loc3_ = id;
      if(bKeepData == undefined)
      {
         bKeepData = false;
      }
      var _loc2_ = _loc1_._data.getItemAt(_loc3_);
      _loc1_._container["sprite" + _loc3_].__proto__ = MovieClip.prototype;
      _loc1_._container["sprite" + _loc3_].removeMovieClip();
      _loc1_._battlefield.mapHandler.getCellData(_loc2_.CellNum).removeSpriteOnID(_loc2_.id);
      if(!bKeepData)
      {
         _loc1_._data.removeItemAt(_loc3_);
      }
   }
   function hideSprite(id, bool)
   {
      this._data.getItemAt(id).sprite_mc.setVisible(!bool);
   }
   function setSpritePosition(id, cellNum, dir)
   {
      var _loc2_ = cellNum;
      var _loc3_ = this;
      var _loc1_ = _loc3_._data.getItemAt(id);
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[setSpritePosition] Sprite inexistant");
      }
      else if(isNaN(Number(_loc2_)))
      {
         ank.utils.Logger.err("[setSpritePosition] cellNum n\'est pas un nombre");
      }
      else if(Number(_loc2_) < 0 || Number(_loc2_) > _loc3_._battlefield.mapHandler.getCellCount())
      {
         ank.utils.Logger.err("[setSpritePosition] cellNum invalide");
      }
      else
      {
         _loc3_._battlefield.removeSpriteBubble(id);
         _loc3_._battlefield.hideSpriteOverHead(id);
         if(dir != undefined)
         {
            _loc1_.Direction = dir;
         }
         var mc = _loc1_.sprite_mc;
         mc.setPosition(_loc2_);
      }
   }
   function slideSprite(id, cellNum, seq)
   {
      var _loc1_ = this;
      var _loc2_ = _loc1_._data.getItemAt(id);
      var dir = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(_loc1_._battlefield.mapHandler.getCellData(_loc2_.CellNum).x,_loc1_._battlefield.mapHandler.getCellData(_loc2_.CellNum).y,_loc1_._battlefield.mapHandler.getCellData(cellNum).x,_loc1_._battlefield.mapHandler.getCellData(cellNum).y,false);
      var _loc3_ = ank.battlefield.utils.Compressor.makeFullPath(_loc1_._battlefield.mapHandler,[{num:_loc2_.CellNum},{num:cellNum,dir:dir}]);
      if(_loc3_ != undefined)
      {
         _loc1_.moveSprite(id,_loc3_,seq,false,true);
      }
   }
   function moveSprite(id, path, seq, bClearSequencer, bSlide, bForcedRun, bForcedWalk, runLimit)
   {
      var _loc3_ = seq;
      this._battlefield.removeSpriteBubble(id);
      this._battlefield.hideSpriteOverHead(id);
      if(runLimit == undefined)
      {
         runLimit = ank.battlefield.SpriteHandler.DEFAULT_RUNLINIT;
      }
      if(bForcedRun == undefined)
      {
         bForcedRun = false;
      }
      if(bForcedWalk == undefined)
      {
         bForcedWalk = false;
      }
      var bRun = false;
      if(!bSlide)
      {
         if(bForcedWalk)
         {
            bRun = false;
         }
         else if(bForcedRun)
         {
            bRun = true;
         }
         else if(!bForcedRun && !bForcedWalk)
         {
            if(path.length > runLimit)
            {
               bRun = true;
            }
         }
      }
      var d = this._data.getItemAt(id);
      var _loc2_;
      var _loc1_;
      if(d == undefined)
      {
         ank.utils.Logger.err("[moveSprite] Sprite inexistant");
      }
      else
      {
         _loc2_ = d.sprite_mc;
         if(bClearSequencer)
         {
            if(!bSlide)
            {
               _loc3_.clearAllNextActions();
            }
         }
         _loc3_.addAction(false,_loc2_,_loc2_.setPosition,[path[0]]);
         path.reverse();
         _loc1_ = path.length - 1;
         while(_loc1_ >= 0)
         {
            _loc3_.addAction(true,_loc2_,_loc2_.moveToCell,[_loc3_,path[_loc1_],_loc1_ == 0,bRun,bSlide]);
            _loc1_ = _loc1_ - 1;
         }
         _loc3_.execute();
      }
   }
   function launchVisualEffect(id, effectData, cellNum, displayType, spriteAnimation)
   {
      var _loc1_ = this._data.getItemAt(id);
      var _loc2_;
      var _loc3_;
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[launchVisualEffect] Sprite inexistant");
      }
      else
      {
         _loc2_ = _loc1_.sprite_mc;
         _loc3_ = _loc1_.sequencer;
         var bEffect = true;
         if(spriteAnimation == undefined || spriteAnimation < 0)
         {
            ank.utils.Logger.err("[launchVisualEffect] spriteAnimation incorrect");
         }
         else
         {
            var anim = "anim" + spriteAnimation;
            switch(displayType)
            {
               case 0:
                  var bWait = false;
                  bEffect = false;
                  break;
               case 10:
               case 11:
                  var bWait = false;
                  break;
               case 12:
                  var bWait = true;
                  break;
               case 20:
               case 21:
                  var bWait = false;
                  break;
               case 30:
               case 31:
                  var bWait = true;
                  break;
               case 40:
               case 41:
                  var bWait = true;
                  break;
               case 50:
                  var bWait = false;
                  break;
               case 51:
                  var bWait = true;
                  break;
               default:
                  var bWait = false;
                  bEffect = false;
            }
            _loc2_._ACTION = _loc1_;
            _loc2_._OBJECT = _loc2_;
            _loc3_.addAction(false,this,this.autoCalculateSpriteDirection,[id,cellNum]);
            _loc3_.addAction(true,_loc2_,_loc2_.setAnim,[anim]);
            if(bEffect)
            {
               _loc3_.addAction(bWait,this._battlefield.visualEffectHandler,this._battlefield.visualEffectHandler.addEffect,[_loc1_,effectData,cellNum,displayType]);
            }
            _loc3_.execute();
         }
      }
   }
   function autoCalculateSpriteDirection(id, cellNum)
   {
      var _loc2_ = this._data.getItemAt(id);
      var _loc1_;
      var _loc3_;
      if(_loc2_ == undefined)
      {
         ank.utils.Logger.err("[launchVisualEffect] Sprite inexistant");
      }
      else
      {
         _loc1_ = _loc2_.sprite_mc;
         _loc3_ = this._battlefield.mapHandler.getCellData(cellNum);
         var dir = ank.battlefield.utils.Pathfinding.getDirectionFromCoordinates(_loc1_._x,_loc1_._y,_loc3_.x,_loc3_.y,false);
         _loc1_.setDirection(dir);
      }
   }
   function setSpriteAnim(id, anim, bForced)
   {
      var _loc1_ = this._data.getItemAt(id);
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[setSpriteAnim] Sprite inexistant");
      }
      else
      {
         ank.utils.Timer.removeTimer(_loc1_.sprite_mc);
         _loc1_.sprite_mc.setAnim(anim,false,bForced);
      }
   }
   function setSpriteLoopAnim(id, anim, nTimer)
   {
      var _loc1_ = this._data.getItemAt(id);
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[setSpriteAnim] Sprite inexistant");
      }
      else
      {
         ank.utils.Timer.removeTimer(_loc1_.sprite_mc);
         _loc1_.sprite_mc.setAnim(anim,true);
         ank.utils.Timer.setTimer(_loc1_.sprite_mc,_loc1_.sprite_mc,_loc1_.sprite_mc.setAnim,nTimer,["static"]);
      }
   }
   function setSpriteGfx(id, file)
   {
      var _loc1_ = this._data.getItemAt(id);
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[setSpriteGfx] Sprite inexistant");
      }
      else if(file != _loc1_.gfxFile)
      {
         _loc1_.gfxFile = file;
         _loc1_.sprite_mc.draw();
      }
   }
   function setSpriteColorTransform(id, t)
   {
      var _loc1_ = this._data.getItemAt(id);
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[setSpriteColorTransform] Sprite inexistant");
      }
      else
      {
         _loc1_.sprite_mc.setColorTransform(t);
      }
   }
   function addSpriteExtraClip(id, clipFile, col)
   {
      var _loc1_ = this._data.getItemAt(id);
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[addSpriteExtraClip] Sprite inexistant");
      }
      else
      {
         _loc1_.sprite_mc.addExtraClip(clipFile,col);
      }
   }
   function removeSpriteExtraClip(id)
   {
      var _loc1_ = this._data.getItemAt(id);
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[removeSpriteExtraClip] Sprite inexistant");
      }
      else
      {
         _loc1_.sprite_mc.removeExtraClip();
      }
   }
   function showSpritePoints(id, value, col)
   {
      var _loc1_ = this._data.getItemAt(id);
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[showSpritePoints] Sprite inexistant");
      }
      else
      {
         _loc1_.sprite_mc.showPoints(value,col);
      }
   }
   function setSpriteGhostView(bool)
   {
      var _loc3_ = this;
      var _loc2_ = _loc3_._data.getItems();
      var _loc1_;
      for(var k in _loc2_)
      {
         _loc1_ = _loc3_._data.getItemAt(k);
         _loc1_.sprite_mc.setGhostView(bool);
      }
   }
}
