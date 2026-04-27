class dofus.datacenter.Item extends Object
{
   var _effects;
   var _id;
   var _position;
   var _priceMultiplicator;
   var _quantity;
   var _sEffects;
   var _unicid;
   function Item(id, unicid, quantity, position, effects, price)
   {
      super();
      this.initialize(id,unicid,quantity,position,effects,price);
   }
   function initialize(id, unicid, quantity, position, effects, price)
   {
      var _loc1_ = this;
      _loc1_._id = id;
      _loc1_._unicid = unicid;
      _loc1_._quantity = quantity != undefined ? quantity : 1;
      _loc1_._position = position != undefined ? position : -1;
      if(price != undefined)
      {
         _loc1_._price = price;
      }
      _loc1_.setEffects(effects);
   }
   function setEffects(compressedData)
   {
      this._sEffects = compressedData;
      this._effects = new Array();
      var effectsArray = compressedData.split(",");
      var _loc3_ = 0;
      var _loc1_;
      var _loc2_;
      while(_loc3_ < effectsArray.length)
      {
         _loc1_ = effectsArray[_loc3_].split("#");
         _loc2_ = new Object();
         _loc2_.type = parseInt(_loc1_[0],16);
         if(_loc1_[1] == undefined)
         {
            _loc2_.bDescription = false;
         }
         else
         {
            _loc2_.bDescription = true;
            _loc2_.param1 = _loc1_[1] != "0" ? parseInt(_loc1_[1],16) : undefined;
            _loc2_.param2 = _loc1_[2] != "0" ? parseInt(_loc1_[2],16) : undefined;
            _loc2_.param3 = _loc1_[3] != "0" ? parseInt(_loc1_[3],16) : undefined;
         }
         this._effects.push(_loc2_);
         _loc3_ = _loc3_ + 1;
      }
   }
   function clone()
   {
      var _loc1_ = this;
      return new dofus.datacenter.Item(_loc1_._id,_loc1_._unicid,_loc1_._quantity,_loc1_._position,_loc1_._sEffects);
   }
   function get ID()
   {
      return this._id;
   }
   function get unicID()
   {
      return this._unicid;
   }
   function get compressedEffects()
   {
      return this._sEffects;
   }
   function set Quantity(value)
   {
      if(isNaN(Number(value)))
      {
         return;
      }
      this._quantity = Number(value);
   }
   function get Quantity()
   {
      return this._quantity;
   }
   function get label()
   {
      return this._quantity <= 1 ? undefined : this._quantity;
   }
   function set Position(value)
   {
      if(isNaN(Number(value)))
      {
         return;
      }
      this._position = Number(value);
   }
   function get Position()
   {
      return this._position;
   }
   function set PriceMultiplicator(value)
   {
      if(isNaN(Number(value)))
      {
         return;
      }
      this._priceMultiplicator = Number(value);
   }
   function get PriceMultiplicator()
   {
      return this._priceMultiplicator;
   }
   function get name()
   {
      return ank.utils.PatternDecoder.getDescription(this.unicText.n,_global.getItemUnicStringText());
   }
   function get description()
   {
      return ank.utils.PatternDecoder.getDescription(this.unicText.d,_global.getItemUnicStringText());
   }
   function get unicText()
   {
      return _global.getItemUnicText(this._unicid);
   }
   function get type()
   {
      return Number(this.unicText.t);
   }
   function get typeText()
   {
      return _global.getItemTypeText(this.type);
   }
   function get superType()
   {
      return this.typeText.t;
   }
   function get superTypeText()
   {
      return _global.getItemSuperTypeText(this.superType);
   }
   function get iconFile()
   {
      return dofus.Constants.ITEMS_PATH + this.type + "/" + this.gfx + ".swf";
   }
   function get effects()
   {
      var _loc2_ = _global;
      var _loc3_ = new Array();
      var _loc1_;
      if(this._effects.length == 0)
      {
         var eff = this.unicText.e;
         var i;
         i = 0;
         while(i < eff.length)
         {
            _loc1_ = eff[i];
            switch(_loc1_[0])
            {
               case 601:
                  var oMapInfo = _loc2_.getMapText(_loc1_[2]);
                  var sSubAreaName = _loc2_.getMapSubAreaText(oMapInfo.sa);
                  _loc3_.push(ank.utils.PatternDecoder.getDescription(_loc2_.getEffectText(_loc1_[0]).d,new Array(oMapInfo.sa,oMapInfo.x,oMapInfo.y)));
                  break;
               case 614:
                  var oJobInfo = _loc2_.getJobText(_loc1_[2]);
                  _loc3_.push(ank.utils.PatternDecoder.getDescription(_loc2_.getEffectText(_loc1_[0]).d,new Array(_loc1_[3],oJobInfo.n)));
                  break;
               default:
                  _loc3_.push(ank.utils.PatternDecoder.getDescription(_loc2_.getEffectText(_loc1_[0]).d,new Array(_loc1_[1],_loc1_[2],_loc1_[3])));
            }
            i++;
         }
      }
      else
      {
         var i;
         i = 0;
         while(i < this._effects.length)
         {
            _loc1_ = this._effects[i];
            if(_loc1_.bDescription)
            {
               switch(_loc1_.type)
               {
                  case 601:
                     var oMapInfo = _loc2_.getMapText(_loc1_.param2);
                     var sSubAreaName = _loc2_.getMapSubAreaText(oMapInfo.sa);
                     _loc3_.push(ank.utils.PatternDecoder.getDescription(_loc2_.getEffectText(_loc1_.type).d,new Array(sSubAreaName,oMapInfo.x,oMapInfo.y)));
                     break;
                  case 614:
                     var oJobInfo = _loc2_.getJobText(_loc1_.param2);
                     _loc3_.push(ank.utils.PatternDecoder.getDescription(_loc2_.getEffectText(_loc1_.type).d,new Array(_loc1_.param3,oJobInfo.n)));
                     break;
                  default:
                     _loc3_.push(ank.utils.PatternDecoder.getDescription(_loc2_.getEffectText(_loc1_.type).d,new Array(_loc1_.param1,_loc1_.param2,_loc1_.param3)));
               }
            }
            i++;
         }
      }
      return _loc3_;
   }
   function get canEquip()
   {
      var _loc2_ = _global.DATACENTER.Player.Level;
      if(_loc2_ < this.level)
      {
         return false;
      }
      var _loc1_ = true;
      if(this.superType == 2)
      {
         return true;
      }
      return _loc1_;
   }
   function get canUse()
   {
      return this.unicText.u;
   }
   function get level()
   {
      return this.unicText.l;
   }
   function get gfx()
   {
      return this.unicText.g;
   }
   function get price()
   {
      var _loc1_ = this;
      if(_loc1_._price == undefined)
      {
         if(_loc1_.superType == 9)
         {
            return 1;
         }
         Math.ceil(Number(_loc1_.unicText.p) * (_loc1_._priceMultiplicator != undefined ? _loc1_._priceMultiplicator : 1)); //unpopped
      }
      return _loc1_._price;
   }
   function get weight()
   {
      return Number(this.unicText.w);
   }
   function get range()
   {
      return this.unicText.r;
   }
   function get characteristics()
   {
      var _loc1_ = this.unicText;
      var _loc2_ = new Array();
      _loc2_.push("PA : " + _loc1_.a);
      _loc2_.push(_loc1_.ch == 0 ? "" : "CC : 1/" + _loc1_.ch);
      _loc2_.push(_loc1_.cm == 0 ? "" : "EC : 1/" + _loc1_.cm);
      _loc2_.push("Bonus CC : " + _loc1_.cb);
      _loc2_.push("PO : " + _loc1_.r);
      return _loc2_;
   }
}
