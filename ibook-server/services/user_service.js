/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

var async = require('async');
var pool = require('../config/mysql').pool;
var co

var createUser = function createUser (username, password, email, firstName, lastName, avatarURL, // user table
                                      quote, about, homepage,                                    // profile table
                                      lastLoginIP,                                               // activity table
                                      callback) {
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

        // insert user table
        function (connection, callback) {
            dbc = connection;
            var params = {
                Username: username,
                Password: password,
                EmailAddress: email,
                FirstName: firstName,
                LastName: lastName,
                avatarURL: avatarURL,
                state: 1,
                DateCreated: dateCreated,
                DateUpdated: dateUpdated
            };
            var query = "INSERT INTO USER SET ?";
            dbc.query(query, params, callback);
        },

        // insert activity table
        function(result, rows, callback) {
            userId = result.insertId;
            var params = {
                ActivityID: userId,
                ProfileView: 0,
                LastLoginIP: lastLoginIP
            };
            var query = "INSERT INTO ACTIVITY SET ?";
            dbc.query(query, params, callback);
        },

        // insert profile table
        function (result, rows, callback) {
            var params = {
                ProfileID: userId,
                Quote: quote,
                About: about,
                HomePage: homepage,
                DateCreated: dateCreated,
                DateUpdated: dateUpdated
            };
            var query = "INSERT INTO PROFILE SET ?";
            dbc.query(query, params, callback);
        },

        // finish insert into profile. call finish
        function (result, rows, callback) {
            callback(null, userId);
        }

    ],  function (error, userData) {
        if (dbc) dbc.release();
        if (error) {
            console.log('Error Inserting User');
            console.log(error);
            //report_error(error);
        } else {
            callback(null, userData);
        }
    });

};

var deleteUser = function deleteUser(userId, callback) {
    var dbc;
    async.waterfall([
        function (callback) {
            pool.getConnection(callback);
        },

        // change user to deactive state
        function (connection, callback) {
            dbc = connection;
            var query = 'UPDATE USER SET STATE = ? WHERE UserID = ?';
            dbc.query(query, [2, userId], callback);
        },

        // get delete result. rows in this case unidentify
        function (result, rows, callback) {
            callback(null, result.affectedRows);
        }

    ], function (error, userData) {
        if (dbc) dbc.release();
        if (error) {
            console.log(error);
        } else {
            callback(null, userData);
        }
    });

};



module.exports.createUser = createUser;
module.exports.deleteUser = deleteUser;