/**
 * Created by Huynh Quang Thao on 7/25/15.
 */

var async = require('async');
var post_service = require('../../services/post_service');

module.exports.bookTest = function bookTest(callback) {
    async.waterfall([

        // insert tag
        function (callback) {
            // insert

        },

        // get post id and insert list of tags
        function (result, callback) {
        }
    ]);
};