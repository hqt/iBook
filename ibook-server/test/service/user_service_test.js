/**
 * Created by Huynh Quang Thao on 7/24/15.
 */

var async = require('async');
var user_service = require('../../services/user_service');

module.exports.userTest = function userTest() {
    async.waterfall([

        // insert user
        function (callback) {
            // insert author
            user_service.createUser('hqt', 'adminkdu', 'huynhquangthao@gmail.com', 'huynh', 'thao',
                'www.google.com', 'nothing impossible', '95$', 'www.google.com', 13, callback);
        },

        // get user id and remove user
        function (result, callback) {
            console.log('user id: ' + result);
            user_service.deleteUser(result, callback);
        },

        // get result
        function (result, callback) {
            console.log('affected rows: ' + result);
        }

    ]);
};