/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

var async = require('async');
var pool = require('../config/mysql').pool;

var insertTopic = function insertPost(userId, referenceId, type, topicTitle, topicContent, callback) {
    // database connection
    var dbc;
    var dateCreated = new Date();
    var dateUpdated = dateCreated;

    async.waterfall([
        // get connection
        function (callback) {
            pool.getConnection(callback);
        },

        // insert to topic table
        function (connection, callback) {
            dbc = connection;
            var params = {
                UserID: userId,
                ReferenceID: referenceId,
                Type: type,
                Language: 'Viet Nam',
                ViewCount: 0,
                State: 1,
                ReviewStar: null,
                TopicTitle: topicTitle,
                TopicContent: topicContent,
                DateCreated: dateCreated,
                DateUpdated: dateUpdated
            };
            var query = "INSERT INTO Topic SET ?";
            dbc.query(query, params, callback);
        },

        // get the result
        function(result, rows, callback) {
            var topicId = result.insertId;
            callback(null, topicId);

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

var insertReply = function insertReply(userId, referenceId, type, topicTitle, topicContent, callback) {
    // database connection
    var dbc;
    var dateCreated = new Date();
    var dateUpdated = dateCreated;

    async.waterfall([
        // get connection
        function (callback) {
            pool.getConnection(callback);
        },

        // insert to topic table
        function (connection, callback) {
            dbc = connection;
            var params = {
                UserID: userId,
                ReferenceID: referenceId,
                Type: type,
                Language: 'Viet Nam',
                ViewCount: 0,
                State: 1,
                ReviewStar: null,
                TopicTitle: topicTitle,
                TopicContent: topicContent,
                DateCreated: dateCreated,
                DateUpdated: dateUpdated
            };
            var query = "INSERT INTO Topic SET ?";
            dbc.query(query, params, callback);
        },

        // get the result
        function(result, rows, callback) {
            var topicId = result.insertId;
            callback(null, topicId);

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

module.exports.insertTopic = insertTopic;
module.exports.insertReply = insertReply;