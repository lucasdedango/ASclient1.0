class dofus.graphics.battlefield.TextOverHead extends MovieClip
{
   static var BACKGROUND_ALPHA = 80;
   static var BACKGROUND_COLOR = 13918;
   static var BACKGROUND_BORDER_COLOR = 0;
   static var TEXT_FORMAT = new TextFormat("Verdana",10,16777215,false);
   static var CORNER_RADIUS = 0;
   static var WIDTH_SPACER = 2;
   static var HEIGHT_SPACER = 2;
   function TextOverHead(sText, sFile, nFrame)
   {
      super();
      this.initialize();
      this.draw(sText,sFile,nFrame);
   }
   function initialize()
   {
      var _loc1_ = this;
      _loc1_.createEmptyMovieClip("_mcGfx",10);
      _loc1_.createEmptyMovieClip("_mcTxtBackground",20);
      _loc1_.createTextField("_txtText",30,0,-2,0,0);
   }
   function draw(sText, sFile, nFrame)
   {
      var _loc1_ = this;
      var bGfx = sFile != undefined && nFrame != undefined;
      _loc1_._txtText.autoSize = "center";
      _loc1_._txtText.text = sText;
      _loc1_._txtText.selectable = false;
      _loc1_._txtText.setTextFormat(dofus.graphics.battlefield.TextOverHead.TEXT_FORMAT);
      var _loc3_ = _loc1_._txtText.textHeight + dofus.graphics.battlefield.TextOverHead.HEIGHT_SPACER * 2;
      var _loc2_ = _loc1_._txtText.textWidth + dofus.graphics.battlefield.TextOverHead.WIDTH_SPACER * 2;
      _loc1_._mcTxtBackground.lineStyle(1,dofus.graphics.battlefield.TextOverHead.BACKGROUND_BORDER_COLOR);
      _loc1_._mcTxtBackground.beginFill(dofus.graphics.battlefield.TextOverHead.BACKGROUND_COLOR,dofus.graphics.battlefield.TextOverHead.BACKGROUND_ALPHA);
      _loc1_._mcTxtBackground.moveTo(dofus.graphics.battlefield.TextOverHead.CORNER_RADIUS,0);
      _loc1_._mcTxtBackground.lineTo(_loc2_ - dofus.graphics.battlefield.TextOverHead.CORNER_RADIUS,0);
      _loc1_._mcTxtBackground.lineTo(_loc2_,dofus.graphics.battlefield.TextOverHead.CORNER_RADIUS);
      _loc1_._mcTxtBackground.lineTo(_loc2_,_loc3_ - dofus.graphics.battlefield.TextOverHead.CORNER_RADIUS);
      _loc1_._mcTxtBackground.lineTo(_loc2_ - dofus.graphics.battlefield.TextOverHead.CORNER_RADIUS,_loc3_);
      _loc1_._mcTxtBackground.lineTo(dofus.graphics.battlefield.TextOverHead.CORNER_RADIUS,_loc3_);
      _loc1_._mcTxtBackground.lineTo(0,_loc3_ - dofus.graphics.battlefield.TextOverHead.CORNER_RADIUS);
      _loc1_._mcTxtBackground.lineTo(0,dofus.graphics.battlefield.TextOverHead.CORNER_RADIUS);
      _loc1_._mcTxtBackground.endFill();
      _loc1_._mcTxtBackground._x = (- (_loc2_ + dofus.graphics.battlefield.TextOverHead.WIDTH_SPACER)) / 2;
      if(bGfx)
      {
         _loc1_._mcGfx.attachClassMovie(ank.utils.SWFLoader,"_mcSwfLoader",10);
         _loc1_._mcGfx._mcSwfLoader.loadSWF(sFile,nFrame);
      }
   }
}
