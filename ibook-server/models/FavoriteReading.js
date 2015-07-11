/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('FavoriteReading', { 
    FavoriteReadingID: {
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
    }
  });
};
