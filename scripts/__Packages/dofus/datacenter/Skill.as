class dofus.datacenter.Skill extends Object
{
   var _nID;
   var _nParam1;
   var _nParam2;
   var _nParam3;
   var _nParam4;
   var _oSkillText;
   function Skill(nID, nParam1, nParam2, nParam3, nParam4)
   {
      super();
      this.initialize(nID,nParam1,nParam2,nParam3,nParam4);
   }
   function get id()
   {
      return this._nID;
   }
   function get description()
   {
      return this._oSkillText.d;
   }
   function get job()
   {
      return this._oSkillText.j;
   }
   function get criterion()
   {
      return this._oSkillText.c;
   }
   function get item()
   {
      if(this._oSkillText.i == undefined)
      {
         return undefined;
      }
      return new dofus.datacenter.Item(0,this._oSkillText.i);
   }
   function get interactiveObject()
   {
      return _global.getInteractiveObjectDataText(this._oSkillText.io).n;
   }
   function get param1()
   {
      return this._nParam1;
   }
   function get param2()
   {
      return this._nParam2;
   }
   function get param3()
   {
      return this._nParam3;
   }
   function get param4()
   {
      return this._nParam4;
   }
   function get craftsList()
   {
      return this._oSkillText.cl;
   }
   function initialize(nID, nParam1, nParam2, nParam3, nParam4)
   {
      var _loc1_ = this;
      _loc1_._nID = nID;
      if(nParam1 != 0)
      {
         _loc1_._nParam1 = nParam1;
      }
      if(nParam2 != 0)
      {
         _loc1_._nParam2 = nParam2;
      }
      if(nParam3 != 0)
      {
         _loc1_._nParam3 = nParam3;
      }
      if(nParam4 != 0)
      {
         _loc1_._nParam4 = nParam4;
      }
      _loc1_._oSkillText = _global.getSkillText(nID);
   }
   function getState(bJob, bOwner, bForSale, bLocked, bIndoor)
   {
      if(this.criterion == undefined || this.criterion.length == 0)
      {
         return "V";
      }
      var aTmp = this.criterion.split("?");
      var aCriterions = aTmp[0].split("&");
      var aTmp2 = aTmp[1].split(":");
      var sAction = aTmp2[0];
      var _loc3_ = aTmp2[1];
      var i = 0;
      var _loc2_;
      var _loc1_;
      while(i < aCriterions.length)
      {
         _loc2_ = aCriterions[i];
         _loc1_ = _loc2_.charAt(0) == "!";
         if(_loc1_)
         {
            _loc2_ = _loc2_.substr(1);
         }
         switch(_loc2_)
         {
            case "J":
               if(_loc1_)
               {
                  bJob = !bJob;
               }
               if(!bJob)
               {
                  return _loc3_;
               }
               break;
            case "O":
               if(_loc1_)
               {
                  bOwner = !bOwner;
               }
               if(!bOwner)
               {
                  return _loc3_;
               }
               break;
            case "S":
               if(_loc1_)
               {
                  bForSale = !bForSale;
               }
               if(!bForSale)
               {
                  return _loc3_;
               }
               break;
            case "L":
               if(_loc1_)
               {
                  bLocked = !bLocked;
               }
               if(!bLocked)
               {
                  return _loc3_;
               }
               break;
            case "I":
               if(_loc1_)
               {
                  bIndoor = !bIndoor;
               }
               if(!bIndoor)
               {
                  return _loc3_;
               }
         }
         i++;
      }
      return sAction;
   }
}
