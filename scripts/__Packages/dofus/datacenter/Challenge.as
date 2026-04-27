class dofus.datacenter.Challenge extends Object
{
   var _teams;
   var id;
   function Challenge(id)
   {
      super();
      this.initialize(id);
   }
   function initialize(id)
   {
      this.id = id;
      this._teams = new Object();
   }
   function addTeam(t)
   {
      var _loc1_ = t;
      this._teams[_loc1_.id] = _loc1_;
      _loc1_.setChallenge(this);
   }
   function get teams()
   {
      return this._teams;
   }
   function get count()
   {
      var _loc1_ = this;
      var _loc2_ = 0;
      for(var _loc3_ in _loc1_._teams)
      {
         _loc2_ += _loc1_._teams[_loc3_].count;
      }
      return _loc2_;
   }
}
