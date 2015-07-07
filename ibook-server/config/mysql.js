/**
 * Created by huynhthao on 7/6/15.
 */
var database_name = "BookDB";

var config = {
    host: 'localhost',
    user: 'root',
    password: 'root',
    port: 8889,
    database: database_name,
    charset: 'UTF8_GENERAL_CI'
};

var knex = require('knex')({
    client: 'mysql',
    connection: config
});


var Bookshelf = require('bookshelf')(knex);

module.exports = Bookshelf;