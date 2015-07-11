/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Share', { 
    ShareID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    UserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    PostID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    ReplyID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    QuoteID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    SocialProviderID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    DateCreated: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  });
};
