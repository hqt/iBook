/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('SocialProvider', { 
    SocialProviderID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    SocialProviderName: {
      type: DataTypes.STRING,
      allowNull: false,
    }
  });
};
