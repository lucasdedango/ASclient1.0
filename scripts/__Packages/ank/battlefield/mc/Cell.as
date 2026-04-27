class ank.battlefield.mc.Cell extends MovieClip
{
   var _battlefield;
   var num;
   function Cell()
   {
      super();
   }
   function initialize(b, num)
   {
      this._battlefield = b;
      this.num = num;
   }
   function _release(Void)
   {
      this._battlefield.onCellRelease(this);
   }
   function _rollOver(Void)
   {
      this._battlefield.onCellRollOver(this);
   }
   function _rollOut(Void)
   {
      this._battlefield.onCellRollOut(this);
   }
}
