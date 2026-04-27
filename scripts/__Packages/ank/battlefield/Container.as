class ank.battlefield.Container extends MovieClip
{
   var _datacenter;
   var mask_mc;
   function Container(d, gfile, ofile)
   {
      super();
      this.initialize(d,gfile,ofile);
   }
   function initialize(d, gfile, ofile)
   {
      var _loc1_ = this;
      if(d == undefined)
      {
         ank.utils.Logger.err("pas de _datacenter !");
      }
      _loc1_._datacenter = d;
      _loc1_._groundFile = gfile;
      _loc1_._objectsFile = ofile;
      _loc1_.clear();
   }
   function clear()
   {
      var _loc1_ = this;
      _loc1_.maxDepth = 0;
      _loc1_.minDepth = -1000;
      _loc1_.zoom(100);
      if(_loc1_.InteractionCell == undefined)
      {
         _loc1_.createEmptyMovieClip("InteractionCell",100);
         _loc1_.InteractionCell.loadMovie(_loc1_._groundFile);
      }
      else
      {
         _loc1_.InteractionCell.clear();
      }
      if(_loc1_.Ground == undefined)
      {
         _loc1_.createEmptyMovieClip("Ground",200);
         _loc1_.Ground.loadMovie(_loc1_._groundFile);
      }
      else
      {
         _loc1_.Ground.clear();
      }
      if(_loc1_.Object1 == undefined)
      {
         _loc1_.createEmptyMovieClip("Object1",300);
         _loc1_.Object1.loadMovie(_loc1_._objectsFile);
      }
      else
      {
         _loc1_.Object1.clear();
      }
      _loc1_.createEmptyMovieClip("Grid",400);
      _loc1_.createEmptyMovieClip("Zone",500);
      if(_loc1_.Select == undefined)
      {
         _loc1_.createEmptyMovieClip("Select",600);
         _loc1_.Select.loadMovie(_loc1_._groundFile);
      }
      else
      {
         _loc1_.Select.clear();
      }
      _loc1_.createEmptyMovieClip("Pointer",700);
      if(_loc1_.Object2 == undefined)
      {
         _loc1_.createEmptyMovieClip("Object2",800);
         _loc1_.Object2.loadMovie(_loc1_._objectsFile);
      }
      else
      {
         _loc1_.Object2.clear();
      }
      _loc1_.createEmptyMovieClip("SpriteInfos",900);
      _loc1_.createEmptyMovieClip("Text",1000);
      _loc1_.createEmptyMovieClip("OverHead",1100);
   }
   function applyMask()
   {
      var w = this._datacenter.Map.width - 1;
      var h = this._datacenter.Map.height - 1;
      this.createEmptyMovieClip("mask_mc",10);
      with(this.mask_mc)
      {
         beginFill(0);
         moveTo(0,0);
         lineTo(w * ank.battlefield.Constants.CELL_WIDTH,0);
         lineTo(w * ank.battlefield.Constants.CELL_WIDTH,h * ank.battlefield.Constants.CELL_HEIGHT);
         lineTo(0,h * ank.battlefield.Constants.CELL_HEIGHT);
         lineTo(0,0);
         endFill();
      }
      this.setMask(this.mask_mc);
   }
   function adjusteMap(Void)
   {
      this.zoomMap();
      this.center();
   }
   function setColor(t)
   {
      var _loc1_ = t;
      if(_loc1_ == undefined)
      {
         _loc1_ = new Object();
         _loc1_.ra = 100;
         _loc1_.rb = 0;
         _loc1_.ga = 100;
         _loc1_.gb = 0;
         _loc1_.ba = 100;
         _loc1_.bb = 0;
      }
      var _loc2_ = new Color(this);
      _loc2_.setTransform(_loc1_);
   }
   function zoom(zFactor)
   {
      this._xscale = zFactor;
      this._yscale = zFactor;
   }
   function getZoom()
   {
      return this._xscale;
   }
   function setXY(x, y)
   {
      this._x = x;
      this._y = y;
   }
   function center(Void)
   {
      var _loc1_ = this;
      var _loc3_ = _loc1_._xscale / 100;
      var _loc2_ = _loc1_._yscale / 100;
      var x = (ank.battlefield.Constants.DISPLAY_WIDTH - ank.battlefield.Constants.CELL_WIDTH * _loc3_ * (_loc1_._datacenter.Map.width - 1)) / 2;
      var y = (ank.battlefield.Constants.DISPLAY_HEIGHT - ank.battlefield.Constants.CELL_HEIGHT * _loc2_ * (_loc1_._datacenter.Map.height - 1)) / 2;
      _loc1_.setXY(x,y);
   }
   function zoomMap(Void)
   {
      var _loc3_ = this._datacenter.Map.width;
      var _loc2_ = this._datacenter.Map.height;
      var _loc1_ = 0;
      if(_loc3_ > ank.battlefield.Constants.DEFAULT_MAP_WIDTH)
      {
         if(_loc2_ > ank.battlefield.Constants.DEFAULT_MAP_HEIGHT)
         {
            if(_loc2_ > _loc3_)
            {
               _loc1_ = ank.battlefield.Constants.DISPLAY_WIDTH / (ank.battlefield.Constants.CELL_WIDTH * (_loc3_ - 1)) * 100;
            }
            else
            {
               _loc1_ = ank.battlefield.Constants.DISPLAY_HEIGHT / (ank.battlefield.Constants.CELL_HEIGHT * (_loc2_ - 1)) * 100;
            }
            this.zoom(_loc1_,false);
         }
      }
   }
   function onClear(mc)
   {
      mc.__proto__ = MovieClip.prototype;
   }
}
