/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Tag', { 
    TagID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    ParentTagID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    CreatedTagUserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    TagName: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    TagDescription: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    DateCreated: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  });
};