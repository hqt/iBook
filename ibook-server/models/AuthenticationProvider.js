/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('AuthenticationProvider', { 
    ProviderKey: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    UserId: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    SocialProviderID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    }
  });
};
