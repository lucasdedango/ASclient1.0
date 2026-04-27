class ank.battlefield.mc.Zone extends MovieClip
{
   var _map;
   var zone_mc;
   static var ALPHA = 50;
   function Zone(map)
   {
      super();
      this.initialize(map);
   }
   function initialize(map)
   {
      this._map = map;
      this.clear();
   }
   function clear()
   {
      this.createEmptyMovieClip("zone_mc",10);
   }
   function remove()
   {
      this.removeMovieClip();
   }
   function drawCircle(radius, col, centerCellNum)
   {
      var _loc2_ = ank.battlefield.Constants.CELL_COORD;
      var mw = this._map.getWidth();
      var cellNum = centerCellNum - radius * mw;
      var _loc3_;
      var j;
      var _loc1_;
      var z;
      var xStart = (- radius) * ank.battlefield.Constants.CELL_HALF_WIDTH;
      var yStart = (- radius) * ank.battlefield.Constants.CELL_HALF_HEIGHT;
      z = this.zone_mc;
      z.beginFill(col,ank.battlefield.mc.Zone.ALPHA);
      z.lineStyle(1,col,100);
      _loc1_ = this.getGroundData(cellNum);
      z.moveTo(xStart + _loc2_[_loc1_.gf][0][0],yStart + _loc2_[_loc1_.gf][0][1] - _loc1_.gl * 20);
      _loc3_ = 0;
      while(_loc3_ < radius + 1)
      {
         if(_loc3_ != 0)
         {
            cellNum++;
         }
         _loc1_ = this.getGroundData(cellNum);
         z.lineTo(xStart + _loc2_[_loc1_.gf][1][0] + _loc3_ * ank.battlefield.Constants.CELL_WIDTH,yStart + _loc2_[_loc1_.gf][1][1] - _loc1_.gl * 20);
         z.lineTo(xStart + _loc2_[_loc1_.gf][2][0] + _loc3_ * ank.battlefield.Constants.CELL_WIDTH,yStart + _loc2_[_loc1_.gf][2][1] - _loc1_.gl * 20);
         _loc3_ = _loc3_ + 1;
      }
      _loc3_ -= 1;
      j = 0;
      while(j < radius)
      {
         cellNum += mw * 2 - 1;
         _loc1_ = this.getGroundData(cellNum);
         z.lineTo(xStart + _loc2_[_loc1_.gf][1][0] + _loc3_ * ank.battlefield.Constants.CELL_WIDTH,yStart + _loc2_[_loc1_.gf][1][1] + (j + 1) * ank.battlefield.Constants.CELL_HEIGHT - _loc1_.gl * 20);
         z.lineTo(xStart + _loc2_[_loc1_.gf][2][0] + _loc3_ * ank.battlefield.Constants.CELL_WIDTH,yStart + _loc2_[_loc1_.gf][2][1] + (j + 1) * ank.battlefield.Constants.CELL_HEIGHT - _loc1_.gl * 20);
         j++;
      }
      _loc3_ = radius;
      while(_loc3_ >= 0)
      {
         if(_loc3_ != radius)
         {
            cellNum--;
         }
         _loc1_ = this.getGroundData(cellNum);
         z.lineTo(xStart + _loc2_[_loc1_.gf][3][0] + _loc3_ * ank.battlefield.Constants.CELL_WIDTH,yStart + _loc2_[_loc1_.gf][3][1] + j * ank.battlefield.Constants.CELL_HEIGHT - _loc1_.gl * 20);
         z.lineTo(xStart + _loc2_[_loc1_.gf][0][0] + _loc3_ * ank.battlefield.Constants.CELL_WIDTH,yStart + _loc2_[_loc1_.gf][0][1] + j * ank.battlefield.Constants.CELL_HEIGHT - _loc1_.gl * 20);
         _loc3_ = _loc3_ - 1;
      }
      _loc3_ += 1;
      j = radius - 1;
      while(j >= 0)
      {
         cellNum -= mw * 2 - 1;
         _loc1_ = this.getGroundData(cellNum);
         z.lineTo(xStart + _loc2_[_loc1_.gf][3][0] + _loc3_ * ank.battlefield.Constants.CELL_WIDTH,yStart + _loc2_[_loc1_.gf][3][1] + j * ank.battlefield.Constants.CELL_HEIGHT - _loc1_.gl * 20);
         z.lineTo(xStart + _loc2_[_loc1_.gf][0][0] + _loc3_ * ank.battlefield.Constants.CELL_WIDTH,yStart + _loc2_[_loc1_.gf][0][1] + j * ank.battlefield.Constants.CELL_HEIGHT - _loc1_.gl * 20);
         j--;
      }
      z.endFill();
   }
   function drawCross(radius, col, centerCellNum)
   {
      var _loc3_ = ank.battlefield.Constants.CELL_COORD;
      var mw = this._map.getWidth();
      var cellNum = centerCellNum;
      var _loc1_;
      var _loc2_;
      var z;
      z = this.zone_mc;
      z.beginFill(col,ank.battlefield.mc.Zone.ALPHA);
      z.lineStyle(1,col,100);
      _loc2_ = this.getGroundData(cellNum);
      z.moveTo(_loc3_[_loc2_.gf][0][0],_loc3_[_loc2_.gf][0][1] - _loc2_.gl * 20);
      _loc1_ = 1;
      while(_loc1_ <= radius)
      {
         cellNum -= mw;
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][0][0] - _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][0][1] - _loc2_.gl * 20 - _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ + 1;
      }
      _loc1_ = radius;
      while(_loc1_ >= 0)
      {
         if(_loc1_ != radius)
         {
            cellNum += mw;
         }
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][1][0] - _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][1][1] - _loc2_.gl * 20 - _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ - 1;
      }
      _loc1_ = 1;
      while(_loc1_ <= radius)
      {
         cellNum -= mw - 1;
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][1][0] + _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][1][1] - _loc2_.gl * 20 - _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ + 1;
      }
      _loc1_ = radius;
      while(_loc1_ >= 0)
      {
         if(_loc1_ != radius)
         {
            cellNum += mw - 1;
         }
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][2][0] + _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][2][1] - _loc2_.gl * 20 - _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ - 1;
      }
      _loc1_ = 1;
      while(_loc1_ <= radius)
      {
         cellNum += mw;
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][2][0] + _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][2][1] - _loc2_.gl * 20 + _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ + 1;
      }
      _loc1_ = radius;
      while(_loc1_ >= 0)
      {
         if(_loc1_ != radius)
         {
            cellNum -= mw;
         }
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][3][0] + _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][3][1] - _loc2_.gl * 20 + _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ - 1;
      }
      _loc1_ = 1;
      while(_loc1_ <= radius)
      {
         cellNum += mw - 1;
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][3][0] - _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][3][1] - _loc2_.gl * 20 + _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ + 1;
      }
      _loc1_ = radius;
      while(_loc1_ > 0)
      {
         if(_loc1_ != radius)
         {
            cellNum -= mw - 1;
         }
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][0][0] - _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][0][1] - _loc2_.gl * 20 + _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ - 1;
      }
      z.endFill();
   }
   function drawLine(length, col, extremCellNum, refCellNum)
   {
      var _loc3_ = ank.battlefield.Constants.CELL_COORD;
      var mw = this._map.getWidth();
      var cellNum = extremCellNum;
      var _loc1_;
      var j;
      var _loc2_;
      var z;
      var radius = [0,0,0,0,0,0,0,0];
      if(refCellNum != extremCellNum)
      {
         var dir = ank.battlefield.utils.Pathfinding.getDirection(this._map,refCellNum,extremCellNum);
         radius[dir] = length;
      }
      z = this.zone_mc;
      z.beginFill(col,ank.battlefield.mc.Zone.ALPHA);
      z.lineStyle(1,col,100);
      _loc2_ = this.getGroundData(cellNum);
      z.moveTo(_loc3_[_loc2_.gf][0][0],_loc3_[_loc2_.gf][0][1] - _loc2_.gl * 20);
      _loc1_ = 1;
      while(_loc1_ <= radius[5])
      {
         cellNum -= mw;
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][0][0] - _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][0][1] - _loc2_.gl * 20 - _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ + 1;
      }
      _loc1_ = radius[5];
      while(_loc1_ >= 0)
      {
         if(_loc1_ != radius[5])
         {
            cellNum += mw;
         }
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][1][0] - _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][1][1] - _loc2_.gl * 20 - _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ - 1;
      }
      _loc1_ = 1;
      while(_loc1_ <= radius[7])
      {
         cellNum -= mw - 1;
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][1][0] + _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][1][1] - _loc2_.gl * 20 - _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ + 1;
      }
      _loc1_ = radius[7];
      while(_loc1_ >= 0)
      {
         if(_loc1_ != radius[7])
         {
            cellNum += mw - 1;
         }
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][2][0] + _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][2][1] - _loc2_.gl * 20 - _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ - 1;
      }
      _loc1_ = 1;
      while(_loc1_ <= radius[1])
      {
         cellNum += mw;
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][2][0] + _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][2][1] - _loc2_.gl * 20 + _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ + 1;
      }
      _loc1_ = radius[1];
      while(_loc1_ >= 0)
      {
         if(_loc1_ != radius[1])
         {
            cellNum -= mw;
         }
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][3][0] + _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][3][1] - _loc2_.gl * 20 + _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ - 1;
      }
      _loc1_ = 1;
      while(_loc1_ <= radius[3])
      {
         cellNum += mw - 1;
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][3][0] - _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][3][1] - _loc2_.gl * 20 + _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ + 1;
      }
      _loc1_ = radius[3];
      while(_loc1_ > 0)
      {
         if(_loc1_ != radius[3])
         {
            cellNum -= mw - 1;
         }
         _loc2_ = this.getGroundData(cellNum);
         z.lineTo(_loc3_[_loc2_.gf][0][0] - _loc1_ * ank.battlefield.Constants.CELL_HALF_WIDTH,_loc3_[_loc2_.gf][0][1] - _loc2_.gl * 20 + _loc1_ * ank.battlefield.Constants.CELL_HALF_HEIGHT);
         _loc1_ = _loc1_ - 1;
      }
      z.endFill();
   }
   function getGroundData(cellNum)
   {
      var _loc1_ = this._map.getCellData(cellNum);
      var gf = _loc1_.groundSlope != undefined ? _loc1_.groundSlope : 1;
      var gl = _loc1_.groundLevel != undefined ? _loc1_.groundLevel - 7 : 0;
      return {gf:gf,gl:gl};
   }
}
