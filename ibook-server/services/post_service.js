/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

var async = require('async');
var pool = require('../config/mysql').pool;

var insertPost = function insertPost(userid, bookid, chapterid, quoteid, post) {
    var dbc;
    async.waterfall([
        // get connection
        function (callback) {
            pool.getConnection(callback);
        },

        // query database
        function (connection, callback) {
            dbc = connection;
            var query = "INSERT INTO USER (username, password, EmailAddress, FirstName, LastName, AvatarURL, DateCreated, DateUpdated" +
                "";
            dbc.query(query, callback);
        },

        // get query result
        function (rows, fields, callback) {

        },

        function (error, userData) {
            if (dbc) dbc.release();
            if (error) {

            } else {
                callback(null, userData);
            }
        }
    ]);

};