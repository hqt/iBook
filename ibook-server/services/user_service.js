/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

var async = require('async');
var pool = require('../config/mysql').pool;

var createUser = function createUser (username, password, email, firstName, middleName, lastName, avatarURL, state, // user table
                                      quote, about, homepage,                 // profile table
                                      lastLoginIP,                            // activity table
                                      socialUserId, socialProviderID,         // social provider table
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
                MiddleName: middleName,
                LastName: lastName,
                avatarURL: avatarURL,
                state: state,
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

        // insert authentication provider table
        function (result, rows, callback) {
            var params = {
                SocialUserId: socialUserId,
                UserId: userId,
                SocialProviderID: socialProviderID
            };
            var query = "INSERT INTO AuthenticationProvider SET ?";
            dbc.query(query,params, callback);
        },

        // finish insert into authentication provider. call finish
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

var isUserExist = function isUserExist (socialUserId, socialNetworkProvider, callback) {
    var dbc;
    async.waterfall([
        function (callback) {
            pool.getConnection(callback);
        },

        function (connection, callback) {
            dbc = connection;
            var query = "SELECT UserID FROM AuthenticationProvider WHERE SocialUserID = ? AND SocialProviderID = ?";
            dbc.query(query, [socialUserId, socialNetworkProvider], callback);
        },

        function (results, fields, callback) {
            if (results.length == 1) {
                return callback(null, results[0].UserID);
            } else if (results.length == 0) {
                return callback(null, 0);
            } else {
                //return callback('database error. cannot duplicated socialUserID and socialProviderID', null);
                return callback(null, 0);
            }
        }
    ],
        // return user id
        function (error, userData) {
        if (dbc) dbc.release();
        if (error) {
            console.log(error);
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
module.exports.isUserExist = isUserExist;