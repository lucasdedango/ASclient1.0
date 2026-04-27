AKS.Dialog.onCreate = function(npcID)
{
   var _loc1_ = DATACENTER.Sprites.getItemAt(npcID);
   GAPI.loadUiComponent("NpcDialog","NpcDialog",{name:_loc1_.name,gfx:_loc1_.GfxID,id:npcID});
};
AKS.Dialog.onQuestion = function(oQuestion)
{
   this.output.setQuestion(oQuestion);
};
AKS.Dialog.onLeave = function()
{
   GAPI.unloadUIComponent("NpcDialog");
};
