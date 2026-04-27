class dofus.datacenter.Team extends ank.battlefield.datacenter.Sprite
{
   var _challenge;
   var _nAlignment;
   var _players;
   function Team(id, clipClass, gfxFile, cellNum, color1, alignment)
   {
      super();
      this.initialize(id,clipClass,gfxFile,cellNum,color1,alignment);
   }
   function initialize(id, clipClass, gfxFile, cellNum, color1, alignment)
   {
      var _loc1_ = this;
      super.initialize(id,clipClass,gfxFile,cellNum);
      _loc1_.Color1 = color1;
      _loc1_._nAlignment = Number(alignment);
      _loc1_._players = new Object();
   }
   function setChallenge(cd)
   {
      this._challenge = cd;
   }
   function addPlayer(p)
   {
      this._players[p.id] = p;
   }
   function removePlayer(id)
   {
      delete this._players[id];
   }
   function get alignment()
   {
      return this._nAlignment;
   }
   function get name()
   {
      var _loc1_ = this;
      var _loc2_ = new String();
      for(var _loc3_ in _loc1_._players)
      {
         _loc2_ += "\n" + _loc1_._players[_loc3_].name + "(" + _loc1_._players[_loc3_].level + ")";
      }
      return _loc2_.substr(1);
   }
   function get count()
   {
      var _loc2_ = this;
      var _loc1_ = 0;
      for(var _loc3_ in _loc2_._players)
      {
         _loc1_ = _loc1_ + 1;
      }
      return _loc1_;
   }
}
