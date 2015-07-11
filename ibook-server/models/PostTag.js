/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('PostTag', { 
    PostTagID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    TagID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    PostID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    }
  });
};
