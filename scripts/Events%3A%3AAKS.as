AKS.onConnect = function(success, msg, data)
{
   if(success)
   {
      AKS.logon(DATACENTER.Player.login,DATACENTER.Player.password);
   }
   else
   {
      GAPI.unloadUIComponent("Waiting");
      GAPI.loadUIComponent("Login","Login",undefined,{bStayIfPresent:true});
      SOMA.onError();
      GAPI.loadUIComponent("AskOk","AskOkOnConnect",{title:getText("CONNECTION"),text:msg});
   }
};
AKS.onDisconnect = function(bRelog)
{
   var _loc1_;
   if(isLogged)
   {
      INTERFACE.MainLayer_mc.waiting.close();
      GAPI.unloadUIComponent("Waiting");
      this.m_LoadVars = new LoadVars();
      this.m_LoadVars.load(dofus.Constants.HTTP_LOGOUT_FILE);
      AKS.clear();
      INTERFACE.clear();
      BATTLEFIELD.clear();
      DATACENTER.clear();
      GAPI.clear();
      CHAT.clear();
      GAPI.setScreenSize(742,550);
      if(!bRelog)
      {
         GAPI.loadUIComponent("Login","Login");
      }
      _loc1_ = getText("DISCONNECT");
      if(AKS.m_ServerMessageID != -1)
      {
         _loc1_ += "\r\r" + getText("SRV_MSG_" + AKS.m_ServerMessageID);
         AKS.m_ServerMessageID = -1;
      }
      if(!bRelog)
      {
         GAPI.loadUIComponent("AskOk","AskOk",{title:getText("CONNECTION"),text:_loc1_});
      }
      SOMA.stopAllSound();
      SOMA.stopMusicFader();
   }
   isLogged = false;
};
AKS.onLogin = function(success, msg, language)
{
   if(success)
   {
      GAPI.unloadUIComponent("Login");
      INTERFACE.clear();
      DATACENTER.Player.Language = language;
      if(AKS.m_bSkipMenu)
      {
         AKS.Account.getCharacters();
      }
      else
      {
         _level0.showLoader();
         _level0.setLanguage(language);
         _level0.loadLanguage();
      }
      isLogged = true;
      AKS.m_bSkipMenu = false;
   }
   else
   {
      GAPI.loadUIComponent("Login","Login",undefined,{bStayIfPresent:true});
      SOMA.onError();
      GAPI.loadUIComponent("AskOk","AskOkOnLogin",{title:getText("LOGIN"),text:msg});
      AKS.disconnect(false);
   }
};
AKS.onServerMessage = function(display, data)
{
   var _loc1_ = data.split("|");
   var _loc3_ = _loc1_[0];
   var _loc2_ = _loc1_[1].split(";");
   if(display == "1")
   {
      GAPI.loadUIComponent("AskOk","AskOkServerMessage",{title:getText("INFORMATIONS"),text:getText("SRV_MSG_" + _loc3_,_loc2_)});
      AKS.m_ServerMessageID = -1;
   }
};
AKS.onBadVersion = function()
{
   var _loc2_ = _root;
   var _loc1_ = _loc2_._url;
   _loc1_ = _loc1_.replace("%5C","/");
   _loc1_ = _loc1_.replace("\\","/");
   _loc1_ = _loc1_.replace("file:///","");
   _loc1_ = _loc1_.replace("file://","");
   var _loc3_ = _loc1_.lastIndexOf("/");
   _loc1_ = _loc1_.substring(0,_loc3_ + 1);
   _loc2_.createEmptyMovieClip("pathData",12345);
   _loc2_.pathData.path = _loc1_ + "DOFUS.swf";
   System.security.allowDomain(SITE_PATH);
   _loc2_.pathData.loadVariables(dofus.Constants.HTTP_DELPATH_FILE,"POST");
};
AKS.onPong = function()
{
   KERNEL.traceToChat("<b>Ping :</b> " + (getTimer() - this.lastTimer) + "ms",dofus.Constants.INFO_CHAT_COLOR);
};
