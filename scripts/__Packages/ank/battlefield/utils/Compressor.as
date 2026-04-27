class ank.battlefield.utils.Compressor
{
   function Compressor()
   {
      super();
   }
   static function uncompressMap(mapID, name, width, height, backgroundNum, data)
   {
      var _loc2_ = new ank.battlefield.datacenter.Map();
      _loc2_.id = Number(mapID);
      _loc2_.name = name;
      _loc2_.width = Number(width);
      _loc2_.height = Number(height);
      _loc2_.backgroundNum = backgroundNum;
      _loc2_.data = new Array();
      var _loc1_;
      var len = data.length;
      var _loc3_;
      _loc1_ = 0;
      while(_loc1_ < len)
      {
         _loc3_ = ank.battlefield.utils.Compressor.uncompressCell(data.substring(_loc1_,_loc1_ + 10),false,0);
         _loc2_.data.push(_loc3_);
         _loc1_ += 10;
      }
      return _loc2_;
   }
   static function uncompressCell(data, bForced, nPermanentLevel)
   {
      if(nPermanentLevel == undefined)
      {
         nPermanentLevel = 0;
      }
      else
      {
         nPermanentLevel = Number(nPermanentLevel);
      }
      var _loc3_;
      var _loc2_;
      var _loc1_;
      var cellData = new ank.battlefield.datacenter.Cell();
      _loc3_ = data.split("");
      _loc1_ = _loc3_.length - 1;
      _loc2_ = new Array();
      while(_loc1_ >= 0)
      {
         _loc2_[_loc1_] = _loc3_[_loc1_] > "_" ? ank.utils.Compressor._self._hashCodes["_" + _loc3_[_loc1_]] : ank.utils.Compressor._self._hashCodes[_loc3_[_loc1_]];
         _loc1_ = _loc1_ - 1;
      }
      cellData.active = !((_loc2_[0] & 0x20) >> 5) ? false : true;
      if(cellData.active || bForced)
      {
         cellData.nPermanentLevel = nPermanentLevel;
         cellData.lineOfSight = !(_loc2_[0] & 1) ? false : true;
         cellData.layerGroundRot = (_loc2_[1] & 0x30) >> 4;
         cellData.groundLevel = _loc2_[1] & 0x0F;
         cellData.movement = (_loc2_[2] & 0x38) >> 3;
         cellData.layerGroundNum = ((_loc2_[2] & 7) << 6) + _loc2_[3];
         cellData.groundSlope = (_loc2_[4] & 0x3C) >> 2;
         cellData.layerGroundFlip = !((_loc2_[4] & 2) >> 1) ? false : true;
         cellData.layerObject1Num = ((_loc2_[4] & 1) << 12) + (_loc2_[5] << 6) + _loc2_[6];
         cellData.layerObject1Rot = (_loc2_[7] & 0x30) >> 4;
         cellData.layerObject1Flip = !((_loc2_[7] & 8) >> 3) ? false : true;
         cellData.layerObject2Flip = !((_loc2_[7] & 4) >> 2) ? false : true;
         cellData.layerObject2Interactive = !((_loc2_[7] & 2) >> 1) ? false : true;
         cellData.layerObject2Num = ((_loc2_[7] & 1) << 12) + (_loc2_[8] << 6) + _loc2_[9];
      }
      return cellData;
   }
   static function compressPath(fullPathData)
   {
      var _loc3_ = new String();
      fullPathData = ank.battlefield.utils.Compressor.makeLightPath(fullPathData);
      var _loc2_;
      var _loc1_;
      var octet1;
      var octet2;
      var octet3;
      var len = fullPathData.length;
      _loc2_ = 0;
      while(_loc2_ < len)
      {
         _loc1_ = fullPathData[_loc2_];
         octet1 = _loc1_.dir & 7;
         octet2 = (_loc1_.num & 0x0FC0) >> 6;
         octet3 = _loc1_.num & 0x3F;
         _loc3_ += ank.utils.Compressor.encode64(octet1);
         _loc3_ += ank.utils.Compressor.encode64(octet2);
         _loc3_ += ank.utils.Compressor.encode64(octet3);
         _loc2_ = _loc2_ + 1;
      }
      return _loc3_;
   }
   static function makeLightPath(fullPathData)
   {
      var _loc2_ = fullPathData;
      var _loc3_;
      var _loc1_;
      if(_loc2_ != undefined)
      {
         var lightPath = new Array();
         _loc1_ = _loc2_.length - 1;
         while(_loc1_ >= 0)
         {
            if(_loc2_[_loc1_].dir != _loc3_)
            {
               lightPath.splice(0,0,_loc2_[_loc1_]);
               _loc3_ = _loc2_[_loc1_].dir;
            }
            _loc1_ = _loc1_ - 1;
         }
         return lightPath;
      }
      ank.utils.Logger.err("Le chemin est vide");
   }
   static function extractFullPath(mapHandler, compressedData)
   {
      var lightArray = new Array();
      var _loc2_ = compressedData.split("");
      var _loc1_;
      var len = compressedData.length;
      var cellNumMax = mapHandler.getCellCount();
      _loc1_ = 0;
      var _loc3_;
      while(true)
      {
         if(_loc1_ >= len)
         {
            return ank.battlefield.utils.Compressor.makeFullPath(mapHandler,lightArray);
         }
         _loc2_[_loc1_] = ank.utils.Compressor.decode64(_loc2_[_loc1_]);
         _loc2_[_loc1_ + 1] = ank.utils.Compressor.decode64(_loc2_[_loc1_ + 1]);
         _loc2_[_loc1_ + 2] = ank.utils.Compressor.decode64(_loc2_[_loc1_ + 2]);
         _loc3_ = (_loc2_[_loc1_ + 1] & 0x0F) << 6 | _loc2_[_loc1_ + 2];
         if(_loc3_ < 0)
         {
            ank.utils.Logger.err("Case pas sur carte");
            break;
         }
         if(_loc3_ > cellNumMax)
         {
            ank.utils.Logger.err("Case pas sur carte");
            break;
         }
         lightArray.push({num:_loc3_,dir:_loc2_[_loc1_]});
         _loc1_ += 3;
      }
   }
   static function makeFullPath(mapHandler, lightArray)
   {
      var path = new Array();
      var _loc1_;
      var _loc2_;
      var cellNum = 0;
      var w = mapHandler.getWidth();
      var depl = [1,w,w * 2 - 1,w - 1,-1,- w,- w * 2 + 1,- (w - 1)];
      _loc1_ = lightArray[0].num;
      path[cellNum] = _loc1_;
      _loc2_ = 1;
      var _loc3_;
      while(_loc2_ < lightArray.length)
      {
         _loc3_ = lightArray[_loc2_].num;
         var dir = lightArray[_loc2_].dir;
         var imax = 2 * w + 1;
         while(path[cellNum] != _loc3_)
         {
            _loc1_ += depl[dir];
            path[++cellNum] = _loc1_;
            if(--imax < 0)
            {
               ank.utils.Logger.err("Chemin impossible");
               return;
            }
         }
         _loc1_ = _loc3_;
         _loc2_ = _loc2_ + 1;
      }
      return path;
   }
}
