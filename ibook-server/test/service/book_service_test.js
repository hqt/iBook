/**
 * Created by Huynh Quang Thao on 7/25/15.
 */

var async = require('async');
var book_service = require('../../services/book_service');

module.exports.bookTest = function bookTest(callback) {
    async.waterfall([

        // insert book
        function (callback) {
            // insert
            book_service.insertBook(1, 1, 'nguyen nhat anh', 'tieu thuyet',
                'co gai den tu hom qua', 'nxb giao duc', 'very good', '1993-01-14', callback);
        },

        // get book id and insert chapter
        function (result, callback) {
            console.log('test book id: ' + result);
            book_service.insertChapter(result, "khong nha", "khoang nha la khong nha", "ko co gi de giai thih", callback);
        },

        // get chapter id and insert quote for this chapter
        function (result, callback) {
            console.log('test chapter id: ' + result);
            book_service.insertQuote(1, result, 'no thing wrong', 1, callback);
        },

        function (result, callback) {
            console.log('test quote id: ' + result);
        }
    ]);
};