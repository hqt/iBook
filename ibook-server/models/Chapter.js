/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Chapter', { 
    ChapterID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    BookID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    ChapterName: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    ChapterContent: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    ChapterDescription: {
      type: DataTypes.STRING,
      allowNull: true,
    }
  });
};
