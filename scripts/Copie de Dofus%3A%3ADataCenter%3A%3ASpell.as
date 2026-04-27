Class_DataCenter_Spell = function()
{
   var _loc1_ = this;
   _loc1_.m_ID = null;
   _loc1_.m_Level = null;
   _loc1_.m_EffectZones = null;
   _loc1_.m_Position = null;
   _loc1_.m_AnimID = null;
   _loc1_.m_bInFrontOfPlayer = null;
   _loc1_.m_bCC = false;
};
Object.registerClass("Dofus::DataCenter::Spell",Class_DataCenter_Spell);
Class_DataCenter_Spell.prototype.setEffectZones = function()
{
   var compressedData = getSpellText(this.m_ID)["l" + this.m_Level][15];
   var _loc2_ = compressedData.split("");
   var tmpArray2 = new Array();
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.length)
   {
      tmpArray2.push({shape:_loc2_[_loc1_],size:ank.utils.Compressor.decode64(_loc2_[_loc1_ + 1])});
      _loc1_ += 2;
   }
   this.m_EffectZones = tmpArray2;
};
Class_DataCenter_Spell.prototype.setAdditionalData = function(compressedData)
{
   var _loc1_ = this;
   _loc1_.m_Position = ank.utils.Compressor.decode64(compressedData);
   if(_loc1_.m_Position > 14 || _loc1_.m_Position < 1)
   {
      _loc1_.m_Position = null;
   }
};
Class_DataCenter_Spell.prototype.addProperty("data",function()
{
   var _loc1_ = this;
   return {name:_loc1_.m_name,file:_loc1_.m_file,type:_loc1_.m_type,infos:_loc1_.m_infos,effects:_loc1_.m_effects};
}
,null);
Class_DataCenter_Spell.prototype.addProperty("iconFile",function()
{
   return dofus.Constants.SPELLS_ICONS_PATH + this.m_ID + ".swf";
}
,null);
Class_DataCenter_Spell.prototype.addProperty("file",function()
{
   return dofus.Constants.SPELLS_PATH + this.m_AnimID + ".swf";
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_Name",function()
{
   return getSpellText(this.m_ID).n;
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_Description",function()
{
   return getSpellText(this.m_ID).d;
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_APCost",function()
{
   return getSpellText(this.m_ID)["l" + this.m_Level][2];
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_Range",function()
{
   return getSpellText(this.m_ID)["l" + this.m_Level][3];
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_Class",function()
{
   return getSpellText(this.m_ID)["l" + this.m_Level][4];
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_Type",function()
{
   return getSpellText(this.m_ID)["l" + this.m_Level][5];
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_bOnItSelf",function()
{
   return getSpellText(this.m_ID)["l" + this.m_Level][6];
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_bLineOnly",function()
{
   return getSpellText(this.m_ID)["l" + this.m_Level][7];
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_bLineOfSight",function()
{
   return getSpellText(this.m_ID)["l" + this.m_Level][8];
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_bFreeCell",function()
{
   return getSpellText(this.m_ID)["l" + this.m_Level][9];
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_CriticalHit",function()
{
   return getSpellText(this.m_ID)["l" + this.m_Level][10];
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_CriticalFailure",function()
{
   return getSpellText(this.m_ID)["l" + this.m_Level][11];
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_LaunchCountByTurn",function()
{
   return getSpellText(this.m_ID)["l" + this.m_Level][12];
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_LaunchCountByPlayerTurn",function()
{
   return getSpellText(this.m_ID)["l" + this.m_Level][13];
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_DelayBetweenLaunch",function()
{
   return getSpellText(this.m_ID)["l" + this.m_Level][14];
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_DescriptionNormalHit",function()
{
   var d = new String();
   var _loc2_ = getSpellText(this.m_ID)["l" + this.m_Level][0];
   var _loc1_;
   var len = _loc2_.length;
   var _loc3_ = new Array();
   var effectID;
   _loc1_ = 0;
   while(_loc1_ < len)
   {
      effectID = _loc2_[_loc1_][0];
      _loc3_ = _loc2_[_loc1_].slice(1);
      d += ", " + ank.utils.PatternDecoder.getDescription(getEffectText(effectID).d,_loc3_);
      _loc1_ = _loc1_ + 1;
   }
   return d.substr(2);
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_DescriptionCriticalHit",function()
{
   var d = new String();
   var _loc2_ = getSpellText(this.m_ID)["l" + this.m_Level][1];
   var _loc1_;
   var _loc3_;
   if(typeof _loc2_ == "object")
   {
      var len = _loc2_.length;
      _loc3_ = new Array();
      var effectID;
      _loc1_ = 0;
      while(_loc1_ < len)
      {
         effectID = _loc2_[_loc1_][0];
         _loc3_ = _loc2_[_loc1_].slice(1);
         d += ", " + ank.utils.PatternDecoder.getDescription(getEffectText(effectID).d,_loc3_);
         _loc1_ = _loc1_ + 1;
      }
      return d.substr(2);
   }
}
,null);
Class_DataCenter_Spell.prototype.addProperty("m_DescriptionCriticalMiss",function()
{
   var d = new String();
   var _loc2_ = getSpellText(this.m_ID)["l" + this.m_Level][2];
   var _loc1_;
   var len = _loc2_.length;
   var _loc3_ = new Array();
   var effectID;
   _loc1_ = 0;
   while(_loc1_ < len)
   {
      effectID = _loc2_[_loc1_][0];
      _loc3_ = _loc2_[_loc1_].slice(1);
      d += ", " + ank.utils.PatternDecoder.getDescription(getEffectText(effectID).d,_loc3_);
      _loc1_ = _loc1_ + 1;
   }
   return d.substr(2);
}
,null);
ASSetPropFlags(Class_DataCenter_Spell.prototype,null,1,1);
