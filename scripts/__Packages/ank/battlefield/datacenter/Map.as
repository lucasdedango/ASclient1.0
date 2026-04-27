class ank.battlefield.datacenter.Map extends Object
{
   var originalsCellsBackup;
   function Map()
   {
      super();
      this.initialize();
   }
   function initialize()
   {
      this.originalsCellsBackup = new ank.utils.ExtendedObject();
   }
}
