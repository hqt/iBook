/**
 * Created by Huynh Quang Thao on 7/24/15.
 */

var async = require('async');
var author_service = require('../../services/author_service');

module.exports.authorTest = function authorTest(callback) {
    async.waterfall([

        // insert author
        function (callback) {
            // insert author
            author_service.insertAuthor('Nguyen', 'Nhat', 'Anh', '1993-01-14', 'Ho Chi Minh,', '0',
                'Nguyen Nhat Anh', 'Viet Nam', 'Writer', 'kinh van hoa', 'very friendly', callback);
        },

        // get author id
        function (result, callback) {
            console.log('test author id: ' + result);
        }

    ]);
};