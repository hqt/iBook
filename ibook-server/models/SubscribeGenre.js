/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('SubscribeGenre', { 
    SubscribeGenreID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    UserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    GenreID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    DateCreated: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  });
};
