/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

var async = require('async');
var pool = require('../config/mysql').pool;

var insertBook = function insertBook(authorId, genreId, authorPenName, genreName,
                                     bookName, bookPublisher, bookContent, bookYear, callback) {
    // database connection
    var dbc;
    var dateCreated = new Date();
    var dateUpdated = dateCreated;

    async.waterfall([
        // get connection
        function (callback) {
            pool.getConnection(callback);
        },

        // insert to book table
        function (connection, callback) {
            dbc = connection;
            var params = {
                AuthorID: authorId,
                GenreID: genreId,
                AuthorPenName: authorPenName,
                GenreName: genreName,
                BookName: bookName,
                BookPublisher: bookPublisher,
                BookContent: bookContent,
                BookYear: bookYear,
                DateCreated: dateCreated,
                DateUpdated: dateUpdated
            };
            var query = "INSERT INTO Book SET ?";
            dbc.query(query, params, callback);
        },

        // get query result
        function (result, rows, callback) {
            var bookId = result.insertId;
            callback(null, bookId);
        }

    ],  function (error, userData) {
        if (dbc) dbc.release();
        if (error) {
            console.log('Error Inserting Book');
            console.log(error);
        } else {
            callback(null, userData);
        }
    });

};

module.exports.insertBook = insertBook;