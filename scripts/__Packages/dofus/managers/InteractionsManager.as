class dofus.managers.InteractionsManager
{
   var _playerManager;
   static var STATE_MOVE_SINGLE = 0;
   static var STATE_SELECT = 1;
   function InteractionsManager(playerManager)
   {
      this.initialize(playerManager);
   }
   function initialize(playerManager)
   {
      this._playerManager = playerManager;
   }
   function setState(bFight)
   {
      var _loc1_ = this;
      if(bFight)
      {
         _loc1_._state = dofus.managers.InteractionsManager.STATE_SELECT;
         _loc1_._playerManager.lastClickedCell = null;
      }
      else
      {
         _loc1_._state = dofus.managers.InteractionsManager.STATE_MOVE_SINGLE;
      }
   }
   function calculatePath(mapHandler, cell, bRelease, bIsFight, bIgnoreSprites)
   {
      var _loc1_ = this;
      if(cell == _loc1_._playerManager.data.CellNum)
      {
         return false;
      }
      var c = mapHandler.getCellData(cell);
      var bPlayerOn = !bIgnoreSprites ? (c.SpriteOnID != undefined ? true : false) : false;
      if(bPlayerOn)
      {
         return false;
      }
      if(c.movement == 0)
      {
         return false;
      }
      if(c.movement == 1 && bIsFight)
      {
         return false;
      }
      var character = _loc1_._playerManager.sprite_mc;
      var _loc2_;
      switch(_loc1_._state)
      {
         case dofus.managers.InteractionsManager.STATE_MOVE_SINGLE:
            _loc1_._playerManager.tmpFullPath = ank.battlefield.utils.Pathfinding.pathFind(mapHandler,_loc1_._playerManager.data.CellNum,cell,true,bIsFight,undefined,bIgnoreSprites);
            if(_loc1_._playerManager.tmpFullPath != null)
            {
               return true;
            }
            return false;
            break;
         case dofus.managers.InteractionsManager.STATE_SELECT:
            if(bRelease)
            {
               _global.BATTLEFIELD.select(_loc1_._playerManager.tmpFullPath,dofus.Constants.CELL_PATH_SELECT_COLOR);
               return _loc1_._playerManager.tmpFullPath != null;
            }
            _loc1_._playerManager.tmpFullPath = ank.battlefield.utils.Pathfinding.pathFind(mapHandler,_loc1_._playerManager.data.CellNum,cell,false,bIsFight,!bIsFight ? 500 : _loc1_._playerManager.data.MP);
            _loc2_ = new Array();
            for(var _loc3_ in _loc1_._playerManager.tmpFullPath)
            {
               _loc2_.push(_loc1_._playerManager.tmpFullPath[_loc3_].num);
            }
            _global.BATTLEFIELD.unSelect(true);
            _global.BATTLEFIELD.select(_loc2_,dofus.Constants.CELL_PATH_OVER_COLOR);
      }
      return false;
   }
}
