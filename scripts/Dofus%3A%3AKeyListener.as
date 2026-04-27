Class_KeyListener = function(string)
{
   this.init();
   this.justValidEnter = false;
};
Object.registerClass("Dofus::KeyListener",Class_KeyListener);
Class_KeyListener.prototype.init = function()
{
   this.onKeyUp = function()
   {
   };
   this.onKeyDown = function()
   {
      if(Key.isDown(13))
      {
         var sel = Selection.getFocus();
         var selName = eval(sel)._name;
         if(sel == null || sel == undefined)
         {
            return undefined;
         }
         this.justValidEnter = true;
         switch(selName)
         {
            case "txtName":
            case "txtPass":
               DATACENTER.Player.login = eval(sel)._parent.txtName.text;
               DATACENTER.Player.password = eval(sel)._parent.txtPass.text;
               AKS.connect(dofus.Constants.SERVER_NAME,dofus.Constants.SERVER_PORT);
               break;
            case "txtZone":
               var txt = eval(sel);
               var wispBox = txt._parent._parent;
               if(txt.text.length != 0)
               {
                  AKS.Chat.send(txt.text,wispBox.to);
               }
               wispBox.removeMovieClip();
               break;
            default:
               trace("on est dans : " + selName);
         }
         return undefined;
      }
      if(Selection.getFocus() != undefined)
      {
         return undefined;
      }
      if(Key.isDown(17))
      {
         if(Key.isDown(35))
         {
            if(DATACENTER.Game.isFight)
            {
               AKS.Game.turnEnd();
            }
         }
      }
      if(Key.isDown(16))
      {
         if(Key.isDown(49))
         {
            BATTLEFIELD.drawGrid();
         }
         if(Key.isDown(50))
         {
            BATTLEFIELD.setSpriteGhostView(!BATTLEFIELD.bGhostView);
         }
      }
      if(dofus.Constants.DEBUG)
      {
         if(Key.isDown(17))
         {
            if(Key.isDown(96))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim10");
               INTERFACE.Text.setTextTimer("anim10",2000);
            }
            if(Key.isDown(97))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim11");
               INTERFACE.Text.setTextTimer("anim11",2000);
            }
            if(Key.isDown(98))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim12");
               INTERFACE.Text.setTextTimer("anim12",2000);
            }
            if(Key.isDown(99))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim13");
               INTERFACE.Text.setTextTimer("anim13",2000);
            }
            if(Key.isDown(100))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim14");
               INTERFACE.Text.setTextTimer("anim14",2000);
            }
            if(Key.isDown(101))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim15");
               INTERFACE.Text.setTextTimer("anim15",2000);
            }
            if(Key.isDown(102))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim16");
               INTERFACE.Text.setTextTimer("anim16",2000);
            }
            if(Key.isDown(103))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim17");
               INTERFACE.Text.setTextTimer("anim17",2000);
            }
            if(Key.isDown(104))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim18");
               INTERFACE.Text.setTextTimer("anim18",2000);
            }
            if(Key.isDown(105))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim19");
               INTERFACE.Text.setTextTimer("anim19",2000);
            }
         }
         else
         {
            if(Key.isDown(96))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim0");
               INTERFACE.Text.setTextTimer("anim0",2000);
            }
            if(Key.isDown(97))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim1");
               INTERFACE.Text.setTextTimer("anim1",2000);
            }
            if(Key.isDown(98))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim2");
               INTERFACE.Text.setTextTimer("anim2",2000);
            }
            if(Key.isDown(99))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim3");
               INTERFACE.Text.setTextTimer("anim3",2000);
            }
            if(Key.isDown(100))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim4");
               INTERFACE.Text.setTextTimer("anim4",2000);
            }
            if(Key.isDown(101))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim5");
               INTERFACE.Text.setTextTimer("anim5",2000);
            }
            if(Key.isDown(102))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim6");
               INTERFACE.Text.setTextTimer("anim6",2000);
            }
            if(Key.isDown(103))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim7");
               INTERFACE.Text.setTextTimer("anim7",2000);
            }
            if(Key.isDown(104))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim8");
               INTERFACE.Text.setTextTimer("anim8",2000);
            }
            if(Key.isDown(105))
            {
               BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"anim9");
               INTERFACE.Text.setTextTimer("anim9",2000);
            }
         }
         if(Key.isDown(111))
         {
            BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"die");
            INTERFACE.Text.setTextTimer("die",2000);
         }
         if(Key.isDown(106))
         {
            BATTLEFIELD.setSpriteAnim(DATACENTER.Player.ID,"hit");
            INTERFACE.Text.setTextTimer("hit",2000);
         }
         if(Key.isDown(16))
         {
            if(Key.isDown(107))
            {
               _global.WEAPON_ID++;
               INTERFACE.Text.setTextTimer("Weapon : " + _global.WEAPON_TYPE + "_" + _global.WEAPON_ID,2000);
            }
            if(Key.isDown(109))
            {
               _global.WEAPON_ID--;
               INTERFACE.Text.setTextTimer("Weapon : " + _global.WEAPON_TYPE + "_" + _global.WEAPON_ID,2000);
            }
         }
         else
         {
            if(Key.isDown(107))
            {
               _global.WEAPON_TYPE++;
               INTERFACE.Text.setTextTimer("Weapon : " + _global.WEAPON_TYPE + "_" + _global.WEAPON_ID,2000);
            }
            if(Key.isDown(109))
            {
               _global.WEAPON_TYPE--;
               INTERFACE.Text.setTextTimer("Weapon : " + _global.WEAPON_TYPE + "_" + _global.WEAPON_ID,2000);
            }
         }
         if(Key.isDown(110))
         {
            NIGHTMANAGER.setReferenceTime(44000);
            INTERFACE.Text.setTextTimer("Nuit",2000);
         }
         if(Key.isDown(186))
         {
            NIGHTMANAGER.setReferenceTime(8800);
            INTERFACE.Text.setTextTimer("Jour",2000);
         }
         if(Key.isDown(36))
         {
            INTERFACE.showFps();
         }
         if(Key.isDown(35))
         {
            INTERFACE.hideFps();
         }
      }
   };
   this.setEnabled(true);
};
Class_KeyListener.prototype.setEnabled = function(bool)
{
   if(bool)
   {
      Key.addListener(this);
   }
   else
   {
      Key.removeListener(this);
   }
};
