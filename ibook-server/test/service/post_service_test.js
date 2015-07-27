/**
 * Created by Huynh Quang Thao on 7/25/15.
 */

var async = require('async');
var post_service = require('../../services/post_service');

module.exports.postTest = function postTest(callback) {
    async.waterfall([

        // insert tag
        function (callback) {
            // insert
            post_service.insertTopic(1, 1, 1, 'how to become superman', 'really want', callback);

        },

        // get post id and insert list of tags
        function (result, callback) {
            console.log('inserted post id: ' + result);
        }
    ]);
};