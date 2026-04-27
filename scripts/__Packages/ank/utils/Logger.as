class ank.utils.Logger
{
   var _errors;
   var _logs;
   static var LC = new LocalConnection();
   static var MAX_LOG_COUNT = 50;
   static var MAX_LOG_SIZE = 300;
   static var _instance = new ank.utils.Logger();
   function Logger()
   {
      this._logs = new Array();
      this._errors = new Array();
      ank.utils.Logger.LC.connect("loggerIn");
      ank.utils.Logger.LC.getLogs = function()
      {
         ank.utils.Logger.LC.send("loggerOut","log",ank.utils.Logger.logs);
      };
      ank.utils.Logger.LC.getErrors = function()
      {
         ank.utils.Logger.LC.send("loggerOut","err",ank.utils.Logger.errors);
      };
   }
   static function log(txt)
   {
      var _loc1_ = txt;
      trace(_loc1_);
      ank.utils.Logger.LC.send("loggerOut","log",_loc1_);
      if(_loc1_.length < ank.utils.Logger.MAX_LOG_SIZE)
      {
         ank.utils.Logger._instance._logs.push(_loc1_);
      }
      if(ank.utils.Logger._instance._logs.length > ank.utils.Logger.MAX_LOG_COUNT)
      {
         ank.utils.Logger._instance._logs.shift();
      }
   }
   static function err(txt)
   {
      var _loc1_ = txt;
      _loc1_ = "ERROR : " + _loc1_;
      trace(_loc1_);
      ank.utils.Logger.LC.send("loggerOut","err",_loc1_);
      ank.utils.Logger._instance._errors.push(_loc1_);
   }
   static function get logs()
   {
      return ank.utils.Logger._instance._logs.join("\n");
   }
   static function get errors()
   {
      return ank.utils.Logger._instance._errors.join("\n");
   }
}
