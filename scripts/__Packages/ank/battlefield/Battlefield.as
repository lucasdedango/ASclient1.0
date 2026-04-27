class ank.battlefield.Battlefield extends MovieClip
{
   var _container;
   var _datacenter;
   var bMapBuild;
   var gridHandler;
   var interactionHandler;
   var mapHandler;
   var overHeadHandler;
   var pointerHandler;
   var spriteHandler;
   var textHandler;
   var zoneHandler;
   var bGhostView = false;
   function Battlefield(d, gfile, ofile)
   {
      super();
      this.initialize(d,gfile,ofile);
   }
   function initialize(d, gfile, ofile, localPlayerID)
   {
      var _loc1_ = this;
      _loc1_._datacenter = d;
      if(!_loc1_.initializeDatacenter())
      {
         ank.utils.Logger.err("BattleField -> Init datacenter impossible");
      }
      ank.utils.Extensions.addExtensions();
      _loc1_.attachClassMovie(ank.battlefield.Container,"_container",10,[_loc1_._datacenter,gfile,ofile]);
      _loc1_.createHandlers();
      _loc1_.bMapBuild = false;
   }
   function clear()
   {
      var _loc1_ = this;
      _loc1_._container.clear();
      ank.utils.Timer.clear();
      ank.utils.CyclicTimer.clear();
      _loc1_.initializeDatacenter();
      _loc1_.createHandlers();
      _loc1_.bMapBuild = false;
   }
   function setColor(t)
   {
      this._container.setColor(t);
   }
   function cleanMap(nPermanentLevel)
   {
      var _loc1_ = this;
      var _loc2_ = nPermanentLevel;
      if(_loc1_.isMapBuild)
      {
         if(_loc2_ == undefined)
         {
            _loc2_ = Infinity;
         }
         else
         {
            _loc2_ = Number(_loc2_);
         }
         _loc1_.mapHandler.initializeMap(_loc2_);
         _loc1_.unSelect(true);
         _loc1_.clearAllZones();
         _loc1_.clearPointer();
         _loc1_.removeGrid();
         _loc1_.clearAllSprites();
         _loc1_.overHeadHandler.clear();
         _loc1_.textHandler.clear();
         ank.utils.Timer.clear();
         ank.utils.CyclicTimer.clear();
      }
   }
   function getZoom()
   {
      return this._container.getZoom();
   }
   function showContainer(bool)
   {
      this._container._visible = bool;
   }
   function zoom(nFactor)
   {
      this._container.zoom(nFactor);
   }
   function buildMap(id, name, w, h, bgID, data)
   {
      var _loc1_ = this;
      _loc1_.clear();
      var _loc2_ = ank.battlefield.utils.Compressor.uncompressMap(id,name,w,h,bgID,data);
      _loc1_.mapHandler.build(_loc2_);
      _loc1_.bMapBuild = true;
      _loc1_.onMapLoaded();
   }
   function buildMultiMap(w, h, bgID, data, coordX, coordY)
   {
      var _loc1_ = this;
      var _loc2_ = ank.battlefield.utils.Compressor.uncompressMap(null,null,w,h,bgID,data);
      _loc1_.mapHandler.buildMulti(_loc2_,coordX,coordY);
      _loc1_.bMapBuild = true;
      _loc1_.onMapLoaded();
   }
   function updateCell(cellNum, compressData, maskHexStr, nPermanentLevel)
   {
      var _loc1_ = this;
      var _loc2_;
      if(_loc1_.isMapBuild)
      {
         if(compressData == undefined)
         {
            _loc1_.mapHandler.initializeCell(cellNum,Infinity);
         }
         else
         {
            _loc2_ = ank.battlefield.utils.Compressor.uncompressCell(compressData,true);
            _loc1_.mapHandler.updateCell(cellNum,_loc2_,maskHexStr,nPermanentLevel);
         }
      }
   }
   function setObject2Frame(cellNum, frame)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.mapHandler.setObject2Frame(cellNum,frame);
   }
   function setObject2Interactive(cellNum, bInteractive, nPermanentLevel)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.mapHandler.setObject2Interactive(cellNum,bInteractive,nPermanentLevel);
   }
   function updateCellObject2WithExternalClip(cellNum, sFile, nPermanentLevel)
   {
      var _loc1_ = new ank.battlefield.datacenter.Cell();
      _loc1_.layerObject2Num = sFile;
      this.mapHandler.updateCell(cellNum,_loc1_,"4",nPermanentLevel);
   }
   function initializeCell(cellNum, nPermanentLevel)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.mapHandler.initializeCell(cellNum,nPermanentLevel);
   }
   function select(cellList, col)
   {
      var _loc1_ = cellList;
      var _loc2_ = this;
      if(_loc2_.isMapBuild)
      {
         if(typeof _loc1_ == "object")
         {
            _loc2_.selectionHandler.selectMultiple(true,_loc1_,col);
         }
         else if(typeof _loc1_ == "number")
         {
            _loc2_.selectionHandler.select(true,_loc1_,col);
         }
      }
   }
   function unSelect(bAll, cellList)
   {
      var _loc1_ = this;
      var _loc2_ = cellList;
      if(_loc1_.isMapBuild)
      {
         if(bAll)
         {
            _loc1_.selectionHandler.clear();
         }
         else if(typeof _loc2_ == "object")
         {
            _loc1_.selectionHandler.selectMultiple(false,_loc2_);
         }
         else if(typeof _loc2_ == "number")
         {
            _loc1_.selectionHandler.select(false,_loc2_);
         }
      }
   }
   function setInteraction(state)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.interactionHandler.setEnabled(state);
   }
   function setInteractionOnCell(cellNum, state)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.interactionHandler.setEnabledCell(cellNum,state);
   }
   function drawZone(cellNum, radius, layer, col, shape)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.zoneHandler.drawZone(cellNum,radius,layer,col,shape);
   }
   function clearZone(cellNum, radius, layer)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.zoneHandler.clearZone(cellNum,radius,layer);
   }
   function clearZoneLayer(layer)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.zoneHandler.clearZoneLayer(layer);
   }
   function clearAllZones(Void)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.zoneHandler.clear();
   }
   function clearPointer(Void)
   {
      this.pointerHandler.clear();
   }
   function hidePointer(Void)
   {
      this.pointerHandler.hide();
   }
   function addPointerShape(shape, size, col, cellNumRef)
   {
      this.pointerHandler.addShape(shape,size,col,cellNumRef);
   }
   function drawPointer(cellNum)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.pointerHandler.draw(cellNum);
   }
   function addSprite(id, spriteData)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.addSprite(id,spriteData);
   }
   function clearAllSprites(Void)
   {
      this.spriteHandler.clear();
   }
   function removeSprite(id, bKeepData)
   {
      var _loc1_ = this;
      var _loc2_ = id;
      if(_loc1_.isMapBuild)
      {
         _loc1_.hideSpriteOverHead(_loc2_);
         _loc1_.removeSpriteBubble(_loc2_);
         _loc1_.spriteHandler.removeSprite(_loc2_,bKeepData);
      }
   }
   function hideSprite(id, bool)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.hideSprite(id,bool);
   }
   function setSpritePosition(id, cellNum, dir)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpritePosition(id,cellNum,dir);
   }
   function moveSprite(id, compressedPath, seq, bClearSequencer, bForcedRun, bForcedWalk, runLimit)
   {
      var _loc2_ = this;
      var _loc1_;
      if(_loc2_.isMapBuild)
      {
         _loc1_ = ank.battlefield.utils.Compressor.extractFullPath(_loc2_.mapHandler,compressedPath);
         if(_loc1_ != undefined)
         {
            _loc2_.spriteHandler.moveSprite(id,_loc1_,seq,bClearSequencer,false,bForcedRun,bForcedWalk,runLimit);
         }
      }
   }
   function slideSprite(id, cellNum, seq)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.slideSprite(id,cellNum,seq);
   }
   function autoCalculateSpriteDirection(id, cellNum)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.autoCalculateSpriteDirection(id,cellNum);
   }
   function setForcedSpriteAnim(id, anim)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpriteAnim(id,anim,true);
   }
   function setSpriteAnim(id, anim)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpriteAnim(id,anim);
   }
   function setSpriteLoopAnim(id, anim, nTimer)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpriteLoopAnim(id,anim,nTimer);
   }
   function setSpriteGfx(id, file)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpriteGfx(id,file);
   }
   function setSpriteColorTransform(id, t)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.setSpriteColorTransform(id,t);
   }
   function spriteLaunchVisualEffect(id, effectData, cellNum, displayType, spriteAnimation)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.spriteHandler.launchVisualEffect(id,effectData,cellNum,displayType,spriteAnimation);
   }
   function addSpriteBubble(id, text)
   {
      var _loc1_ = this._datacenter.Sprites.getItemAt(id);
      var _loc2_;
      var _loc3_;
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[addSpriteBubble] Sprite inexistant");
      }
      else if(!_loc1_.bInMove)
      {
         _loc2_ = _loc1_.sprite_mc;
         var x = _loc2_._x;
         _loc3_ = _loc2_._y;
         if(x == 0 || _loc3_ == 0)
         {
            ank.utils.Logger.err("[addSpriteBubble] le sprite n\'est pas encore placé");
         }
         else
         {
            this.textHandler.addBubble(id,x,_loc3_,text);
         }
      }
   }
   function removeSpriteBubble(id)
   {
      var _loc1_ = this._datacenter.Sprites.getItemAt(id);
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[hideSpriteBubble] Sprite inexistant");
      }
      else
      {
         this.textHandler.removeBubble(id);
      }
   }
   function addSpriteOverHeadItem(id, layerName, className, args, delay)
   {
      var _loc1_ = this._datacenter.Sprites.getItemAt(id);
      var _loc2_;
      var _loc3_;
      if(_loc1_ == undefined)
      {
         ank.utils.Logger.err("[addSpriteOverHeadItem] Sprite inexistant");
      }
      else if(!_loc1_.bInMove)
      {
         if(_loc1_.bVisible)
         {
            _loc2_ = _loc1_.sprite_mc;
            var x = _loc2_._x;
            _loc3_ = _loc2_._y;
            this.overHeadHandler.addOverHeadItem(id,x,_loc3_,_loc2_,layerName,className,args,delay);
         }
      }
   }
   function removeSpriteOverHeadLayer(id, layerName)
   {
      this.overHeadHandler.removeOverHeadLayer(id,layerName);
   }
   function hideSpriteOverHead(id)
   {
      this.overHeadHandler.removeOverHead(id);
   }
   function addSpriteExtraClip(id, clipFile, col)
   {
      this.spriteHandler.addSpriteExtraClip(id,clipFile,col);
   }
   function removeSpriteExtraClip(id)
   {
      this.spriteHandler.removeSpriteExtraClip(id);
   }
   function showSpritePoints(id, value, col)
   {
      this.spriteHandler.showSpritePoints(id,value,col);
   }
   function setSpriteGhostView(bool)
   {
      this.bGhostView = bool;
      this.spriteHandler.setSpriteGhostView(bool);
   }
   function drawGrid(Void)
   {
      var _loc1_ = this;
      if(_loc1_.isMapBuild)
      {
         if(_loc1_.gridHandler.bGridVisible)
         {
            _loc1_.removeGrid();
         }
         else
         {
            _loc1_.gridHandler.draw();
         }
      }
   }
   function removeGrid(Void)
   {
      if(!this.isMapBuild)
      {
         return undefined;
      }
      this.gridHandler.clear();
   }
   function addVisualEffectOnSprite(id, effectData, cellNum, displayType)
   {
      var _loc2_ = this;
      var _loc1_;
      if(_loc2_.isMapBuild)
      {
         _loc1_ = _loc2_._datacenter.Sprites.getItemAt(id);
         if(_loc1_ == undefined)
         {
            ank.utils.Logger.err("[addVisualEffectOnSprite] Sprite inexistant");
         }
         else
         {
            _loc2_.visualEffectHandler.addEffect(_loc1_,effectData,cellNum,displayType);
         }
      }
   }
   function initializeDatacenter(Void)
   {
      var _loc1_ = this;
      if(_loc1_._datacenter == undefined)
      {
         return false;
      }
      _loc1_._datacenter.Map = new ank.battlefield.datacenter.Map();
      _loc1_._datacenter.Sprites = new ank.utils.ExtendedObject();
      return true;
   }
   function createHandlers(Void)
   {
      var _loc1_ = this;
      _loc1_.mapHandler = new ank.battlefield.MapHandler(_loc1_,_loc1_._container,_loc1_._datacenter);
      _loc1_.spriteHandler = new ank.battlefield.SpriteHandler(_loc1_,_loc1_._container.Object2.clips,_loc1_._datacenter.Sprites);
      _loc1_.interactionHandler = new ank.battlefield.InteractionHandler(_loc1_._container.InteractionCell);
      _loc1_.zoneHandler = new ank.battlefield.ZoneHandler(_loc1_,_loc1_._container.Zone);
      _loc1_.pointerHandler = new ank.battlefield.PointerHandler(_loc1_,_loc1_._container.Pointer);
      _loc1_.selectionHandler = new ank.battlefield.SelectionHandler(_loc1_,_loc1_._container.Select,_loc1_._datacenter);
      _loc1_.gridHandler = new ank.battlefield.GridHandler(_loc1_._container.Grid,_loc1_._datacenter);
      _loc1_.visualEffectHandler = new ank.battlefield.VisualEffectHandler(_loc1_,_loc1_._container.Object2.clips);
      _loc1_.textHandler = new ank.battlefield.TextHandler(_loc1_,_loc1_._container.Text,_loc1_._datacenter);
      _loc1_.overHeadHandler = new ank.battlefield.OverHeadHandler(_loc1_,_loc1_._container.OverHead);
      if(_global.GAC == undefined)
      {
         _global.GAC = new ank.battlefield.GlobalSpriteHandler();
      }
   }
   function get isMapBuild()
   {
      if(this.bMapBuild)
      {
         return true;
      }
      ank.utils.Logger.err("[isMapBuild] Carte non chargée");
      return false;
   }
}
