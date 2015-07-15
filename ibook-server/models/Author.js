/* jshint indent: 2 */

module.exports = function (sequelize, DataTypes) {
    return sequelize.define('Author', {
        // define the table's name
        tableName: 'Author',
        AuthorID: {
            type: DataTypes.INTEGER(10),
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        AuthorName: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        AuthorDescription: {
            type: DataTypes.STRING,
            allowNull: false,
        }
    });
};
