/**
 * Created by huynhthao on 7/6/15.
 */
var database_name = "BookDB";

var config = {
    host: 'localhost',
    user: 'root',
    password: 'fff',
    port: '8889',
    database: database_name,
    charset: 'UTF8_GENERAL_CI'
};

var mysql = require('mysql');

var connection = mysql.createConnection({
    user : 'root',
    password : "root",
    socketPath : '/Applications/MAMP/tmp/mysql/mysql.sock',
    database: 'BookDB',
    host: 'localhost',
    port: 8889

});

connection.connect(function(err) {
    if (err) {
        console.log('db_connection_err', err);
        return;
    } else {
        console.log('success');
    }
});

var knex = require('knex')({
    client: 'mysql',
    connection: {
        host     : 'localhost',
        user     : 'root',
        password : 'root',
        database : 'BookDB',
        charset  : 'utf8',
        port: 8889,
        socketPath: '/Applications/MAMP/tmp/mysql/mysql.sock'
    }
});

console.log('knex:' + knex);

var Bookshelf = require('bookshelf')(knex);

console.log('bookshelf: ' + Bookshelf);

var User = Bookshelf.Model.extend({
    tableName: 'users'
});

console.log('user ' + User);

module.exports = Bookshelf;
module.exports = connection;