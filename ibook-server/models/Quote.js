/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('Quote', { 
    QuoteID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    AuthorID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    UserID: {
      type: DataTypes.INTEGER(10),
      allowNull: false,
    },
    BookID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    ChapterID: {
      type: DataTypes.INTEGER(10),
      allowNull: true,
    },
    QuoteContent: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    Certificated: {
      type: DataTypes.INTEGER(6),
      allowNull: false,
    },
    DateCreated: {
      type: DataTypes.DATE,
      allowNull: false,
    }
  });
};
