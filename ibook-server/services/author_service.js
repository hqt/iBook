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

var insertAuthor = function insertAuthor(firstName, middleName, lastName, birthDate, birthPlace, diedYear,
                                         penName, country, occupation, notableWork, bibliography, callback) {

    // database connection
    var dbc;

    // user id for later reference
    var userId;
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
                FirstName: firstName,
                MiddleName: middleName,
                LastName: lastName,
                BirthDate: birthDate,
                BirthPlace: birthPlace,
                diedYear: diedYear,
                PenName: penName,
                Country: country,
                Occupation: occupation,
                NotableWork: notableWork,
                Bibliography: bibliography,
                DateCreated: dateCreated,
                DateUpdated: dateUpdated
            };
            var query = "INSERT INTO Author SET ?";
            dbc.query(query, params, callback);
        },

        function(result, rows, callback) {
            var authorId = result.insertId;
            callback(null, authorId);
        }

    ],  function (error, userData) {
        if (dbc) dbc.release();
        if (error) {
            console.log('Error Inserting Author');
            console.log(error);
        } else {
            callback(null, userData);
        }
    });


};

module.exports.getAllAuthors = getAllAuthors;
module.exports.insertAuthor = insertAuthor;