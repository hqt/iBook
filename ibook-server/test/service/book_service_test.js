/**
 * Created by Huynh Quang Thao on 7/25/15.
 */

var async = require('async');
var book_service = require('../../services/book_service');

module.exports.bookTest = function bookTest(callback) {
    async.waterfall([

        // insert tag
        function (callback) {
            // insert
            book_service.insertBook(1, 1, 'nguyen nhat anh', 'tieu thuyet',
                'co gai den tu hom qua', 'nxb giao duc', 'very good', '1993-01-14', callback);
        },

        // get book id
        function (result, callback) {
            console.log('test book id: ' + result);
        }
    ]);
};