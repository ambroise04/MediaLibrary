namespace Library.DAL.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class v3_RemoveManyToManyRelationship : DbMigration
    {
        public override void Up()
        {
            DropForeignKey("dbo.MediaCategories", "Media_Id", "dbo.Media");
            DropForeignKey("dbo.MediaCategories", "Category_Id", "dbo.Categories");
            DropIndex("dbo.MediaCategories", new[] { "Media_Id" });
            DropIndex("dbo.MediaCategories", new[] { "Category_Id" });
            AddColumn("dbo.Media", "Category_Id", c => c.Int());
            CreateIndex("dbo.Media", "Category_Id");
            AddForeignKey("dbo.Media", "Category_Id", "dbo.Categories", "Id");
            DropTable("dbo.MediaCategories");
        }
        
        public override void Down()
        {
            CreateTable(
                "dbo.MediaCategories",
                c => new
                    {
                        Media_Id = c.Int(nullable: false),
                        Category_Id = c.Int(nullable: false),
                    })
                .PrimaryKey(t => new { t.Media_Id, t.Category_Id });
            
            DropForeignKey("dbo.Media", "Category_Id", "dbo.Categories");
            DropIndex("dbo.Media", new[] { "Category_Id" });
            DropColumn("dbo.Media", "Category_Id");
            CreateIndex("dbo.MediaCategories", "Category_Id");
            CreateIndex("dbo.MediaCategories", "Media_Id");
            AddForeignKey("dbo.MediaCategories", "Category_Id", "dbo.Categories", "Id", cascadeDelete: true);
            AddForeignKey("dbo.MediaCategories", "Media_Id", "dbo.Media", "Id", cascadeDelete: true);
        }
    }
}
