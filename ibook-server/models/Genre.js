/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Genre', { 
    GenreID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    ParentGenreID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    CreatedGenreUserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    GenreName: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    GenreDescription: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    DateCreated: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  });
};
