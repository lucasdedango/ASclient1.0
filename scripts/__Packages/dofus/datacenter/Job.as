class dofus.datacenter.Job extends Object
{
   var _eaCrafts;
   var _eaSkills;
   var _nID;
   var _nLevel;
   var _nXP;
   var _nXPmax;
   var _nXPmin;
   var _oJobText;
   function Job(nID, eaSkills)
   {
      super();
      this.initialize(nID,eaSkills);
   }
   function get id()
   {
      return this._nID;
   }
   function get name()
   {
      return this._oJobText.n;
   }
   function get description()
   {
      return this._oJobText.d;
   }
   function get iconFile()
   {
      return dofus.Constants.JOBS_ICONS_PATH + this._oJobText.g + ".swf";
   }
   function get skills()
   {
      return this._eaSkills;
   }
   function get crafts()
   {
      return this._eaCrafts;
   }
   function set level(nLevel)
   {
      this._nLevel = nLevel;
   }
   function get level()
   {
      return this._nLevel;
   }
   function set xpMin(nXPmin)
   {
      this._nXPmin = nXPmin;
   }
   function get xpMin()
   {
      return this._nXPmin;
   }
   function set xp(nXP)
   {
      this._nXP = nXP;
   }
   function get xp()
   {
      return this._nXP;
   }
   function set xpMax(nXPmax)
   {
      this._nXPmax = nXPmax;
   }
   function get xpMax()
   {
      return this._nXPmax;
   }
   function initialize(nID, eaSkills)
   {
      this._nID = nID;
      this._eaSkills = eaSkills;
      var _loc3_;
      var _loc1_;
      var _loc2_;
      if(!isNaN(eaSkills.length))
      {
         this._eaCrafts = new ank.utils.ExtendedArray();
         var i = 0;
         while(i < eaSkills.length)
         {
            _loc3_ = eaSkills[i];
            var aSkillCraftsList = _loc3_.craftsList;
            if(aSkillCraftsList != undefined)
            {
               _loc1_ = 0;
               while(_loc1_ < aSkillCraftsList.length)
               {
                  var nItemID = aSkillCraftsList[_loc1_];
                  _loc2_ = new dofus.datacenter.Craft(nItemID,_loc3_);
                  if(_loc2_.itemsCount <= _loc3_.param1)
                  {
                     this._eaCrafts.push(_loc2_);
                  }
                  _loc1_ = _loc1_ + 1;
               }
            }
            i++;
         }
      }
      this._oJobText = _global.getJobText(nID);
   }
}
