class ank.battlefield.datacenter.Sprite extends Object
{
   var _accessories;
   var _cellNum;
   var _color1;
   var _color2;
   var _color3;
   var _direction;
   var _oSequencer;
   var bAnimLoop = false;
   var _defaultAnimation = "Static";
   function Sprite(id, clipClass, gfxFile, cellNum, dir)
   {
      super();
      this.initialize(id,clipClass,gfxFile,cellNum,dir);
   }
   function initialize(id, clipClass, gfxFile, cellNum, dir)
   {
      var _loc1_ = this;
      _loc1_.id = id;
      _loc1_.clipClass = clipClass;
      _loc1_.gfxFile = gfxFile;
      _loc1_.CellNum = cellNum;
      _loc1_.Direction = dir != undefined ? dir : 1;
      _loc1_._oSequencer = new ank.utils.Sequencer(10000);
      _loc1_.bInMove = false;
      _loc1_.bVisible = true;
   }
   function get defaultAnimation()
   {
      return this._defaultAnimation;
   }
   function set defaultAnimation(value)
   {
      this._defaultAnimation = value;
   }
   function get CellNum()
   {
      return this._cellNum;
   }
   function set CellNum(value)
   {
      this._cellNum = Number(value);
   }
   function get Direction()
   {
      return this._direction;
   }
   function set Direction(value)
   {
      this._direction = Number(value);
   }
   function get Color1()
   {
      return this._color1;
   }
   function set Color1(value)
   {
      this._color1 = Number(value);
   }
   function get Color2()
   {
      return this._color2;
   }
   function set Color2(value)
   {
      this._color2 = Number(value);
   }
   function get Color3()
   {
      return this._color3;
   }
   function set Color3(value)
   {
      this._color3 = Number(value);
   }
   function get Accessories()
   {
      return this._accessories;
   }
   function set Accessories(value)
   {
      this._accessories = value;
   }
   function get sequencer()
   {
      return this._oSequencer;
   }
   function set sequencer(value)
   {
      this._oSequencer = value;
   }
}
