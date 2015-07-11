/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('ReadBook', { 
    ReadBookID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    UserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    BookID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    }
  });
};
