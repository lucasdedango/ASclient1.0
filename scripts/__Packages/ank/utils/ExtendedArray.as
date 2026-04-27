class ank.utils.ExtendedArray extends Array
{
   function ExtendedArray()
   {
      super();
      this.initialize();
   }
   function removeEventListener()
   {
   }
   function addEventListener()
   {
   }
   function dispatchEvent()
   {
   }
   function dispatchQueue()
   {
   }
   function initialize(Void)
   {
      mx.events.EventDispatcher.initialize(this);
   }
   function removeAll(Void)
   {
      var _loc1_ = this;
      _loc1_.splice(0,_loc1_.length);
      _loc1_.dispatchEvent({taget:_loc1_,type:"modelChanged",eventName:"updateAll"});
   }
   function push(value)
   {
      var _loc1_ = super.push(value);
      this.dispatchEvent({taget:this,type:"modelChanged",eventName:"addItem"});
      return _loc1_;
   }
   function pop()
   {
      var _loc1_ = super.pop();
      this.dispatchEvent({taget:this,type:"modelChanged",eventName:"updateAll"});
      return _loc1_;
   }
   function shift()
   {
      var _loc1_ = super.shift();
      this.dispatchEvent({taget:this,type:"modelChanged",eventName:"updateAll"});
      return _loc1_;
   }
   function unshift(value)
   {
      var _loc1_ = super.unshift(value);
      this.dispatchEvent({taget:this,type:"modelChanged",eventName:"updateAll"});
      return _loc1_;
   }
   function reverse()
   {
      super.reverse();
      this.dispatchEvent({taget:this,type:"modelChanged",eventName:"updateAll"});
   }
   function removeItems(nIndex, deleteCount)
   {
      var _loc1_ = this;
      _loc1_.splice(nIndex,deleteCount);
      _loc1_.dispatchEvent({taget:_loc1_,type:"modelChanged",eventName:"updateAll"});
   }
   function updateItem(nIndex, newValue)
   {
      var _loc1_ = this;
      _loc1_.splice(nIndex,1,newValue);
      _loc1_.dispatchEvent({taget:_loc1_,type:"modelChanged",eventName:"updateOne",updateIndex:nIndex});
   }
   function findFirstItem(sPropName, propValue)
   {
      var _loc2_ = this;
      i = 0;
      var _loc1_;
      while(i < _loc2_.length)
      {
         _loc1_ = _loc2_[i];
         if(_loc1_[sPropName] == propValue)
         {
            return {index:i,item:_loc1_};
         }
         i++;
      }
      return {index:-1};
   }
}
