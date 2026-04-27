AKS.Job.onSkills = function(nJobID, oJob)
{
   var _loc1_ = DATACENTER.Player.Jobs.findFirstItem("id",nJobID);
   if(_loc1_.index != -1)
   {
      DATACENTER.Player.Jobs.updateItem(_loc1_.index,oJob);
   }
   else
   {
      DATACENTER.Player.Jobs.push(oJob);
   }
};
AKS.Job.onXP = function(nJobID, nJobLevel, nJobXPmin, nJobXP, nJobXPmax)
{
   var _loc2_ = DATACENTER.Player.Jobs.findFirstItem("id",nJobID);
   var _loc1_;
   if(_loc2_.index != -1)
   {
      _loc1_ = _loc2_.item;
      _loc1_.level = nJobLevel;
      _loc1_.xpMin = nJobXPmin;
      _loc1_.xp = nJobXP;
      _loc1_.xpMax = nJobXPmax;
      DATACENTER.Player.Jobs.updateItem(_loc2_.index,_loc1_);
   }
};
AKS.Job.onLevel = function(nJobID, nJobLevel)
{
   GAPI.loadUIComponent("AskOK","AskOKNewLevel",{title:getText("INFORMATIONS"),text:getText("NEW_JOB_LEVEL",[getJobText(nJobID).n,nJobLevel])});
};
