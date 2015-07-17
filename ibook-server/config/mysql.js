/**
 * Created by huynhthao on 7/6/15.
 */

var mysql = require('mysql');

var config = {
    host: 'localhost',
    username: 'root',
    password: 'root',
    port: 8889,
    database: "BookDB",
    connectionLimit: 10,
    charset: 'UTF8_GENERAL_CI',
    dialect: "mysql"
};


var pool = mysql.createPool({
   connectionLimit: config.connectionLimit,
    host     : config.host,
    user     : config.username,
    password : config.password,
    database : config.database,
    port     : config.port,
    charset  : config.charset,
    dialect  : config.dialect
});

// run this function for testing connection
var testConnection = function testConnection() {
    pool.getConnection(function(err, connection){
        if (err) {
            throw err;
        }

        connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {
            if (err) throw err;

            console.log('The solution is: ', rows[0].solution);

            connection.release();
        });
    });

};

testConnection();

module.exports.pool = pool;

