class ank.battlefield.mc.Bubble extends MovieClip
{
   function Bubble(text, x, y, maxW)
   {
      super();
      this.initialize(text,x,y,maxW);
   }
   function initialize(text, x, y, maxW)
   {
      var _loc1_ = this;
      _loc1_._maxW = maxW;
      _loc1_.createTextField("_txtf",20,0,0,150,100);
      _loc1_._txtf.autoSize = "left";
      _loc1_._txtf.wordWrap = true;
      _loc1_._txtf.embedFonts = true;
      _loc1_._txtf.multiline = true;
      _loc1_._txtf.selectable = false;
      _loc1_._txtf.html = true;
      _loc1_.draw(text,x,y);
   }
   function draw(text, x, y)
   {
      var _loc1_ = this;
      _loc1_._txtf.htmlText = text;
      _loc1_._txtf.setTextFormat(ank.battlefield.Constants.BUBBLE_TXTFORMAT);
      var _loc2_ = _loc1_._txtf.textHeight > 10 ? _loc1_._txtf.textHeight : 11;
      var _loc3_ = _loc1_._txtf.textWidth > 10 ? _loc1_._txtf.textWidth + 4 : 11;
      _loc1_.drawBackground(_loc3_,_loc2_);
      _loc1_.adjust(_loc3_ + ank.battlefield.Constants.BUBBLE_MARGIN * 2,_loc2_ + ank.battlefield.Constants.BUBBLE_MARGIN * 2 + ank.battlefield.Constants.BUBBLE_PIC_HEIGHT,x,y);
      var t = ank.battlefield.Constants.BUBBLE_REMOVE_TIMER + text.length * ank.battlefield.Constants.BUBBLE_REMOVE_CHAR_TIMER;
      ank.utils.Timer.setTimer(_loc1_,_loc1_,_loc1_.remove,t);
   }
   function remove()
   {
      this.swapDepths(1);
      this.removeMovieClip();
   }
   function drawBackground(w, h)
   {
      var _loc1_ = this;
      var _loc2_ = ank.battlefield.Constants.BUBBLE_MARGIN * 2;
      _loc1_.createEmptyMovieClip("_bg",10);
      _loc1_._bg.lineStyle(1,ank.battlefield.Constants.BUBBLE_BORDERCOLOR,100);
      _loc1_._bg.beginFill(ank.battlefield.Constants.BUBBLE_BGCOLOR,100);
      _loc1_._bg.moveTo(0,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
      _loc1_._bg.lineTo(ank.battlefield.Constants.BUBBLE_PIC_WIDTH / 2,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
      _loc1_._bg.lineTo(0,0);
      _loc1_._bg.lineTo(ank.battlefield.Constants.BUBBLE_PIC_WIDTH,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
      _loc1_._bg.lineTo(w + _loc2_,- ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
      _loc1_._bg.lineTo(w + _loc2_,- h - _loc2_ - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
      _loc1_._bg.lineTo(0,- h - _loc2_ - ank.battlefield.Constants.BUBBLE_PIC_HEIGHT);
      _loc1_._bg.endFill();
   }
   function adjust(w, h, x, y)
   {
      var _loc1_ = this;
      var _loc2_ = _loc1_._maxW - w;
      var _loc3_ = h + ank.battlefield.Constants.BUBBLE_Y_OFFSET;
      if(x > _loc2_)
      {
         _loc1_._txtf._x = - w + ank.battlefield.Constants.BUBBLE_MARGIN;
         _loc1_._bg._xscale = -100;
      }
      else
      {
         _loc1_._txtf._x = ank.battlefield.Constants.BUBBLE_MARGIN;
      }
      if(y < _loc3_)
      {
         _loc1_._txtf._y = ank.battlefield.Constants.BUBBLE_PIC_HEIGHT + ank.battlefield.Constants.BUBBLE_MARGIN - 3;
         _loc1_._bg._yscale = -100;
      }
      else
      {
         _loc1_._txtf._y = - h + ank.battlefield.Constants.BUBBLE_MARGIN - 3 - ank.battlefield.Constants.BUBBLE_Y_OFFSET;
         _loc1_._bg._y = - ank.battlefield.Constants.BUBBLE_Y_OFFSET;
      }
      _loc1_._x = x;
      _loc1_._y = y;
   }
}
