/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Author', { 
    AuthorID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    AuthorName: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    AuthorDescription: {
      type: DataTypes.STRING,
      allowNull: false,
    }
  });
};
