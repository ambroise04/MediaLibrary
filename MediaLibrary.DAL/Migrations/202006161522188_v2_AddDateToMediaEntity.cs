namespace Library.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class v2_AddDateToMediaEntity : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.Media", "DateOfAddition", c => c.DateTime(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.Media", "DateOfAddition");
        }
    }
}
