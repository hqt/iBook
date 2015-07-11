/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Notification', { 
    NotificationID: {
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
    NotificationMessage: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    State: {
      type: DataTypes.INTEGER(6),
      allowNull: true,
    }
  });
};
