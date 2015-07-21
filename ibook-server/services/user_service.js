/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

var async = require('async');
var pool = require('../config/mysql').pool;

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
                DateCreated: dateCreated,
                DateUpdated: dateUpdated
            };
            var query = "INSERT INTO USER SET ?";
            dbc.query(query, params, callback);
        },

        // insert activity table
        function(result, callback) {
            userId = result.insertId;
            console.log('second user id: ' + userId);
            var params = {
                ActivityID: userId,
                ProfileView: 0,
                LastLoginIP: lastLoginIP
            };
            var query = "INSERT INTO ACTIVITY SET ?";
            dbc.query(query, params, callback);
        },

        // insert profile table
        function (result, callback) {
            userId = result.insertId;
            console.log('inserted userid: '+ userId);
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
        }

    ],  function (error, userData) {
        console.log('end block');
        if (dbc) dbc.release();
        if (error) {
            console.log('error');
            console.log(error);
            //report_error(error);
        } else {
            callback(null, userData);
        }
    });

};

module.exports.createUser = createUser;