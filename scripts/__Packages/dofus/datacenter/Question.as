class dofus.datacenter.Question extends Object
{
   var _eaResponsesObjects;
   var _nQuestionID;
   var _sQuestionText;
   function Question(nQuestionID, aResponsesID)
   {
      super();
      this.initialize(nQuestionID,aResponsesID);
   }
   function get id()
   {
      return this._nQuestionID;
   }
   function get label()
   {
      return this._sQuestionText;
   }
   function get responses()
   {
      return this._eaResponsesObjects;
   }
   function initialize(nQuestionID, aResponsesID)
   {
      var _loc3_ = aResponsesID;
      this._nQuestionID = nQuestionID;
      this._sQuestionText = _global.getDialogQuestionText(nQuestionID);
      this._eaResponsesObjects = new ank.utils.ExtendedArray();
      var _loc1_ = 0;
      var _loc2_;
      while(_loc1_ < _loc3_.length)
      {
         _loc2_ = Number(_loc3_[_loc1_]);
         this._eaResponsesObjects.push({label:_global.getDialogResponseText(_loc2_),id:_loc2_});
         _loc1_ = _loc1_ + 1;
      }
   }
}
