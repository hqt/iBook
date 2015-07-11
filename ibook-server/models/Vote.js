/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Vote', { 
    VoteID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    UserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    PostID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    ReplyID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    QuoteID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    BookID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    ChapterID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    VoteType: {
      type: DataTypes.INTEGER(6),
      allowNull: true,
    },
    DateCreated: {
      type: DataTypes.STRING,
      allowNull: true,
    }
  });
};
