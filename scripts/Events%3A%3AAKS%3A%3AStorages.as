AKS.Storages.onStorage = function(bAdd, sStorageID, bLocked)
{
   var _loc3_ = sStorageID;
   var _loc1_ = DATACENTER.Storages;
   var _loc2_;
   if(bAdd)
   {
      _loc2_ = _loc1_.getItemAt(_loc3_);
      if(_loc2_ == undefined)
      {
         _loc2_ = new dofus.datacenter.Storage();
      }
      _loc2_.isLocked = bLocked;
      _loc1_.addItemAt(_loc3_,_loc2_);
   }
   else
   {
      _loc1_.removeItemAt(_loc3_);
   }
};
AKS.Storages.onLockedPorperty = function(sStorageID, bLocked)
{
   var _loc3_ = sStorageID;
   trace(_loc3_ + " " + bLocked);
   var _loc1_ = DATACENTER.Storages;
   var _loc2_ = _loc1_.getItemAt(_loc3_);
   if(_loc2_ == undefined)
   {
      _loc2_ = new dofus.datacenter.Storage(_loc3_);
      _loc1_.addItemAt(_loc3_,_loc2_);
   }
   _loc2_.isLocked = bLocked;
};
