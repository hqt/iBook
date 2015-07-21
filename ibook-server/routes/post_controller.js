/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

var async = require('async');
var user_service = require('../services/user_service');

exports.newsFeed = function newsFeed (req, res) {
    console.log('new feeds');

    async.waterfall([
        // insert to database
        function(callback) {
            user_service.createUser('hqt', 'adminkdu', 'huynhquangthao@gmail.com', 'huynh', 'thao',
                'www.google.com', 'nothing impossible', '95$', 'www.google.com', 13, callback);
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