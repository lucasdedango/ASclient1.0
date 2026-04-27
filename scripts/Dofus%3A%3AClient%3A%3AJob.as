Class_Client_Job = function(parent)
{
   this._parent = parent;
};
Object.registerClass("Dofus::Client::Job",Class_Client_Job);
Class_Client_Job.prototype.send = function(data, bWaiting)
{
   this._parent.send(data,bWaiting);
};
Class_Client_Job.prototype.innerOnSkills = function(data)
{
   var aTmp = data.split("|");
   var i = 0;
   var _loc3_;
   var _loc2_;
   var _loc1_;
   while(i < aTmp.length)
   {
      var aTmp2 = aTmp[i].split(";");
      var nJobID = Number(aTmp2[0]);
      var eaSkills = new ank.utils.ExtendedArray();
      _loc3_ = aTmp2[1].split(",");
      _loc2_ = _loc3_.length;
      while(_loc2_-- > 0)
      {
         _loc1_ = _loc3_[_loc2_].split("~");
         eaSkills.push(new dofus.datacenter.Skill(_loc1_[0],_loc1_[1],_loc1_[2],_loc1_[3],_loc1_[4]));
      }
      var oJob = new dofus.datacenter.Job(nJobID,eaSkills);
      this.onSkills(nJobID,oJob);
      i++;
   }
};
Class_Client_Job.prototype.innerOnXP = function(data)
{
   var aTmp = data.split("|");
   var i = aTmp.length;
   var _loc1_;
   var _loc2_;
   var _loc3_;
   while(i-- > 0)
   {
      _loc1_ = aTmp[i].split(";");
      _loc2_ = Number(_loc1_[0]);
      _loc3_ = Number(_loc1_[1]);
      var nJobXPmin = Number(_loc1_[2]);
      var nJobXP = Number(_loc1_[3]);
      var nJobXPmax = Number(_loc1_[4]);
      this.onXP(_loc2_,_loc3_,nJobXPmin,nJobXP,nJobXPmax);
   }
};
Class_Client_Job.prototype.innerOnLevel = function(data)
{
   var _loc1_ = data.split("|");
   var _loc2_ = Number(_loc1_[0]);
   var _loc3_ = Number(_loc1_[1]);
   this.onLevel(_loc2_,_loc3_);
};
