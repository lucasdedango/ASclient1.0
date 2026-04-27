class ank.battlefield.InteractionHandler
{
   function InteractionHandler(c)
   {
      this.initialize(c);
   }
   function initialize(c)
   {
      var _loc1_ = this;
      _loc1_._container = c;
      _loc1_._extraProto = new Object();
      _loc1_.setEnabled(ank.battlefield.Constants.INTERACTION_NONE);
   }
   function setEnabled(state)
   {
      var _loc1_ = this;
      switch(state)
      {
         case ank.battlefield.Constants.INTERACTION_NONE:
            _loc1_.setEnabledOffAllExtraProto();
            _loc1_.setEnabledProtoAll(ank.battlefield.mc.Cell.prototype,false);
            _loc1_.setEnabledProtoAll(ank.battlefield.mc.InteractiveObject.prototype,false);
            _loc1_.setEnabledProtoAll(ank.battlefield.mc.Sprite.prototype,false);
            break;
         case ank.battlefield.Constants.INTERACTION_CELL_NONE:
            _loc1_.setEnabledOffAllExtraProto();
            _loc1_.setEnabledProtoAll(ank.battlefield.mc.Cell.prototype,false);
            break;
         case ank.battlefield.Constants.INTERACTION_CELL_RELEASE:
            _loc1_.setEnabledProtoRelease(ank.battlefield.mc.Cell.prototype,true);
            _loc1_.setEnabledProtoOutOver(ank.battlefield.mc.Cell.prototype,false);
            break;
         case ank.battlefield.Constants.INTERACTION_CELL_OVER_OUT:
            _loc1_.setEnabledProtoRelease(ank.battlefield.mc.Cell.prototype,false);
            _loc1_.setEnabledProtoOutOver(ank.battlefield.mc.Cell.prototype,true);
            break;
         case ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT:
            _loc1_.setEnabledProtoAll(ank.battlefield.mc.Cell.prototype,true);
            break;
         case ank.battlefield.Constants.INTERACTION_OBJECT_NONE:
            _loc1_.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype,false);
            _loc1_.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype,false);
            break;
         case ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE:
            _loc1_.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype,true);
            _loc1_.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype,false);
            break;
         case ank.battlefield.Constants.INTERACTION_OBJECT_OVER_OUT:
            _loc1_.setEnabledProtoRelease(ank.battlefield.mc.InteractiveObject.prototype,false);
            _loc1_.setEnabledProtoOutOver(ank.battlefield.mc.InteractiveObject.prototype,true);
            break;
         case ank.battlefield.Constants.INTERACTION_OBJECT_RELEASE_OVER_OUT:
            _loc1_.setEnabledProtoAll(ank.battlefield.mc.InteractiveObject.prototype,true);
            break;
         case ank.battlefield.Constants.INTERACTION_SPRITE_NONE:
            _loc1_.setEnabledProtoRelease(ank.battlefield.mc.Sprite.prototype,false);
            _loc1_.setEnabledProtoOutOver(ank.battlefield.mc.Sprite.prototype,false);
            break;
         case ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE:
            _loc1_.setEnabledProtoRelease(ank.battlefield.mc.Sprite.prototype,true);
            _loc1_.setEnabledProtoOutOver(ank.battlefield.mc.Sprite.prototype,false);
            break;
         case ank.battlefield.Constants.INTERACTION_SPRITE_OVER_OUT:
            _loc1_.setEnabledProtoRelease(ank.battlefield.mc.Sprite.prototype,false);
            _loc1_.setEnabledProtoOutOver(ank.battlefield.mc.Sprite.prototype,true);
            break;
         case ank.battlefield.Constants.INTERACTION_SPRITE_RELEASE_OVER_OUT:
            _loc1_.setEnabledProtoAll(ank.battlefield.mc.Sprite.prototype,true);
         default:
            return;
      }
   }
   function setEnabledCell(cellNum, state)
   {
      var _loc2_ = this;
      var _loc1_ = _loc2_._container.clips["cell" + cellNum];
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[setEnabledCell] Cell inexistante");
      }
      else
      {
         _loc2_._extraProto[_loc1_._name] = _loc1_;
         switch(state)
         {
            case ank.battlefield.Constants.INTERACTION_NONE:
               _loc2_.setEnabledProtoAll(_loc1_,false);
               break;
            case ank.battlefield.Constants.INTERACTION_CELL_RELEASE:
               _loc2_.setEnabledProtoRelease(_loc1_,true);
               _loc2_.setEnabledProtoOutOver(_loc1_,false);
               break;
            case ank.battlefield.Constants.INTERACTION_CELL_OVER_OUT:
               _loc2_.setEnabledProtoRelease(_loc1_,false);
               _loc2_.setEnabledProtoOutOver(_loc1_,true);
               break;
            case ank.battlefield.Constants.INTERACTION_CELL_RELEASE_OVER_OUT:
               _loc2_.setEnabledProtoAll(_loc1_,true);
            default:
               return;
         }
      }
   }
   function setEnabledOffAllExtraProto(Void)
   {
      var _loc1_ = this;
      var _loc2_;
      for(var _loc3_ in _loc1_._extraProto)
      {
         _loc2_ = _loc1_._extraProto[_loc3_];
         _loc1_.setEnabledProtoAll(_loc2_,false);
      }
      _loc1_._extraProto = new Array();
   }
   function setEnabledProtoAll(proto, bool)
   {
      var _loc1_ = proto;
      if(bool)
      {
         _loc1_.onRelease = _loc1_._release;
         _loc1_.onRollOver = _loc1_._rollOver;
         _loc1_.onRollOut = _loc1_.onReleaseOutside = _loc1_._rollOut;
      }
      else
      {
         delete _loc1_.onRelease;
         delete _loc1_.onRollOver;
         delete _loc1_.onRollOut;
         delete _loc1_.onReleaseOutside;
      }
   }
   function setEnabledProtoRelease(proto, bool)
   {
      var _loc1_ = proto;
      if(bool)
      {
         _loc1_.onRelease = _loc1_._release;
      }
      else
      {
         delete _loc1_.onRelease;
      }
   }
   function setEnabledProtoOutOver(proto, bool)
   {
      var _loc1_ = proto;
      if(bool)
      {
         _loc1_.onRollOver = _loc1_._rollOver;
         _loc1_.onRollOut = _loc1_._rollOut;
         _loc1_.onRollOut = _loc1_.onReleaseOutside = _loc1_._rollOut;
      }
      else
      {
         delete _loc1_.onRollOver;
         delete _loc1_.onRollOut;
         delete _loc1_.onReleaseOutside;
      }
   }
}
