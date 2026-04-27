class ank.battlefield.MapHandler
{
   var _battlefield;
   var _container;
   var _datacenter;
   function MapHandler(b, c, d)
   {
      this.initialize(b,c,d);
   }
   function initialize(b, c, d)
   {
      var _loc1_ = this;
      _loc1_._battlefield = b;
      _loc1_._datacenter = d;
      _loc1_._container = c;
   }
   function buildMulti(mapData, coordX, coordY)
   {
      var CELL_WIDTH = ank.battlefield.Constants.CELL_WIDTH;
      var CELL_HALF_WIDTH = ank.battlefield.Constants.CELL_HALF_WIDTH;
      var CELL_HALF_HEIGHT = ank.battlefield.Constants.CELL_HALF_HEIGHT;
      var LEVEL_HEIGHT = ank.battlefield.Constants.LEVEL_HEIGHT;
      var startMaxDepth = this._container.maxDepth;
      var minDepth = this._container.minDepth + 1;
      var startX = ank.battlefield.Constants.DISPLAY_WIDTH * coordX;
      var startY = ank.battlefield.Constants.DISPLAY_HEIGHT * coordY;
      var x = -1;
      var y = 0;
      var dec = 0;
      var len = mapData.data.length;
      var c = this._container;
      var width = mapData.width - 1;
      var height = len / width;
      if(mapData.backgroundNum != 0)
      {
         var bg = this._container.Ground.attach(mapData.backgroundNum,"bg" + minDepth,minDepth);
         bg._x = startX;
         bg._y = startY;
      }
      var k = -1;
      var _loc2_;
      var _loc1_;
      var _loc3_;
      while(++k < len)
      {
         _loc2_ = startMaxDepth + k;
         if(x == width)
         {
            x = 0;
            y += 1;
            if(dec == 0)
            {
               dec = CELL_HALF_WIDTH;
               width -= 1;
            }
            else
            {
               dec = 0;
               width += 1;
            }
         }
         else
         {
            x++;
         }
         _loc1_ = mapData.data[k];
         if(_loc1_.active)
         {
            var cell_x = startX + x * CELL_WIDTH + dec;
            var cell_y = startY + y * CELL_HALF_HEIGHT - LEVEL_HEIGHT * (_loc1_.groundLevel - 7);
            if(_loc1_.layerGroundNum != 0)
            {
               _loc3_ = c.Ground.attach(_loc1_.layerGroundNum,"cell" + _loc2_,_loc2_);
               _loc3_._x = cell_x;
               _loc3_._y = cell_y;
               var rot = _loc1_.layerGroundRot;
               if(_loc1_.groundSlope != 1)
               {
                  _loc3_.gotoAndStop(_loc1_.groundSlope);
               }
               else if(rot != 0)
               {
                  var rotation = rot * 90;
                  if(rotation % 180)
                  {
                     _loc3_._yscale = 192.86;
                     _loc3_._xscale = 51.85;
                  }
                  _loc3_._rotation = rotation;
               }
               if(_loc1_.layerGroundFlip)
               {
                  _loc3_._xscale *= -1;
               }
            }
            if(_loc1_.layerObject1Num != 0)
            {
               _loc3_ = c.Object1.attach(_loc1_.layerObject1Num,"cell" + _loc2_,_loc2_);
               _loc3_._x = cell_x;
               _loc3_._y = cell_y;
               var rot = _loc1_.layerObject1Rot;
               if(_loc1_.groundSlope == 1 && rot != 0)
               {
                  _loc3_._rotation = rot * 90;
                  if(_loc3_._rotation % 180)
                  {
                     _loc3_._yscale = 192.86;
                     _loc3_._xscale = 51.85;
                  }
               }
               if(_loc1_.layerObject1Flip)
               {
                  _loc3_._xscale *= -1;
               }
            }
            if(_loc1_.layerObject2Num != 0)
            {
               _loc3_ = c.Object2.attach(_loc1_.layerObject2Num,"cell" + _loc2_,_loc2_);
               if(_loc1_.layerObject2Interactive)
               {
                  _loc3_.__proto__ = ank.battlefield.mc.InteractiveObject.prototype;
                  _loc3_.initialize(this._battlefield,_loc1_);
               }
               _loc3_._x = cell_x;
               _loc3_._y = cell_y;
               if(_loc1_.layerObject2Flip)
               {
                  _loc3_._xscale *= -1;
               }
            }
         }
      }
      c.maxDepth = startMaxDepth + k;
      c.minDepth = minDepth;
   }
   function build(mapData, cellNum)
   {
      this._datacenter.Map = mapData;
      var CELL_WIDTH = ank.battlefield.Constants.CELL_WIDTH;
      var CELL_HALF_WIDTH = ank.battlefield.Constants.CELL_HALF_WIDTH;
      var CELL_HALF_HEIGHT = ank.battlefield.Constants.CELL_HALF_HEIGHT;
      var LEVEL_HEIGHT = ank.battlefield.Constants.LEVEL_HEIGHT;
      var x = -1;
      var y = 0;
      var dec = 0;
      var len = mapData.data.length;
      var _loc3_ = this._container;
      var width = mapData.width - 1;
      var height = len / width;
      var bUpdate = cellNum != undefined;
      if(mapData.backgroundNum != 0)
      {
         this._container.Ground.attach(mapData.backgroundNum,"background",-1);
      }
      var _loc2_ = -1;
      var _loc1_;
      while(true)
      {
         if((_loc2_ = _loc2_ + 1) >= len)
         {
            if(!bUpdate)
            {
               this._container.applyMask();
               this._container.adjusteMap();
            }
            break;
         }
         if(x == width)
         {
            x = 0;
            y += 1;
            if(dec == 0)
            {
               dec = CELL_HALF_WIDTH;
               width -= 1;
            }
            else
            {
               dec = 0;
               width += 1;
            }
         }
         else
         {
            x++;
         }
         if(bUpdate)
         {
            if(_loc2_ < cellNum)
            {
               continue;
            }
            if(_loc2_ > cellNum)
            {
               break;
            }
         }
         _loc1_ = mapData.data[_loc2_];
         if(_loc1_.active)
         {
            var cell_x = x * CELL_WIDTH + dec;
            var cell_y = y * CELL_HALF_HEIGHT - LEVEL_HEIGHT * (_loc1_.groundLevel - 7);
            _loc1_.x = cell_x;
            _loc1_.y = cell_y;
            if(_loc1_.movement)
            {
               var cell = _loc3_.InteractionCell.attach(ank.battlefield.Constants.DEFAULT_CELL_CLIP_ID,"cell" + _loc2_,_loc2_);
               cell.__proto__ = ank.battlefield.mc.Cell.prototype;
               cell.initialize(this._battlefield,_loc2_);
               cell._x = cell_x;
               cell._y = cell_y;
               _loc1_.mc = cell;
               if(_loc1_.groundSlope != 1)
               {
                  cell.gotoAndStop(_loc1_.groundSlope);
               }
            }
            else
            {
               _loc3_.InteractionCell.clips["cell" + _loc2_].removeMovieClip();
            }
            if(_loc1_.layerGroundNum != 0)
            {
               var mc = _loc3_.Ground.attach(_loc1_.layerGroundNum,"cell" + _loc2_,_loc2_);
               mc._x = cell_x;
               mc._y = cell_y;
               var rot = _loc1_.layerGroundRot;
               if(_loc1_.groundSlope != 1)
               {
                  mc.gotoAndStop(_loc1_.groundSlope);
               }
               else if(rot != 0)
               {
                  var rotation = rot * 90;
                  if(rotation % 180)
                  {
                     mc._yscale = 192.86;
                     mc._xscale = 51.85;
                  }
                  mc._rotation = rotation;
               }
               if(_loc1_.layerGroundFlip)
               {
                  mc._xscale *= -1;
               }
            }
            else
            {
               _loc3_.Ground.clips["cell" + _loc2_].removeMovieClip();
            }
            if(_loc1_.layerObject1Num != 0)
            {
               var mc = _loc3_.Object1.attach(_loc1_.layerObject1Num,"cell" + _loc2_,_loc2_);
               mc._x = cell_x;
               mc._y = cell_y;
               var rot = _loc1_.layerObject1Rot;
               if(_loc1_.groundSlope == 1 && rot != 0)
               {
                  mc._rotation = rot * 90;
                  if(mc._rotation % 180)
                  {
                     mc._yscale = 192.86;
                     mc._xscale = 51.85;
                  }
               }
               if(_loc1_.layerObject1Flip)
               {
                  mc._xscale *= -1;
               }
            }
            else
            {
               _loc3_.Object1.clips["cell" + _loc2_].removeMovieClip();
            }
            if(_loc1_.layerObject2Num != 0)
            {
               if(typeof _loc1_.layerObject2Num == "string")
               {
                  var mc = _loc3_.Object2.clips.attachClassMovie(ank.battlefield.mc.InteractiveObject,"cell" + _loc2_,_loc2_ * 100);
                  mc.initialize(this._battlefield,_loc1_);
                  mc.loadExternalClip(_loc1_.layerObject2Num);
               }
               else
               {
                  var mc = _loc3_.Object2.attach(_loc1_.layerObject2Num,"cell" + _loc2_,_loc2_ * 100);
                  if(_loc1_.layerObject2Interactive)
                  {
                     mc.__proto__ = ank.battlefield.mc.InteractiveObject.prototype;
                     mc.initialize(this._battlefield,_loc1_);
                  }
               }
               mc._x = cell_x;
               mc._y = cell_y;
               if(_loc1_.layerObject2Flip)
               {
                  mc._xscale *= -1;
               }
               _loc1_.mcObject2 = mc;
            }
            else
            {
               _loc3_.Object2.clips["cell" + _loc2_].removeMovieClip();
               delete _loc1_.mcObject2;
            }
         }
      }
   }
   function updateCell(cellNum, newData, maskHexStr, nPermanentLevel)
   {
      var _loc3_ = newData;
      var _loc2_;
      var _loc1_;
      if(cellNum > this.getCellCount())
      {
         ank.utils.Logger.err("[updateCell] Cellule " + cellNum + " inexistante");
      }
      else
      {
         if(nPermanentLevel == undefined)
         {
            nPermanentLevel = 0;
         }
         else
         {
            nPermanentLevel = Number(nPermanentLevel);
         }
         _loc2_ = parseInt(maskHexStr,16);
         var bActive = (_loc2_ & 0x2000) != 0;
         var bLineOfSite = (_loc2_ & 0x1000) != 0;
         var bMovement = (_loc2_ & 0x0800) != 0;
         var bGroundLevel = (_loc2_ & 0x0400) != 0;
         var bGroundSlope = (_loc2_ & 0x0200) != 0;
         var bLayerGroundNum = (_loc2_ & 0x0100) != 0;
         var bLayerGroundFlip = (_loc2_ & 0x80) != 0;
         var bLayerGroundRot = (_loc2_ & 0x40) != 0;
         var bLayerObject1Num = (_loc2_ & 0x20) != 0;
         var bLayerObject1Flip = (_loc2_ & 0x10) != 0;
         var bLayerObject1Rot = (_loc2_ & 8) != 0;
         var bLayerObject2Num = (_loc2_ & 4) != 0;
         var bLayerObject2Flip = (_loc2_ & 2) != 0;
         var bLayerObject2Interactive = (_loc2_ & 1) != 0;
         _loc1_ = this._datacenter.Map.data[cellNum];
         if(nPermanentLevel > 0)
         {
            if(_loc1_.nPermanentLevel == 0)
            {
               var originalCellData = new ank.battlefield.datacenter.Cell();
               for(var k in _loc1_)
               {
                  originalCellData[k] = _loc1_[k];
               }
               this._datacenter.Map.originalsCellsBackup.addItemAt(cellNum,originalCellData);
               _loc1_.nPermanentLevel = nPermanentLevel;
            }
         }
         if(bActive)
         {
            _loc1_.active = _loc3_.active;
         }
         if(bLineOfSite)
         {
            _loc1_.lineOfSight = _loc3_.lineOfSight;
         }
         if(bMovement)
         {
            _loc1_.movement = _loc3_.movement;
         }
         if(bGroundLevel)
         {
            _loc1_.groundLevel = _loc3_.groundLevel;
         }
         if(bGroundSlope)
         {
            _loc1_.groundSlope = _loc3_.groundSlope;
         }
         if(bLayerGroundNum)
         {
            _loc1_.layerGroundNum = _loc3_.layerGroundNum;
         }
         if(bLayerGroundFlip)
         {
            _loc1_.layerGroundFlip = _loc3_.layerGroundFlip;
         }
         if(bLayerGroundRot)
         {
            _loc1_.layerGroundRot = _loc3_.layerGroundRot;
         }
         if(bLayerObject1Num)
         {
            _loc1_.layerObject1Num = _loc3_.layerObject1Num;
         }
         if(bLayerObject1Rot)
         {
            _loc1_.layerObject1Rot = _loc3_.layerObject1Rot;
         }
         if(bLayerObject1Flip)
         {
            _loc1_.layerObject1Flip = _loc3_.layerObject1Flip;
         }
         if(bLayerObject2Flip)
         {
            _loc1_.layerObject2Flip = _loc3_.layerObject2Flip;
         }
         if(bLayerObject2Interactive)
         {
            _loc1_.layerObject2Interactive = _loc3_.layerObject2Interactive;
         }
         if(bLayerObject2Num)
         {
            _loc1_.layerObject2Num = _loc3_.layerObject2Num;
         }
         this.build(this._datacenter.Map,cellNum);
      }
   }
   function initializeMap(nPermanentLevel)
   {
      var _loc1_ = nPermanentLevel;
      var _loc3_ = this;
      if(_loc1_ == undefined)
      {
         _loc1_ = Infinity;
      }
      else
      {
         _loc1_ = Number(_loc1_);
      }
      var map = _loc3_._datacenter.Map;
      var mapData = map.data;
      var _loc2_ = map.originalsCellsBackup.getItems();
      for(var k in _loc2_)
      {
         _loc3_.initializeCell(k,_loc1_);
      }
   }
   function initializeCell(cellNum, nPermanentLevel)
   {
      var _loc2_ = cellNum;
      var _loc3_ = nPermanentLevel;
      if(_loc3_ == undefined)
      {
         _loc3_ = Infinity;
      }
      else
      {
         _loc3_ = Number(_loc3_);
      }
      var _loc1_ = this._datacenter.Map;
      var mapData = _loc1_.data;
      var originalData = _loc1_.originalsCellsBackup.getItemAt(String(_loc2_));
      if(originalData == undefined)
      {
         ank.utils.Logger.err("La case est déjà dans son état init");
      }
      else if(mapData[_loc2_].nPermanentLevel <= _loc3_)
      {
         mapData[_loc2_] = originalData;
         this.build(_loc1_,_loc2_);
         _loc1_.originalsCellsBackup.removeItemAt(String(_loc2_));
      }
   }
   function setObject2Frame(cellNum, frame)
   {
      var _loc1_ = frame;
      var _loc2_ = cellNum;
      var _loc3_;
      if(typeof _loc1_ == "number" && _loc1_ < 1)
      {
         ank.utils.Logger.err("[setObject2Frame] frame " + _loc1_ + " incorecte");
      }
      else if(_loc2_ > this.getCellCount())
      {
         ank.utils.Logger.err("[setObject2Frame] Cellule " + _loc2_ + " inexistante");
      }
      else
      {
         var cellData = this._datacenter.Map.data[_loc2_];
         _loc3_ = cellData.mcObject2;
         _loc3_.gotoAndStop(_loc1_);
      }
   }
   function setObject2Interactive(cellNum, bInteractive, nPermanentLevel)
   {
      var _loc1_ = cellNum;
      var _loc3_ = this;
      var _loc2_;
      if(_loc1_ > _loc3_.getCellCount())
      {
         ank.utils.Logger.err("[setObject2State] Cellule " + _loc1_ + " inexistante");
      }
      else
      {
         var cellData = _loc3_._datacenter.Map.data[_loc1_];
         cellData.mcObject2.select(false);
         _loc2_ = new ank.battlefield.datacenter.Cell();
         _loc2_.layerObject2Interactive = bInteractive;
         _loc3_.updateCell(_loc1_,_loc2_,"1",nPermanentLevel);
      }
   }
   function getCellCount(Void)
   {
      return this._datacenter.Map.data.length;
   }
   function getCellData(cellNum)
   {
      return this._datacenter.Map.data[cellNum];
   }
   function getCellsData(Void)
   {
      return this._datacenter.Map.data;
   }
   function getWidth(Void)
   {
      return this._datacenter.Map.width;
   }
   function getHeight(Void)
   {
      return this._datacenter.Map.height;
   }
   function getCaseNum(x, y)
   {
      var _loc1_ = this.getWidth();
      return x * _loc1_ + y * (_loc1_ - 1);
   }
   function getCellHeight(cellNum)
   {
      var _loc1_ = this.getCellData(cellNum);
      var _loc2_ = !(_loc1_.groundSlope == undefined || _loc1_.groundSlope == 1) ? 0.5 : 0;
      var _loc3_ = _loc1_.groundLevel != undefined ? _loc1_.groundLevel - 7 : 0;
      return _loc3_ + _loc2_;
   }
}
