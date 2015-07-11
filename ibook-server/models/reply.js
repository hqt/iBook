/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Reply', { 
    ReplyID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    PostID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    ParentReplyID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    UserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    ViewCount: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    ReviewStar: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    ReplyContent: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    DateCreated: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    DateUpdated: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  });
};
