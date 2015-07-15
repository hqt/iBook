/* jshint indent: 2 */

module.exports = function (sequelize, DataTypes) {
    return sequelize.define('Song', {
        SongID: {
            type: DataTypes.INTEGER(10),
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        AuthorID: {
            type: DataTypes.INTEGER(10),
            allowNull: false,
        },
        SongName: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        SongContent: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        SongPublishYear: {
            type: DataTypes.DATE,
            allowNull: false,
        }
    });
};
