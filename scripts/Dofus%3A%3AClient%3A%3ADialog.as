Class_Client_Dialog = function(parent)
{
   this._parent = parent;
};
Object.registerClass("Dofus::Client::Dialog",Class_Client_Dialog);
Class_Client_Dialog.prototype.send = function(data, bWaiting)
{
   this._parent.send(data,bWaiting);
};
Class_Client_Dialog.prototype.begining = function(npcID)
{
   this.send("DB" + npcID + "\n",false);
};
Class_Client_Dialog.prototype.create = function(npcID)
{
   this.send("DC" + npcID + "\n",false);
};
Class_Client_Dialog.prototype.leave = function()
{
   this.send("DV\n",false);
};
Class_Client_Dialog.prototype.response = function(nQuestionID, nResponseID)
{
   this.send("DR" + nQuestionID + "|" + nResponseID + "\n",false);
};
Class_Client_Dialog.prototype.innerOnCreate = function(bError, data)
{
   if(!bError)
   {
      this.onCreate(data);
   }
};
Class_Client_Dialog.prototype.innerOnQuestion = function(data)
{
   var _loc1_ = data.split("|");
   var _loc2_ = Number(_loc1_[0]);
   var aAnswersID = _loc1_[1].split(";");
   var _loc3_ = new dofus.datacenter.Question(_loc2_,aAnswersID);
   this.onQuestion(_loc3_);
};
