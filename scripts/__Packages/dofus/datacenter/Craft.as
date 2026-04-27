class dofus.datacenter.Craft extends Object
{
   var _aItems;
   var _oCraftItem;
   var _oSkill;
   function Craft(nID, oSkill)
   {
      super();
      this.initialize(nID,oSkill);
   }
   function get skill()
   {
      return this._oSkill;
   }
   function get craftItem()
   {
      return this._oCraftItem;
   }
   function get items()
   {
      return this._aItems;
   }
   function get itemsCount()
   {
      return this._aItems.length;
   }
   function initialize(nID, oSkill)
   {
      this._oSkill = oSkill;
      this._oCraftItem = new dofus.datacenter.Item(0,nID,1);
      var _loc2_ = _global.getCraftText(nID);
      this._aItems = new Array();
      var _loc1_;
      var _loc3_;
      if(!isNaN(_loc2_.length))
      {
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc3_ = new dofus.datacenter.Item(0,_loc2_[_loc1_][0],_loc2_[_loc1_][1]);
            this._aItems.push(_loc3_);
            _loc1_ = _loc1_ + 1;
         }
      }
   }
}
