/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

var async = require('async');
var pool = require('../config/mysql').pool;

var insertGenre = function insertGenre (parentGenreId, createdUserId, genreName, genreDescription, callback) {
    // database connection
    var dbc;
    var dateCreated = new Date();
    var dateUpdated = dateCreated;

    async.waterfall([
        // get connection
        function (callback) {
            pool.getConnection(callback);
        },

        // insert author table
        function (connection, callback) {
            dbc = connection;
            var params = {
                ParentGenreID: parentGenreId,
                createdUserId: createdUserId,
                GenreName: genreName,
                GenreDescription: genreDescription,
                DateCreated: dateCreated,
                DateUpdated: dateUpdated
            };
            var query = "INSERT INTO Genre SET ?";
            dbc.query(query, params, callback);
        },

        // get the result
        function(result, rows, callback) {
            var genreId = result.insertId;
            callback(null, genreId);
        }

    ],  function (error, userData) {
        if (dbc) dbc.release();
        if (error) {
            console.log('Error Inserting Genre');
            console.log(error);
        } else {
            callback(null, userData);
        }
    });
};

var insertTag = function insertGenre (parentTagId, createdUserId, tagName, tagDescription, callback) {
    // database connection
    var dbc;
    var dateCreated = new Date();
    var dateUpdated = dateCreated;

    async.waterfall([
        // get connection
        function (callback) {
            pool.getConnection(callback);
        },

        // insert author table
        function (connection, callback) {
            dbc = connection;
            var params = {
                ParentTagID: parentTagId,
                createdUserId: createdUserId,
                TagName: tagName,
                TagDescription: tagDescription,
                DateCreated: dateCreated,
                DateUpdated: dateUpdated
            };
            var query = "INSERT INTO Tag SET ?";
            dbc.query(query, params, callback);
        },

        // get the result
        function(result, rows, callback) {
            var tagId = result.insertId;
            callback(null, tagId);
        }

    ],  function (error, userData) {
        if (dbc) dbc.release();
        if (error) {
            console.log('Error Inserting Tag');
            console.log(error);
        } else {
            callback(null, userData);
        }
    });
};

module.exports.insertTag = insertTag;
module.exports.insertGenre = insertGenre;