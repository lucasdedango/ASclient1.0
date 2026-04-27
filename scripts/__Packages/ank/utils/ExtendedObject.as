class ank.utils.ExtendedObject extends Object
{
   var _count;
   var _items;
   function ExtendedObject()
   {
      super();
      this.initialize();
   }
   function initialize(Void)
   {
      this.clear();
      mx.events.EventDispatcher.initialize(this);
   }
   function clear(Void)
   {
      var _loc1_ = this;
      _loc1_._items = new Object();
      _loc1_._count = 0;
      _loc1_.dispatchEvent({type:"modelChanged"});
   }
   function addItemAt(key, item)
   {
      var _loc1_ = this;
      _loc1_._items[key] = item;
      _loc1_._count = _loc1_._count + 1;
      _loc1_.dispatchEvent({type:"modelChanged"});
   }
   function removeItemAt(key)
   {
      var _loc1_ = this;
      var _loc2_ = _loc1_._items[key];
      delete _loc1_._items[key];
      _loc1_._count = _loc1_._count - 1;
      return _loc2_;
   }
   function removeAll(Void)
   {
      this.clear();
   }
   function removeAllExcept(key)
   {
      var _loc1_ = this;
      var _loc2_ = key;
      for(var _loc3_ in _loc1_._items)
      {
         if(_loc3_ != _loc2_)
         {
            delete _loc1_._items[_loc3_];
         }
      }
      _loc1_._count = 1;
      _loc1_.dispatchEvent({type:"modelChanged"});
   }
   function replaceItemAt(key, item)
   {
      var _loc1_ = this;
      if(_loc1_._items[key] != undefined)
      {
         _loc1_._items[key] = item;
         _loc1_.dispatchEvent({type:"modelChanged"});
      }
   }
   function getLength(Void)
   {
      return this._count;
   }
   function getItemAt(key)
   {
      return this._items[key];
   }
   function getItems(Void)
   {
      return this._items;
   }
   function getKeys(Void)
   {
      var _loc2_ = this;
      var _loc1_ = new Array();
      for(var _loc3_ in _loc2_._items)
      {
         _loc1_.push(_loc3_);
      }
      return _loc1_;
   }
}
