/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Profile', { 
    ProfileID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    UserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    Quote: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    About: {
      type: DataTypes.STRING,
      allowNull: true,
    },
    HomePage: {
      type: DataTypes.STRING,
      allowNull: true,
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
