/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('SubscribeUser', { 
    SubscribeUserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    MainUserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    FollowingUserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    DateCreated: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  });
};
