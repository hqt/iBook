/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Book', { 
    BookID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    AuthorID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    BookName: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    BookPublisher: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    BookYear: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    BookContent: {
      type: DataTypes.STRING,
      allowNull: false,
    }
  });
};
