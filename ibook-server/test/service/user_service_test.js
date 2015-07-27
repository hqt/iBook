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
            user_service.createUser('hqt', 'adminkdu', 'huynhquangthao@gmail.com', 'huynh', 'quang', 'thao','www.google.com', 1,
                'nothing impossible', '95$', 'abc',
                13,
                10, 1, callback);
        },

        // get user id and remove user
        function (result, callback) {
            console.log('user id: ' + result);
            user_service.deleteUser(result, callback);
        },

        // get result and check login
        function (result, callback) {
            console.log('affected rows: ' + result);
            user_service.isUserExist(10, 1, callback);
        },

        function (result, callback) {
            console.log('usr id: ' + result);
        }

    ]);
};