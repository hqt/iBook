/**
 * Created by Huynh Quang Thao on 7/25/15.
 */

var async = require('async');
var tag_service = require('../../services/tag_service');

module.exports.tagTest = function tagTest(callback) {
    async.waterfall([

        // insert tag
        function (callback) {
            // insert
            tag_service.insertTag(null, 1, 'tieu thuyet', 'truyen cua kim dung la vi du', callback);
        },

        // get tag id and insert genre
        function (result, callback) {
            console.log('test tag id: ' + result);
            tag_service.insertGenre(null, 1, 'tieu thuyet', 'truyen cua kim dung la vi du', callback);
        },

        function (result, callback) {
            console.log('genre id: ' + result);
        }

    ]);
};