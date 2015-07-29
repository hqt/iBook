/**
 * Created by Huynh Quang Thao on 7/20/15.
 */

var async = require('async');
var pool = require('../config/mysql').pool;
var  constant = require('../config/constant');

var insertBook = function insertBook(authorId, genreId, authorPenName, genreName,
                                     bookName, bookPublisher, bookContent, bookYear, callback) {
    // database connection
    var dbc;
    var dateCreated = new Date();
    var dateUpdated = dateCreated;
    var postItemId;

    async.waterfall([
        // get connection
        function (callback) {
            pool.getConnection(callback);
        },

        // insert to PostItem table
        function (connection, callback) {
            dbc = connection;
            var params = {ItemType: constant.POST_TYPE.BOOK};
            var query = "INSERT INTO PostItem SET ?";
            dbc.query(query, params, callback);
        },

        // insert to BookSystem table
        function (result, rows, callback) {
            postItemId = result.insertId;
            var params = {
                BookSystemID:postItemId,
                BookSystemType: constant.POST_TYPE.BOOK
            };
            var query = "INSERT INTO BookSystem SET ?";
            dbc.query(query, params, callback);
        },

        // insert into book
        function (result, rows, callback) {
            var params = {
                BookID: postItemId,
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
            callback(null, postItemId);
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

var insertChapter = function insertChapter(bookId, chapterName, chapterContent, chapterDescription, callback) {
    var dbc;
    var postItemId;

    async.waterfall([
        function (callback) {
            pool.getConnection(callback);
        },

        // insert to PostItem table
        function (connection, callback) {
            dbc = connection;
            var params = {ItemType: constant.POST_TYPE.CHAPTER};
            var query = "INSERT INTO PostItem SET ?";
            dbc.query(query, params, callback);
        },

        // insert to BookSystem table
        function (result, rows, callback) {
            postItemId = result.insertId;
            var params = {
                BookSystemID: postItemId,
                BookSystemType: constant.POST_TYPE.CHAPTER
            };
            var query = "INSERT INTO BookSystem SET ?";
            dbc.query(query, params, callback);
        },

        // insert into book
        function (result, rows, callback) {
            var params = {
                ChapterID: postItemId,
                BookID: bookId,
                ChapterName: chapterName,
                ChapterContent: chapterContent,
                ChapterDescription: chapterDescription
            };
            var query = "INSERT INTO Chapter SET ?";
            dbc.query(query, params, callback);
        },

        // get query result
        function (result, rows, callback) {
            callback(null, postItemId);
        }
    ], function (error, userData) {
        if (dbc) dbc.release();
        if (error) {
            console.log('Error Inserting Chapter');
            console.log(error);
        } else {
            callback(null, userData);
        }
    });
};

var insertQuote = function insertQuote(userId, quoteForId, quoteContent, certificated, callback) {
    var dbc;
    var postItemId;
    var dateCreated = new Date();

    async.waterfall([
        function (callback) {
            pool.getConnection(callback);
        },

        // insert to PostItem table
        function (connection, callback) {
            dbc = connection;
            var params = {ItemType: constant.POST_TYPE.QUOTE};
            var query = "INSERT INTO PostItem SET ?";
            dbc.query(query, params, callback);
        },

        // insert to BookSystem table
        function (result, rows, callback) {
            postItemId = result.insertId;
            var params = {
                BookSystemID: postItemId,
                BookSystemType: constant.POST_TYPE.QUOTE
            };
            var query = "INSERT INTO BookSystem SET ?";
            dbc.query(query, params, callback);
        },

        // insert into book
        function (result, rows, callback) {
            var params = {
                QuoteID: postItemId,
                UserID: userId,
                QuoteForID: quoteForId,
                QuoteContent: quoteContent,
                Certificated: certificated,
                DateCreated: dateCreated
            };
            var query = "INSERT INTO Quote SET ?";
            dbc.query(query, params, callback);
        },

        // get query result
        function (result, rows, callback) {
            callback(null, postItemId);
        }
    ], function (error, userData) {
        if (dbc) dbc.release();
        if (error) {
            console.log('Error Inserting Quote');
            console.log(error);
        } else {
            callback(null, userData);
        }
    });
};

module.exports.insertBook = insertBook;
module.exports.insertChapter = insertChapter;
module.exports.insertQuote = insertQuote;