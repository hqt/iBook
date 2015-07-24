/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

var async = require('async');
var user_service_test = require('../test/service/user_service_test');
var author_service_test = require('../test/service/author_service_test');
var tag_service_test = require('../test/service/tag_service_test');
var book_service_test = require('../test/service/book_service_test');

exports.newsFeed = function newsFeed (req, res) {
    console.log('new feeds');

    async.waterfall([

        function (callback) {
            //user_service_test.userTest(callback);
            //author_service_test.authorTest(callback);
            book_service_test.bookTest(callback);
        },

        function(callback) {
            console.log('done');
        }
    ]);
    res.render('post/index', {
        name: 'thao',
        school: 'FPT University',
        family: {
            sister: 'Pham Huong Lan'
        }});
};