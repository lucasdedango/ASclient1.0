class dofus.datacenter.MonsterGroup extends dofus.datacenter.PlayableCharacter
{
   var _aLevelsList;
   var initialize;
   var _defaultAnimation = "Wait";
   function MonsterGroup(id, clipClass, gfxFile, cellNum, dir)
   {
      super();
      this.initialize(id,clipClass,gfxFile,cellNum,dir,null);
   }
   function set name(value)
   {
      var _loc3_ = this;
      _loc3_._aNamesList = new Array();
      var _loc2_ = value.split(",");
      var _loc1_ = 0;
      while(_loc1_ < _loc2_.length)
      {
         _loc3_._aNamesList.push(_global.getMonstersText(_loc2_[_loc1_]));
         _loc1_ = _loc1_ + 1;
      }
   }
   function get name()
   {
      var _loc2_ = this;
      var _loc3_ = new String();
      var _loc1_ = 0;
      while(_loc1_ < _loc2_._aNamesList.length)
      {
         _loc3_ += _loc2_._aNamesList[_loc1_] + " (" + _loc2_._aLevelsList[_loc1_] + ")" + "\n";
         _loc1_ = _loc1_ + 1;
      }
      return _loc3_;
   }
   function set level(value)
   {
      this._aLevelsList = value.split(",");
   }
   function get level()
   {
      return this._aLevelsList.join();
   }
}
