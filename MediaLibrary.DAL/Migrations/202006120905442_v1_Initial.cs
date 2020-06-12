namespace Library.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class v1_Initial : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Categories",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.Media",
                c => new
                    {
                        Id = c.Int(nullable: false, identity: true),
                        Name = c.String(),
                        Url = c.String(),
                        Path = c.String(),
                        Type = c.Int(nullable: false),
                        Done = c.Boolean(nullable: false),
                    })
                .PrimaryKey(t => t.Id);
            
            CreateTable(
                "dbo.MediaCategories",
                c => new
                    {
                        Media_Id = c.Int(nullable: false),
                        Category_Id = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.Media_Id, t.Category_Id })
                .ForeignKey("dbo.Media", t => t.Media_Id, cascadeDelete: true)
                .ForeignKey("dbo.Categories", t => t.Category_Id, cascadeDelete: true)
                .Index(t => t.Media_Id)
                .Index(t => t.Category_Id);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.MediaCategories", "Category_Id", "dbo.Categories");
            DropForeignKey("dbo.MediaCategories", "Media_Id", "dbo.Media");
            DropIndex("dbo.MediaCategories", new[] { "Category_Id" });
            DropIndex("dbo.MediaCategories", new[] { "Media_Id" });
            DropTable("dbo.MediaCategories");
            DropTable("dbo.Media");
            DropTable("dbo.Categories");
        }
    }
}
