/**
 * Created by Huynh Quang Thao on 7/16/15.
 */

var async = require('async');
var pool = require('../config/mysql').pool;

var getAllAuthors = function getAllAuthorsFn() {
    // database connection
    var dbc;

    async.waterfall([

        // get connection
        function (callback) {
            pool.getConnection(callback);
        },

        // query to database
        function (connection, callback) {
            dbc = connection;
            dbc.query("SELECT * FROM Author", callback);
        },

        // get data
        function (rows, fields, callback) {
            if (!rows || rows.length == 0) {
                return;
            }
            console.log("result: ");
            console.log(rows);
            callback(null, rows);
        },

        function(error, user_data) {
            console.log("last block of service");
            console.log(user_data);
            if (dbc) dbc.release();
            if (error) {

            } else {
                callback(null, user_data);
            }
        }
    ]);
};

var helperAsync = function() {
    async.waterfall([
       function(callback) {
           console.log('task 1');
           callback();
       },
        function (callback) {
            console.log('task 2');
            callback();
        }
    ]);
};



module.exports.getAllAuthors = getAllAuthors;
module.exports.helperAsync = helperAsync;