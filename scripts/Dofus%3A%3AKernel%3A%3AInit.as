_global.ROOT = _root;
if(!dofus.Constants.DEBUG)
{
   Stage.scaleMode = "noScale";
}
_quality = "HIGH";
ank.utils.Extensions.addExtensions();
_global.AKS = new Class_Client();
_global.DATACENTER = new Class_DataCenter();
_global.KERNEL = new Class_Kernel();
_global.CHAT = new Class_Chat();
_global.BATTLEFIELD = this.attachClassMovie(ank.battlefield.Battlefield,"bf",2,[DATACENTER,dofus.Constants.GROUND_FILE,dofus.Constants.OBJECTS_FILE]);
_global.getText = function(ref, params)
{
   var _loc2_ = params;
   if(_loc2_ == undefined)
   {
      _loc2_ = new Array();
   }
   var arrayPosition = new Array();
   var _loc3_ = new Array();
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.length)
   {
      arrayPosition.push("%" + (_loc1_ + 1));
      _loc3_.push(_loc2_[_loc1_]);
      _loc1_ = _loc1_ + 1;
   }
   return SHARED_OBJECT_LANG.data[ref].replace(arrayPosition,_loc3_);
};
_global.getSpellText = function(spellID)
{
   return SHARED_OBJECT_XTRA.data.S[spellID];
};
_global.getEffectText = function(effectID)
{
   return SHARED_OBJECT_XTRA.data.E[effectID];
};
_global.getGuildText = function(guildID)
{
   var _loc1_ = SHARED_OBJECT_XTRA.data.G[Number(guildID)];
   if(_loc1_)
   {
      return _loc1_;
   }
   return {sn:"?",ln:"?",d:"?",cc:"?"};
};
_global.getItemTypeText = function(typeID)
{
   var _loc1_ = SHARED_OBJECT_XTRA.data.I.t[Number(typeID)];
   if(_loc1_)
   {
      return _loc1_;
   }
   return {n:"?",t:"?",g:"?",s:"?"};
};
_global.getItemSuperTypeText = function(superTypeID)
{
   var _loc1_ = SHARED_OBJECT_XTRA.data.I.st[Number(superTypeID)];
   if(_loc1_.length != 0)
   {
      return _loc1_;
   }
   return "?";
};
_global.getItemUnicText = function(itemID)
{
   var _loc1_ = SHARED_OBJECT_XTRA.data.I.u[Number(itemID)];
   if(_loc1_)
   {
      return _loc1_;
   }
   return {n:"?",d:"?"};
};
_global.getItemUnicStringText = function()
{
   var _loc1_ = SHARED_OBJECT_XTRA.data.I.us;
   if(_loc1_)
   {
      return _loc1_;
   }
   return new Object();
};
_global.getMonstersText = function(monsterID)
{
   var _loc1_ = SHARED_OBJECT_XTRA.data.M[monsterID];
   return _loc1_;
};
_global.getNonPlayableCharactersText = function(npcID)
{
   var _loc1_ = SHARED_OBJECT_XTRA.data.N.d[npcID];
   return _loc1_;
};
_global.getNonPlayableCharactersActionText = function(actionID)
{
   var _loc1_ = SHARED_OBJECT_XTRA.data.N.a[actionID];
   return _loc1_;
};
_global.getInteractiveObjectDataByGfxText = function(id)
{
   return getInteractiveObjectDataText(SHARED_OBJECT_XTRA.data.IO.g[id]);
};
_global.getInteractiveObjectDataText = function(id)
{
   return SHARED_OBJECT_XTRA.data.IO.d[id];
};
_global.getSkillText = function(id)
{
   return SHARED_OBJECT_XTRA.data.SK[id];
};
_global.getJobText = function(id)
{
   return SHARED_OBJECT_XTRA.data.J[id];
};
_global.getDialogQuestionText = function(id)
{
   return SHARED_OBJECT_XTRA.data.D.q[id];
};
_global.getDialogResponseText = function(id)
{
   return SHARED_OBJECT_XTRA.data.D.a[id];
};
_global.getConfigText = function(id)
{
   return SHARED_OBJECT_XTRA.data.C[id];
};
_global.getHouseText = function(id)
{
   return SHARED_OBJECT_XTRA.data.H.H[id];
};
_global.getHousesMapText = function(mapID)
{
   return SHARED_OBJECT_XTRA.data.H.m[mapID];
};
_global.getHousesDoorText = function(mapID, cellNum)
{
   return SHARED_OBJECT_XTRA.data.H.d[mapID]["c" + cellNum];
};
_global.getHousesIndoorSkillsText = function()
{
   return SHARED_OBJECT_XTRA.data.H.ids;
};
_global.getCraftText = function(id)
{
   return SHARED_OBJECT_XTRA.data.CR[id];
};
_global.getMapText = function(id)
{
   return SHARED_OBJECT_XTRA.data.MA.m[id];
};
_global.getMapSubAreaText = function(id)
{
   return SHARED_OBJECT_XTRA.data.MA.sa[id];
};
_global.getMapAreaText = function(id)
{
   return SHARED_OBJECT_XTRA.data.MA.a[id];
};
_global.getTimeZoneText = function()
{
   return SHARED_OBJECT_XTRA.data.T;
};
