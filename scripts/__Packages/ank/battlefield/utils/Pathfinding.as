class ank.battlefield.utils.Pathfinding
{
   function Pathfinding()
   {
   }
   static function pathFind(mapHandler, cellBegin, cellEnd, bAllDirections, bIsFight, maxLength, bIgnoreSprites)
   {
      if(maxLength == undefined)
      {
         maxLength = 500;
      }
      if(bIsFight == undefined)
      {
         bIsFight = false;
      }
      if(bIgnoreSprites == undefined)
      {
         bIgnoreSprites = false;
      }
      var mapData = mapHandler.getCellsData();
      var _loc3_ = new Object();
      var closeList = new Object();
      var bOpenListEmpty = false;
      var c = _loc3_["cell" + cellBegin] = new Object();
      c.num = cellBegin;
      c.g = 0;
      c.v = 0;
      c.h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler,cellBegin,cellEnd);
      c.f = c.h;
      c.a = mapData[cellBegin].groundLevel;
      c.s = mapData[cellBegin].groundSlope;
      c.parent = null;
      var width = mapHandler.getWidth();
      var height = mapHandler.getHeight();
      if(bAllDirections)
      {
         var depl = [1,width,width * 2 - 1,width - 1,-1,- width,- width * 2 + 1,- (width - 1)];
         var deplInc = [1.5,1,1.5,1,1.5,1,1.5,1];
      }
      else
      {
         var depl = [width,width - 1,- width,- (width - 1)];
         var deplInc = [1,1,1,1];
      }
      var _loc1_;
      var _loc2_;
      while(!bOpenListEmpty)
      {
         var index = null;
         var min = 5000;
         for(var a in _loc3_)
         {
            if(_loc3_[a].f < min)
            {
               min = _loc3_[a].f;
               index = a;
            }
         }
         _loc1_ = _loc3_[index];
         delete _loc3_[index];
         if(_loc1_.num == cellEnd)
         {
            var path = new Array();
            while(_loc1_.num != cellBegin)
            {
               path.splice(0,0,{num:_loc1_.num,dir:ank.battlefield.utils.Pathfinding.getDirection(mapHandler,_loc1_.parent.num,_loc1_.num)});
               _loc1_ = _loc1_.parent;
            }
            return path;
         }
         var len = depl.length;
         var bOnthelast = false;
         var d;
         d = 0;
         while(d < len)
         {
            var nextCell = _loc1_.num + depl[d];
            if(Math.abs(mapData[nextCell].x - mapData[_loc1_.num].x) <= 53)
            {
               var cellData = mapData[nextCell];
               var nexts = cellData.groundSlope;
               var nexta = cellData.groundLevel;
               if(nextCell == cellEnd && cellData.movement == 1)
               {
                  bOnthelast = true;
               }
               var bNotSpriteOn = !bIgnoreSprites ? (cellData.SpriteOnID == undefined ? true : false) : true;
               var bSlopeOk = true;
               if(bSlopeOk && cellData.active && (cellData.movement > 1 || bOnthelast) && bNotSpriteOn)
               {
                  _loc2_ = "cell" + nextCell;
                  var newv = _loc1_.v + deplInc[d] + (5 - cellData.movement) / 3 + (d == _loc1_.d ? 0 : 0.1);
                  var newg = _loc1_.g + deplInc[d];
                  var oldv = null;
                  if(_loc3_[_loc2_])
                  {
                     oldv = _loc3_[_loc2_].v;
                  }
                  else if(closeList[_loc2_])
                  {
                     oldv = closeList[_loc2_].v;
                  }
                  if((oldv == null || oldv > newv) && newg <= maxLength)
                  {
                     if(closeList[_loc2_])
                     {
                        delete closeList[_loc2_];
                     }
                     if(!_loc3_[_loc2_])
                     {
                        _loc3_[_loc2_] = new Object();
                     }
                     var cell = _loc3_[_loc2_];
                     cell.num = nextCell;
                     cell.g = newg;
                     cell.v = newv;
                     cell.h = ank.battlefield.utils.Pathfinding.goalDistEstimate(mapHandler,nextCell,cellEnd);
                     cell.f = cell.v + cell.h;
                     cell.d = d;
                     cell.a = nexta;
                     cell.s = nexts;
                     cell.parent = _loc1_;
                  }
               }
            }
            d++;
         }
         closeList["cell" + _loc1_.num] = new Object();
         var cell = closeList["cell" + _loc1_.num];
         for(var a in _loc1_)
         {
            cell[a] = _loc1_[a];
         }
         bOpenListEmpty = true;
         for(var a in _loc3_)
         {
            bOpenListEmpty = false;
            break;
         }
      }
      return null;
   }
   static function goalDistEstimate(mapHandler, begin, end)
   {
      var _loc2_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,begin);
      var _loc1_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,end);
      var distx = Math.abs(_loc2_.x - _loc1_.x);
      var _loc3_ = Math.abs(_loc2_.y - _loc1_.y);
      var dist = Math.sqrt(Math.pow(distx,2) + Math.pow(_loc3_,2));
      return dist;
   }
   static function goalDistance(mapHandler, cell1Num, cell2Num)
   {
      var _loc2_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,cell1Num);
      var _loc1_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,cell2Num);
      var distx = Math.abs(_loc2_.x - _loc1_.x);
      var _loc3_ = Math.abs(_loc2_.y - _loc1_.y);
      var dist = Number(distx + _loc3_);
      return dist;
   }
   static function getCaseCoordonnee(mapHandler, num)
   {
      var _loc1_ = mapHandler.getWidth();
      var _loc3_ = Math.floor(num / (_loc1_ * 2 - 1));
      var _Column = num - _loc3_ * (_loc1_ * 2 - 1);
      var column = _Column % _loc1_;
      var _loc2_ = new Object();
      _loc2_.y = _loc3_ - column;
      _loc2_.x = (num - (_loc1_ - 1) * _loc2_.y) / _loc1_;
      return _loc2_;
   }
   static function getDirection(mapHandler, cell1, cell2)
   {
      var width = mapHandler.getWidth();
      var _loc2_ = [1,width,width * 2 - 1,width - 1,-1,- width,- width * 2 + 1,- (width - 1)];
      var _loc3_ = cell2 - cell1;
      var _loc1_ = 7;
      while(_loc1_ >= 0)
      {
         if(_loc2_[_loc1_] == _loc3_)
         {
            return _loc1_;
         }
         _loc1_ = _loc1_ - 1;
      }
      var p1 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,cell1);
      var p2 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,cell2);
      var xDiff = p2.x - p1.x;
      var yDiff = p2.y - p1.y;
      if(xDiff == 0)
      {
         if(yDiff > 0)
         {
            return 3;
         }
         return 7;
      }
      if(xDiff > 0)
      {
         return 1;
      }
      return 5;
   }
   static function getDirectionFromCoordinates(x1, y1, x2, y2, bAllDirections)
   {
      var _loc1_ = Math.atan2(y2 - y1,x2 - x1);
      if(bAllDirections)
      {
         if(_loc1_ >= -0.39269908169872414 && _loc1_ < 0.39269908169872414)
         {
            return 0;
         }
         if(_loc1_ >= 0.39269908169872414 && _loc1_ < 1.0471975511965976)
         {
            return 1;
         }
         if(_loc1_ >= 1.0471975511965976 && _loc1_ < 2.0943951023931953)
         {
            return 2;
         }
         if(_loc1_ >= 2.0943951023931953 && _loc1_ < 2.748893571891069)
         {
            return 3;
         }
         if(_loc1_ >= 2.748893571891069 || _loc1_ < -2.748893571891069)
         {
            return 4;
         }
         if(_loc1_ >= -2.748893571891069 && _loc1_ < -2.0943951023931953)
         {
            return 5;
         }
         if(_loc1_ >= -2.0943951023931953 && _loc1_ < -1.0471975511965976)
         {
            return 6;
         }
         if(_loc1_ >= -1.0471975511965976 && _loc1_ < -0.39269908169872414)
         {
            return 7;
         }
      }
      else
      {
         if(_loc1_ >= 0 && _loc1_ < 1.5707963267948966)
         {
            return 1;
         }
         if(_loc1_ >= 1.5707963267948966 && _loc1_ <= 3.141592653589793)
         {
            return 3;
         }
         if(_loc1_ >= -3.141592653589793 && _loc1_ < -1.5707963267948966)
         {
            return 5;
         }
         if(_loc1_ >= -1.5707963267948966 && _loc1_ < 0)
         {
            return 7;
         }
      }
      return 1;
   }
   static function getSlopeOk(slope1, level1, slope2, level2, dir)
   {
      var _loc1_ = slope2;
      var _loc2_ = slope1;
      var _loc3_ = level2;
      switch(dir)
      {
         case 0:
            if(((_loc2_ - 1 & 2) >> 1) + level1 != (_loc1_ - 1 & 1) + _loc3_)
            {
               return false;
            }
            break;
         case 1:
            if(((_loc2_ - 1 & 4) >> 2) + level1 != ((_loc1_ - 1 & 2) >> 1) + _loc3_)
            {
               return false;
            }
            if(((_loc2_ - 1 & 8) >> 3) + level1 != (_loc1_ - 1 & 1) + _loc3_)
            {
               return false;
            }
            break;
         case 2:
            if(((_loc2_ - 1 & 8) >> 3) + level1 != ((_loc1_ - 1 & 2) >> 1) + _loc3_)
            {
               return false;
            }
            break;
         case 3:
            if(((_loc2_ - 1 & 8) >> 3) + level1 != ((_loc1_ - 1 & 4) >> 2) + _loc3_)
            {
               return false;
            }
            if((_loc2_ - 1 & 1) + level1 != ((_loc1_ - 1 & 2) >> 1) + _loc3_)
            {
               return false;
            }
            break;
         case 4:
            if((_loc2_ - 1 & 1) + level1 != ((_loc1_ - 1 & 4) >> 2) + _loc3_)
            {
               return false;
            }
            break;
         case 5:
            if((_loc2_ - 1 & 1) + level1 != ((_loc1_ - 1 & 8) >> 3) + _loc3_)
            {
               return false;
            }
            if(((_loc2_ - 1 & 2) >> 1) + level1 != ((_loc1_ - 1 & 4) >> 2) + _loc3_)
            {
               return false;
            }
            break;
         case 6:
            if(((_loc2_ - 1 & 2) >> 1) + level1 != ((_loc1_ - 1 & 8) >> 3) + _loc3_)
            {
               return false;
            }
            break;
         case 7:
            if(((_loc2_ - 1 & 2) >> 1) + level1 != (_loc1_ - 1 & 1) + _loc3_)
            {
               return false;
            }
            if(((_loc2_ - 1 & 4) >> 2) + level1 != ((_loc1_ - 1 & 8) >> 3) + _loc3_)
            {
               return false;
            }
      }
      return true;
   }
   static function checkView(mapHandler, cell1, cell2)
   {
      var p1 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,cell1);
      var p2 = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,cell2);
      var cd1 = mapHandler.getCellData(cell1);
      var cd2 = mapHandler.getCellData(cell2);
      var ph1 = !cd1.SpriteOnID ? 0 : 1.5;
      var ph2 = !cd2.SpriteOnID ? 0 : 1.5;
      p1.z = mapHandler.getCellHeight(cell1) + ph1;
      p2.z = mapHandler.getCellHeight(cell2) + ph2;
      var zDiff = p2.z - p1.z;
      var d = Math.max(Math.abs(p1.y - p2.y),Math.abs(p1.x - p2.x));
      var a = (p1.y - p2.y) / (p1.x - p2.x);
      var b = p1.y - a * p1.x;
      var dx = p2.x - p1.x >= 0 ? 1 : -1;
      var _loc2_ = p2.y - p1.y >= 0 ? 1 : -1;
      var lastY = p1.y;
      var lastX = p1.x;
      var x2dx = p2.x * dx;
      var y2dy = p2.y * _loc2_;
      var destY;
      var scanY;
      var destX;
      var scanX;
      var y;
      var _loc1_;
      var _loc3_;
      var moveX;
      _loc3_ = p1.x + 0.5 * dx;
      while(_loc3_ * dx <= x2dx)
      {
         y = a * _loc3_ + b;
         if(_loc2_ > 0)
         {
            destY = Math.round(y);
            scanY = Math.ceil(y - 0.5);
         }
         else
         {
            destY = Math.ceil(y - 0.5);
            scanY = Math.round(y);
         }
         _loc1_ = lastY;
         while(_loc1_ * _loc2_ <= scanY * _loc2_)
         {
            if(!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler,_loc3_ - dx / 2,_loc1_,false,p1,p2,zDiff,d))
            {
               return false;
            }
            _loc1_ += _loc2_;
         }
         lastY = destY;
         _loc3_ += dx;
      }
      _loc1_ = lastY;
      while(_loc1_ * _loc2_ <= p2.y * _loc2_)
      {
         if(!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler,_loc3_ - 0.5 * dx,_loc1_,false,p1,p2,zDiff,d))
         {
            return false;
         }
         _loc1_ += _loc2_;
      }
      if(!ank.battlefield.utils.Pathfinding.checkCellView(mapHandler,_loc3_ - 0.5 * dx,_loc1_ - _loc2_,true,p1,p2,zDiff,d))
      {
         return false;
      }
      return true;
   }
   static function checkCellView(mapHandler, x, y, bool, p1, p2, zDiff, d)
   {
      var _loc1_ = ank.battlefield.utils.Pathfinding.getCaseNum(mapHandler,x,y);
      var _loc2_ = mapHandler.getCellData(_loc1_);
      var _loc3_ = Math.max(Math.abs(p1.y - y),Math.abs(p1.x - x));
      var eh = _loc3_ / d * zDiff + p1.z;
      var h = mapHandler.getCellHeight(_loc1_);
      var bPlayerOn = !(_loc2_.SpriteOnID == undefined || _loc3_ == 0 || bool || p2.x == x && p2.y == y) ? true : false;
      if(_loc2_.lineOfSight && h <= eh && !bPlayerOn)
      {
         return true;
      }
      if(bool)
      {
         return true;
      }
      return false;
   }
   static function getCaseNum(mapHandler, x, y)
   {
      var _loc1_ = mapHandler.getWidth();
      return x * _loc1_ + y * (_loc1_ - 1);
   }
   static function checkAlign(mapHandler, cell1, cell2)
   {
      var _loc2_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,cell1);
      var _loc1_ = ank.battlefield.utils.Pathfinding.getCaseCoordonnee(mapHandler,cell2);
      if(_loc2_.x == _loc1_.x)
      {
         return true;
      }
      if(_loc2_.y == _loc1_.y)
      {
         return true;
      }
      return false;
   }
   static function checkRange(mapHandler, cell1, cell2, bLineOnly, range, rangeModerator)
   {
      var _loc2_ = range;
      var _loc3_ = rangeModerator;
      var _loc1_;
      if(_loc3_ == 0)
      {
         _loc1_ = Number(_loc2_);
      }
      else
      {
         _loc1_ = Number(_loc2_) + Number(_loc3_);
         if(_loc1_ < 1)
         {
            if(Number(_loc2_) == 0)
            {
               _loc1_ = 0;
            }
            else
            {
               _loc1_ = 1;
            }
         }
         if(Number(_loc3_) > 0 && Number(_loc2_) == 0)
         {
            _loc1_ = 0;
         }
      }
      if(bLineOnly)
      {
         if(!ank.battlefield.utils.Pathfinding.checkAlign(mapHandler,cell1,cell2))
         {
            return false;
         }
      }
      if(ank.battlefield.utils.Pathfinding.goalDistance(mapHandler,cell1,cell2) > _loc1_)
      {
         return false;
      }
      return true;
   }
}
