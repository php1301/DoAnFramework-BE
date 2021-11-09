using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace ChatLife.Migrations
{
    public partial class v2Migration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "SeenBy",
                table: "Message",
                type: "longtext",
                nullable: true)
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateTable(
                name: "MessageSeen",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    MessageCode = table.Column<long>(type: "bigint", nullable: false),
                    UserCode = table.Column<string>(type: "varchar(255)", nullable: true)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Created = table.Column<DateTime>(type: "datetime(6)", nullable: false),
                    MessageId = table.Column<long>(type: "bigint", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MessageSeen", x => x.Id);
                    table.ForeignKey(
                        name: "FK_MessageSeen_Message_MessageId",
                        column: x => x.MessageId,
                        principalTable: "Message",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_MessageSeen_User_UserCode",
                        column: x => x.UserCode,
                        principalTable: "User",
                        principalColumn: "Code",
                        onDelete: ReferentialAction.Restrict);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_MessageSeen_MessageId",
                table: "MessageSeen",
                column: "MessageId");

            migrationBuilder.CreateIndex(
                name: "IX_MessageSeen_UserCode",
                table: "MessageSeen",
                column: "UserCode");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "MessageSeen");

            migrationBuilder.DropColumn(
                name: "SeenBy",
                table: "Message");
        }
    }
}
