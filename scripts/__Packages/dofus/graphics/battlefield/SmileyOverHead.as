class dofus.graphics.battlefield.SmileyOverHead extends MovieClip
{
   function SmileyOverHead(file, smileyID)
   {
      super();
      this.initialize();
      this.drawSmiley(file,smileyID);
   }
   function initialize()
   {
      var _loc1_ = this;
      _loc1_.createEmptyMovieClip("smiley_mc",10);
      _loc1_.smiley_mc.attachClassMovie(ank.utils.SWFLoader,"swfLoader_mc",10);
      _loc1_.smiley_mc._y = 10;
   }
   function drawSmiley(file, smileyID)
   {
      var _loc1_ = this;
      _loc1_.smiley_mc.swfLoader_mc.loadSWF(file,smileyID);
      var i = 0;
      _loc1_.onEnterFrame = function()
      {
         var _loc1_ = this;
         if(i >= 100)
         {
            _loc1_.smiley_mc._xscale = _loc1_.smiley_mc._yscale = 100;
            delete _loc1_.onEnterFrame;
         }
         else
         {
            i += 40;
            _loc1_.smiley_mc._xscale = _loc1_.smiley_mc._yscale = i;
            if(i >= 100)
            {
               i = 100;
            }
         }
      };
   }
}
