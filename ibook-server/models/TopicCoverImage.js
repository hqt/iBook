/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('TopicCoverImage', { 
    TopicCoverImageID: {
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
    ImageURL: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    DateCreated: {
      type: DataTypes.DATE,
      allowNull: true,
    }
  });
};
