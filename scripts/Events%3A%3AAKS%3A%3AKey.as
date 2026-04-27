AKS.Key.onCreate = function(nType, nSlotsCount)
{
   GAPI.loadUIComponent("KeyCode","KeyCode",{title:getText("TYPE_CODE"),changeType:nType,slotsCount:nSlotsCount});
};
AKS.Key.onKey = function(bError)
{
   if(bError)
   {
      GAPI.loadUIComponent("AskOk","AskOkBuy",{title:getText("CODE"),text:getText("BAD_CODE")});
   }
   else
   {
      GAPI.loadUIComponent("AskOk","AskOkBuy",{title:getText("CODE"),text:getText("CODE_CHANGED")});
   }
};
AKS.Key.onLeave = function()
{
   GAPI.unloadUIComponent("KeyCode");
};
