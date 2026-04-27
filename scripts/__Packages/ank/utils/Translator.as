class ank.utils.Translator
{
   var _sShareadObjectName;
   function Translator(sShareadObjectName)
   {
      this._sShareadObjectName = sShareadObjectName;
   }
   static function getText(key, args)
   {
      return _global.getText(key,args);
   }
   static function getGuildInfos(gid)
   {
      return _global.getGuildText(gid);
   }
   static function getSpellInfos(sid)
   {
      return _global.getSpellText(sid);
   }
   static function getEffectInfos(eid)
   {
      return _global.getEffectText(eid);
   }
   static function getItemSuperTypeText(id)
   {
      return _global.getItemSuperTypeText(id);
   }
   static function getConfigText(sKey)
   {
      return _global.getConfigText(sKey);
   }
}
