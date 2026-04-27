Class_DataCenter = function()
{
   _global.DATACENTER = this;
   this.init();
};
Class_DataCenter.prototype = new MovieClip();
Object.registerClass("Dofus::DataCenter",Class_DataCenter);
Class_DataCenter.prototype.init = function()
{
   var _loc1_ = this;
   _loc1_.Player = new dofus.datacenter.LocalPlayer(_loc1_);
   _loc1_.Challenges = new ank.utils.ExtendedObject();
   _loc1_.Sprites = new ank.utils.ExtendedObject();
   _loc1_.Houses = new ank.utils.ExtendedObject();
   _loc1_.Storages = new ank.utils.ExtendedObject();
   _loc1_.Interaction = new String();
   _loc1_.Clips = new DofusDataProviderClass();
   _loc1_.Game = new Class_DataCenter_Game();
   _loc1_.Channel = new Class_DataCenter_Channel();
   _loc1_.Characters = new DofusDataProviderClass();
   _loc1_.Map = new Object();
   _loc1_.Objects = new DofusDataProviderClass();
   _loc1_.Spells = new DofusDataProviderClass();
   _loc1_.Temporary = new Object();
};
Class_DataCenter.prototype.clear = function()
{
   var _loc1_ = this;
   _loc1_.Player.initialize(_loc1_);
   _loc1_.Challenges = new ank.utils.ExtendedObject();
   _loc1_.Sprites = new ank.utils.ExtendedObject();
   _loc1_.Houses = new ank.utils.ExtendedObject();
   _loc1_.Storages = new ank.utils.ExtendedObject();
   _loc1_.Clips = new DofusDataProviderClass();
   _loc1_.Game = new Class_DataCenter_Game();
   _loc1_.Channel = new Class_DataCenter_Channel();
   _loc1_.Characters = new DofusDataProviderClass();
   _loc1_.Map = new Object();
   _loc1_.Objects = new DofusDataProviderClass();
   _loc1_.Spells = new DofusDataProviderClass();
   _loc1_.Temporary = new Object();
};
Class_Datacenter.prototype.clearGame = function()
{
   this.Game = new Class_DataCenter_Game();
};
ASSetPropFlags(Class_DataCenter.prototype,null,1,1);
