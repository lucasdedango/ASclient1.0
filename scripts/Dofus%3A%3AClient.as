Class_Client = function()
{
   this.init();
};
Object.registerClass("Dofus::Client",Class_Client);
Class_Client.prototype.onConnect = null;
Class_Client.prototype.onLogin = null;
Class_Client.prototype.onDisconnect = null;
Class_Client.prototype.init = function()
{
   var _loc1_ = this;
   _loc1_.Account = new Class_Client_Account(_loc1_);
   _loc1_.Channels = new Class_Client_Channels(_loc1_);
   _loc1_.Chat = new Class_Client_Chat(_loc1_);
   _loc1_.Console = new Class_Client_Console(_loc1_);
   _loc1_.Game = new Class_Client_Game(_loc1_);
   _loc1_.Spells = new Class_Client_Spells(_loc1_);
   _loc1_.Items = new Class_Client_Items(_loc1_);
   _loc1_.Infos = new Class_Client_Infos(_loc1_);
   _loc1_.Exchange = new Class_Client_Exchange(_loc1_);
   _loc1_.Job = new Class_Client_Job(_loc1_);
   _loc1_.Dialog = new Class_Client_Dialog(_loc1_);
   _loc1_.Key = new Class_Client_Key(_loc1_);
   _loc1_.Houses = new Class_Client_Houses(_loc1_);
   _loc1_.Storages = new Class_Client_Storages(_loc1_);
   _loc1_.DataProcessor = new Class_Client_DataProcessor(_loc1_);
   _loc1_.m_Socket = new XMLSocket();
   _loc1_.m_Socket._parent = _loc1_;
   _loc1_.STATE_IN_CHANNEL = "C";
   _loc1_.STATE_IN_GAME_UNKNOWN = "1";
   _loc1_.STATE_IN_GAME_FREE = "2";
   _loc1_.STATE_IN_GAME_RANDOM = "3";
   _loc1_.STATE_IN_GAME_SOLO = "4";
   _loc1_.STATE_IN_DUNNO = "?";
   _loc1_.m_bConnected = false;
   _loc1_.m_bAuthentified = false;
   _loc1_.m_UID = null;
   _loc1_.m_ServerMessageID = -1;
   _loc1_.m_bSkipMenu = false;
};
Class_Client.prototype.clear = function(host, port)
{
   var _loc1_ = this;
   _loc1_.m_bConnected = false;
   _loc1_.m_bAuthentified = false;
   _loc1_.m_UID = null;
   _loc1_.m_serverMessageID = -1;
   _loc1_.isSet = false;
};
Class_Client.prototype.connect = function(host, port)
{
   var _loc1_ = this;
   _loc1_.m_Socket.onConnect = _loc1_.XMLonConnect;
   _loc1_.m_Socket.onData = _loc1_.DataProcessor.process;
   _loc1_.m_Socket.onClose = _loc1_.innerOnDisconnect;
   _loc1_.m_Socket.connect(host,port);
   GAPI.loadUIComponent("Waiting","Waiting");
};
Class_Client.prototype.disconnect = function(bRelog)
{
   this.m_Socket.close();
   this.m_Socket.onClose(bRelog);
};
Class_Client.prototype.logon = function(login, password)
{
   var _loc1_ = this;
   var _loc2_ = login;
   if(_loc1_.m_bAuthentified)
   {
      _loc1_.onLogin(false,getText("ALREADY_LOGGED"));
   }
   if(_loc1_.m_UID == null)
   {
      _loc1_.onLogin(false,getText("CONNECT_NOT_FINISHED"));
   }
   DATACENTER.Player.login = _loc2_;
   DATACENTER.Player.password = password;
   _loc1_.m_login = _loc2_;
   _loc1_.send(dofus.Constants.VERSION + "." + dofus.Constants.SUBVERSION + "\n");
   _loc1_.send(_loc2_ + "\n" + ank.utils.Crypt.cryptPassword(password,_loc1_.m_UID) + "\n");
};
Class_Client.prototype.send = function(data, waiting)
{
   var _loc1_ = data;
   if(_loc1_.length > dofus.Constants.MAX_DATA_LENGTH)
   {
      _loc1_ = _loc1_.substring(0,dofus.Constants.MAX_DATA_LENGTH - 1);
   }
   if(_loc1_.charCodeAt(_loc1_.length - 1) != 10)
   {
      _loc1_ += "\n";
   }
   this.m_Socket.send(_loc1_);
   if(waiting || waiting == undefined)
   {
      GAPI.loadUIComponent("Waiting","Waiting");
   }
};
Class_Client.prototype.ping = function()
{
   this.lastTimer = getTimer();
   this.send("ping\n");
};
Class_Client.prototype.XMLonConnect = function(success)
{
   if(!success)
   {
      this._parent.onConnect(false,getText("CANT_CONNECT"));
   }
};
Class_Client.prototype.innerOnDisconnect = function(bRelog)
{
   var _loc1_ = bRelog;
   if(_loc1_ == undefined)
   {
      _loc1_ = false;
   }
   this._parent.m_bAuthentified = false;
   this._parent.onDisconnect(_loc1_);
};
