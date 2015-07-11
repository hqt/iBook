/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Activity', { 
    ActivityID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    UserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    ProfileView: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    },
    LastLoginIP: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
    }
  });
};
