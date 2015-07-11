/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Post', { 
    PostID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    UserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    BookID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    ChapterID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    QuoteID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    PostTitle: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    language: {
      type: DataTypes.STRING,
      allowNull: false,
      defaultValue: 'Vietnamese'
    },
    ViewCount: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    State: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    ReviewStar: {
      type: DataTypes.INTEGER(11),
      allowNull: true,
    },
    PostContent: {
      type: DataTypes.STRING,
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
