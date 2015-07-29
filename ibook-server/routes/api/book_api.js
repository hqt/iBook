/**
 * Created by Huynh Quang Thao on 7/28/15.
 */

var async = require('async');
var pool = require('../../config/mysql').pool;
//var string_helper = require('../../string_helper');

module.exports.getAllBookGenre = function getAllBookGenre (req, res) {
    var dbc;
    async.waterfall([
        function (callback) {
            pool.getConnection(callback);
        },
        function (connection, callback) {
            dbc = connection;
            var query = "SELECT GenreID, GenreName FROM Genre";
            dbc.query(query, [], callback);
        },
        function (results, fields, callback) {
            var genres = [];
            results.forEach(function (result) {
                var genre = {
                    id: result.GenreID,
                    genreName: result.GenreName
                };
                genres.push(genre);
            });
            callback(null, genres);
        }
    ], function (error, genres) {
        if (dbc) dbc.release();
        res.json(genres);
    });
};

module.exports.subscribeBookGenre = function subcribeBookGenre (req, res) {
    async.waterfall([

    ]);

};