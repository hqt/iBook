/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('PostGenre', { 
    PostGenreID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    GenreID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    PostID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    }
  });
};
